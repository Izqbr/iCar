import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final controllerUrl = TextEditingController();
  final controllerPort = TextEditingController();
  final controllerUserName = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerIoTimeout = TextEditingController();
  final controllerKeepAlive = TextEditingController();
  final controllerClienID = TextEditingController();
  final controllerPrefix = TextEditingController();
  String url = '';

  final _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
//
    super.initState();

    // Start listening to changes.
    //controllerUrl.addListener();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    controllerUrl.dispose();
    super.dispose();
  }

  // void getValue() {
  //   url = mqttBox.get('url', defaultValue: '?????') as String;
  // }

  @override
  Widget build(BuildContext context) {


    Future<void>readValue(String key) async {
     // url = (await _secureStorage.read(key: v))!;
      String? stringOfItems = await _secureStorage.read(key: key);
      // ignore: avoid_print
      print (stringOfItems.toString());
      
      if(key == 'url') controllerUrl.text = stringOfItems!;
      if (key == 'port') controllerPort.text = stringOfItems!;
      if (key == 'user') controllerUserName.text = stringOfItems!;
      if (key == 'pass') controllerPassword.text = stringOfItems!;
      if(key == 'timeout') controllerIoTimeout.text = stringOfItems!;
      if (key == 'keepalive') controllerKeepAlive.text = stringOfItems!;
      if (key == 'id') controllerClienID.text = stringOfItems!;
      if (key == 'prefix') controllerPrefix.text = stringOfItems!;
      //controllerUrl.text = stringOfItems!;
      //return stringOfItems ;
    }

    Future<void> writeValue(String v, t) async {
      _secureStorage.write(
        key: v,
        value: t,
      );
    }
    readValue('url');
    readValue('port');
    readValue('user');
    readValue('pass');
    readValue('timeout');
    readValue('keepalive');
    readValue('id');
    readValue('prefix');
    
    controllerUrl.text = '';
    controllerPort.text = '';
    controllerUserName.text = '';
    controllerPassword.text = '';
    controllerIoTimeout.text = '';
    controllerKeepAlive.text = '';
    controllerClienID.text = 'Android_Client';
    controllerPrefix.text = '/';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки MQTT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          children: <Widget>[
            TextField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'URL'),
              controller: controllerUrl,
              onChanged: (text) {},
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'PORT'),
              controller: controllerPort,
              onChanged: (text) {},
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'UserName'),
              controller: controllerUserName,
              onChanged: (text) {},
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Password'),
              controller: controllerPassword,
              obscureText: true,
              obscuringCharacter: '•',
              onChanged: (text) {},
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'IoTimeout'),
              controller: controllerIoTimeout,
              onChanged: (text) {},
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'KeepAlive'),
              controller: controllerKeepAlive,
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'ClientID'),
              controller: controllerClienID,
            ),
            TextField(
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Prefix'),
              controller: controllerPrefix,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  writeValue('url', controllerUrl.text);
                  writeValue('port', controllerPort.text);
                  writeValue('user', controllerUserName.text);
                  writeValue('pass', controllerPassword.text);
                  writeValue('timeout', controllerIoTimeout.text);
                  writeValue('keepalive', controllerKeepAlive.text);
                  writeValue('id', controllerClienID.text);
                  writeValue('prefix', controllerPrefix.text);
                  _showToast(context);
                },
                //

                child: const Text('Сохранить'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Сохранено'),
        action: SnackBarAction(
          onPressed: scaffold.hideCurrentSnackBar,
          label: 'Ok',
        ),
      ),
    );
  }
}
