import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


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
  
  var mqttBox = Hive.box('myBox');
  
  

  @override
  void initState() {
//getValue();
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
  Widget build(BuildContext context)  {

   
    

    controllerUrl.text = mqttBox.get('url', defaultValue: '!!!!!!') as String;
    controllerPort.text = '9991';
    controllerUserName.text = 'myUserName';
    controllerPassword.text = '12345678';
    controllerIoTimeout.text = '10';
    controllerKeepAlive.text = '60';
    controllerClienID.text = 'Android_Client';
    controllerPrefix.text = '/';

    // void save() async {
    //  mqttBox.put('url', controllerUrl);
    //   mqttBox.close();
    // }
    // var mqttBox = Hive.openBox<String>('SetBox');


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
                onPressed: () => mqttBox.put('url', controllerUrl.text),
                 // _showToast(context);

                
                
                child: const Text('Сохранить'),
                ),
            ),
          
          ],
        ),
      ),
    );
    
  
  }
void _showToast(BuildContext context){
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Сохранено'),
          action: SnackBarAction(onPressed: scaffold.hideCurrentSnackBar, label: 'Ok',),
          ),
        );
    }
}
