import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:app_mqtt/storage/store.dart';

class SettingsView extends StatefulWidget {
   const SettingsView({super.key});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>{

    final TextEditingController _hostTextController = TextEditingController();
    final TextEditingController _portTextController = TextEditingController();
    final TextEditingController _userTextController = TextEditingController();
    final TextEditingController _passTextController = TextEditingController();
    final TextEditingController _ioTimeoutTextController = TextEditingController();
    final TextEditingController _keepAliveTextController = TextEditingController();
    final TextEditingController _prefixTextController = TextEditingController();

    //final Future _url = Settings.getSettingsValue('url').then(value);
    // final String _url = "srv2.clusterfly.ru";
    // final String _portValue = "9991";
    // final String _userName = "user_f73fd7c4";
    // final String _password = "pass_722e37c7";
    // final String _keepAlive = "60";
    // final String _prefix = "60";

    final box = Hive.box('SettingsBox');  

  Future<void> setValue(String key) async {
    await box.put(key, _hostTextController.text);
  }

  Future<String> getValue(String key) async {
    final value = box.get(key, defaultValue: '*');
    return value;
  }

  // Future<void> getValue2() async {
  //   final value2 = box.get("url", defaultValue: '*') as String;
  //   print(value2);
    
  // }

    @override
    void initState() {
      super.initState();
      getValue("url").then((value) => _hostTextController.text=value);
      getValue("port").then((value) => _portTextController.text=value);
      getValue("user").then((value) => _userTextController.text=value);
      getValue("password").then((value) => _passTextController.text=value);
      getValue("ioTimeout").then((value) => _ioTimeoutTextController.text=value);
      getValue("keepAlive").then((value) => _keepAliveTextController.text=value);
      getValue("prefix").then((value) => _prefixTextController.text=value);
      // _hostTextController.text = _url;
      // _portTextController.text = _portValue; 
      // _userTextController.text = _userName;  
      // _passTextController.text = _password; 
      // _keepAliveTextController.text = _keepAlive;
      // _prefixTextController.text = _prefix;
    }

    @override
    void dispose() {
      _hostTextController.dispose();
      _portTextController.dispose();
      _userTextController.dispose();
      _passTextController.dispose();
      _ioTimeoutTextController.dispose();
      _keepAliveTextController.dispose();
      _prefixTextController.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 92, 166, 226),
          title: const Text('MQTT_Settings'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15.0,),
              _buildTextFieldWith(_hostTextController, 'Broker address'),
              _buildTextFieldWith(_portTextController, 'Port'),
              _buildTextFieldWith(_userTextController, 'UserName'),
              _buildTextFieldWith(_passTextController, 'Password'),
              _buildTextFieldWith(_keepAliveTextController, 'IoTimeout'),
              _buildTextFieldWith(_keepAliveTextController, 'KeepAlive'),
              _buildTextFieldWith(_prefixTextController, 'Prefix'),
              const SizedBox(height: 25.0,),
              TextButton(
                                
                child: const Text('Save'),
                onPressed: () {
                  setValue("url");
                  setValue("port");
                  setValue("user");
                  setValue("password");
                  setValue("ioTimeout");
                  setValue("keepAlive");
                  setValue("prefix");
                },
              ),
            ],
          ),
        ),
      );
    }
  }
  

  
  
  


Widget _buildTextFieldWith(TextEditingController controller, String hintText) {
       
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15, top: 0, right: 15),
      child: TextField(
          enabled: true,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding:
                const EdgeInsets.only(left: 10, bottom: 0, top: 0, right: 10),
            labelText: hintText,
          )
        ),
    );
}