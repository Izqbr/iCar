import 'package:mqtt_client/mqtt_client.dart';
import 'package:app_mqtt/state/MQTTAppState.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManager {
  // Private instance of client
  final MQTTAppState _currentState;
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final int _port;
  final String _user;
  final String _pass;
  final String _topic;

  // Constructor
  // ignore: sort_constructors_first
  MQTTManager(
     {required String host,
      required int port,
      required String user,
      required String pass,
      required String topic,
      required String identifier,
      required MQTTAppState state
      }
    )
      : _identifier = identifier,
        _host = host,
        _port = port,
        _user = user,
        _pass = pass,
        _topic = topic,
        _currentState = state;

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, _identifier);
    _client!.port = _port;
    _client!.keepAlivePeriod = 60;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.setProtocolV311();
    _client!.logging(on: true);

    /// Add the successful connection callback
    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        //.authenticateAs(_user, _pass)
        .withClientIdentifier(_identifier)
        .withWillTopic('user_f73fd7c4/c5') // If you set this you must set a will message
        .withWillMessage('Connected_FlutterApp')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    //print('EXAMPLE::Mosquitto client connecting....');
    _client!.connectionMessage = connMess;
  }

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    try {
      print('"EXAMPLE::srv2.clusterfly.ru" start client connecting....');     
      _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await _client!.connect(_user,_pass);
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  } 

  void disconnect() {
    print('Disconnected');
    _client!.disconnect();
  }

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    print('EXAMPLE::Mosquitto client connected....');
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      // final MqttPublishMessage recMess = c![0].payload;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }
}