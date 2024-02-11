// import 'package:app_mqtt/redux/actions.dart';
// import 'package:app_mqtt/redux/app_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:app_mqtt/state/MQTTAppState.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// import 'package:redux/redux.dart';

class MQTTManager {
  // final Store<AppStateRedux> store = StoreProvider.of<AppStateRedux>();
  // Private instance of client
  final MQTTAppState _currentState;
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final int _port;
  final String _user;
  final String _pass;
  final String _keepAlive;
  // final String _oiTimeout;
  final String _topic;

  // Constructor
  // ignore: sort_constructors_first
  MQTTManager(
     {required String host,
      required int port,
      required String user,
      required String pass,
      required String keepAlive,
      // required String ioTimeout,
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
        _keepAlive = keepAlive,
        // _ioTimeout = ioTimeout,
         _topic = topic,
        _currentState = state;

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, _identifier);
    _client!.port = _port;
    // _client!.ioT
    _client!.keepAlivePeriod = int.parse(_keepAlive);
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
        .withWillTopic(_topic) // If you set this you must set a will message
        .withWillMessage('Connected_$_identifier')
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

  void publish(String top, String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(top, MqttQos.exactlyOnce, builder.payload!);
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
    _client!.subscribe('user_f73fd7c4/C5/ds0', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/ds1', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/ds2', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/ds3', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/vbat', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/timer', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/security', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/engine', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/uptime', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/ussl', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/ussd', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/rssi', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/C', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/CF', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/bracke', MqttQos.atLeastOnce);
    _client!.subscribe('user_f73fd7c4/C5/gearbox', MqttQos.atLeastOnce);
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
       
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('Received message: topic is ${c[0].topic}, payload is $pt');

      switch(c[0].topic){
        case 'user_f73fd7c4/C5/ds0':
          return _currentState.setDs0(pt);
        case 'user_f73fd7c4/C5/ds1':
          return _currentState.setDs1(pt);
        case 'user_f73fd7c4/C5/ds2':
          return _currentState.setDs2(pt);
        case 'user_f73fd7c4/C5/ds3':
          return _currentState.setDs3(pt); 
        case 'user_f73fd7c4/C5/vbat':
          return _currentState.setVbat(pt);       
        case 'user_f73fd7c4/C5/timer':
          return _currentState.setTimer(pt);
        case 'user_f73fd7c4/C5/security':
          return _currentState.setSecurity(pt); 
        case 'user_f73fd7c4/C5/engine':
          return _currentState.setEngine(pt); 
        case 'user_f73fd7c4/C5/uptime':
          return _currentState.setUptime(pt); 
        case 'user_f73fd7c4/C5/ussl':
          return _currentState.setUssl(pt);
        case 'user_f73fd7c4/C5/ussd':
          return _currentState.setUssd(pt); 
        case 'user_f73fd7c4/C5/rssi':
          return _currentState.setRssi(pt);
        case 'user_f73fd7c4/C5/C':
          return _currentState.setC(pt);
        case 'user_f73fd7c4/C5/CF':
          return _currentState.setCF(pt); 
        case 'user_f73fd7c4/C5/bracke':
          return _currentState.setBrackeStatus(pt); 
        case 'user_f73fd7c4/C5/gearbox':
          return _currentState.setGearboxStatus(pt);                       
      }
    });    
  }
}