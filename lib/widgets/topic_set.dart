import 'package:flutter/material.dart';


class TopicSet extends StatefulWidget {
   TopicSet({super.key});

  @override
  _TopicSetState createState() => _TopicSetState();
}

class _TopicSetState extends State<TopicSet>{

    final TextEditingController _hostTextController = TextEditingController();
    final TextEditingController _portTextController = TextEditingController();
    final TextEditingController _userTextController = TextEditingController();
    final TextEditingController _passTextController = TextEditingController();
    final TextEditingController _keepAliveTextController = TextEditingController();
    final TextEditingController _prefixTextController = TextEditingController();

    final String _url = "";
    final String _portValue = "";
    final String _userName = "";
    final String _password = "";
    final String _keepAlive = "";
    final String _prefix = "";

    @override
    void initState() {
      super.initState();
      _hostTextController.text = _url;
      _portTextController.text = _portValue; 
      _userTextController.text = _userName;  
      _passTextController.text = _password; 
      _keepAliveTextController.text = _keepAlive;
      _prefixTextController.text = _prefix;
    }

    @override
    void dispose() {
      _hostTextController.dispose();
      _portTextController.dispose();
      _userTextController.dispose();
      _passTextController.dispose();
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
              _buildTextFieldWith(_keepAliveTextController, 'KeepAlive'),
              _buildTextFieldWith(_prefixTextController, 'Prefix'),
              const SizedBox(height: 25.0,),
              TextButton(
                                
                child: const Text('Save'),
                onPressed:  (){
                  Navigator.pushNamed(context,'/');
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
            icon: const Icon(Icons.settings),
          )
        ),
    );
}