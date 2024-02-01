//import 'package:app_mqtt/main.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_mqtt/mqtt.dart';
import 'package:app_mqtt/state/MQTTAppState.dart';
//import 'package:storage/store.dart';
// import 'package:mqtt_client/mqtt_client.dart';

class MQTTView extends StatefulWidget {
  const MQTTView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MQTTViewState();
  }
}

class _MQTTViewState extends State<MQTTView> {
  final TextEditingController _hostTextController = TextEditingController();
  final TextEditingController _portTextController = TextEditingController();
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();
  final TextEditingController _messageTextController = TextEditingController();
  final TextEditingController _topicTextController = TextEditingController();
  late MQTTAppState currentAppState;
  late MQTTManager manager;
 // late ExampleModel storage; 

  final String _url = "srv2.clusterfly.ru";
  final String _portValue = "9991";
  final String _userName = "user_f73fd7c4";
  final String _password = "pass_722e37c7";

  @override
  void initState() {
    super.initState();
    _hostTextController.text = _url;
    _portTextController.text = _portValue; 
    _userTextController.text = _userName;  
    _passTextController.text = _password; 
    /*
    _hostTextController.addListener(_printLatestValue);
    _messageTextController.addListener(_printLatestValue);
    _topicTextController.addListener(_printLatestValue);

     */
  }

  @override
  void dispose() {
    _hostTextController.dispose();
    _portTextController.dispose();
    _userTextController.dispose();
    _passTextController.dispose();
    _messageTextController.dispose();
    _topicTextController.dispose();
    super.dispose();
  }

  /*
  _printLatestValue() {
    print("Second text field: ${_hostTextController.text}");
    print("Second text field: ${_messageTextController.text}");
    print("Second text field: ${_topicTextController.text}");
  }

   */

  @override
  Widget build(BuildContext context) {
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    final Scaffold scaffold = Scaffold(body: _buildColumn());
    return scaffold;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('MQTT'),
      backgroundColor: Colors.greenAccent,
    );
  }

  Widget _buildColumn() {
    return Column(
      children: <Widget>[
        _buildConnectionStateText(
            _prepareStateMessageFrom(currentAppState.getAppConnectionState)),
        _buildEditableColumn(),
        _buildScrollableTextWith(currentAppState.getHistoryText)
      ],
    );
  }

  Widget _buildEditableColumn() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            _settings(),
            _map(),
            _homePage()
          ],),
          
          _buildTextFieldWith(_hostTextController, 'Enter broker address',
              currentAppState.getAppConnectionState),
          const SizedBox(height: 2),
          _textField(),
          const SizedBox(height: 2),
          _buildTextFieldWith(
              _topicTextController,
              'Enter a topic to subscribe or listen',
              currentAppState.getAppConnectionState),
          const SizedBox(height: 10),
          _buildPublishMessageRow(),
          const SizedBox(height: 10),
          _buildConnecteButtonFrom(currentAppState.getAppConnectionState)
        ],
      ),
    );
  }

  Widget _buildPublishMessageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: _buildTextFieldWith(_messageTextController, 'Enter a message',
              currentAppState.getAppConnectionState),
        ),
        _buildSendButtonFrom(currentAppState.getAppConnectionState)
      ],
    );
  }

  Widget _buildConnectionStateText(String status) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              color: Colors.deepOrangeAccent,
              child: Text(status, textAlign: TextAlign.center)),
        ),
      ],
    );
  }

  Widget _buildTextFieldWith(TextEditingController controller, String hintText,
      MQTTAppConnectionState state) {
    bool shouldEnable = false;
    if (controller == _messageTextController &&
        state == MQTTAppConnectionState.connected) {
      shouldEnable = true;
    } else if ((controller == _hostTextController &&
            state == MQTTAppConnectionState.disconnected) ||
        (controller == _topicTextController &&
            state == MQTTAppConnectionState.disconnected)) {
      shouldEnable = true;
    }
    return TextField(
        enabled: shouldEnable,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: hintText,
        ));
  }

  Widget _textField(){
    return Column(
      children: [
        TextField(
        enabled: true,
        controller: _portTextController ,
        decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: "port",
          )
        ),
        TextField(
        enabled: true,
        controller: _userTextController ,
        decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: "user",
          )
        ),
        TextField(
        enabled: true,
        controller: _passTextController ,
        decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: "password",
          )
        ),
      ],
    );
  }

  Widget _buildScrollableTextWith(String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 400,
        height: 200,
        child: SingleChildScrollView(
          child: Text(text),
        ),
      ),
    );
  }

  Widget _buildConnecteButtonFrom(MQTTAppConnectionState state) {
    return Row(
      children: <Widget>[
        Expanded(
          // ignore: deprecated_member_use
          child: TextButton(
            //color: Colors.lightBlueAccent,
            child: const Text('Connect'),
            onPressed: state == MQTTAppConnectionState.disconnected
                ? _configureAndConnect
                : null, //
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          // ignore: deprecated_member_use
          child: TextButton(
            //color: Colors.redAccent,
            child: const Text('Disconnect'),
            onPressed: state == MQTTAppConnectionState.connected
                ? _disconnect
                : null, //
          ),
        ),
      ],
    );
  }

  Widget _buildSendButtonFrom(MQTTAppConnectionState state) {
    // ignore: deprecated_member_use
    return TextButton(
      //color: Colors.green,
      child: const Text('Send'),
      onPressed: state == MQTTAppConnectionState.connected
          ? () {
              _publishMessage(_messageTextController.text);
            }
          : null, //
    );
  }

  Widget _settings(){
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed:  (){
        Navigator.pushNamed(context,'/settings');
      },
    );
  }

  Widget _map(){
    return IconButton(
      icon: const Icon(Icons.map),
      onPressed:  (){
        Navigator.pushNamed(context,'/map');
      },
    );
  }
  Widget _homePage(){
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed:  (){
        Navigator.pushNamed(context,'/MyPage');
      },
    );
  }
  // Utility functions
  String _prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        return 'Connected';
      case MQTTAppConnectionState.connecting:
        return 'Connecting';
      case MQTTAppConnectionState.disconnected:
        return 'Disconnected';
    }
  }
  




  void _configureAndConnect() {
    // ignore: flutter_style_todos
    // TODO: Use UUID
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    manager = MQTTManager(
        host: _hostTextController.text,
        port: int.parse(_portTextController.text),
        user: _userTextController.text,
        pass: _passTextController.text,
        topic: _topicTextController.text,
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }

  void _publishMessage(String text) {
    String osPrefix = 'Flutter_Android';
    
    final String message = '$osPrefix says: $text';
    manager.publish(message);
    _messageTextController.clear();
  }
}