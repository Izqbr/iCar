import 'package:flutter/material.dart';
import 'pin_screen.dart';
import 'map_screen.dart';
import 'settings_screen.dart';
import 'settings_mqtt.dart';
import 'settings_alarm.dart';
import 'package:provider/provider.dart';
//import 'package:hive/hive.dart';
//
// import 'package:my_app/mqtt/state/MQTTAppState.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:my_app/mqtt/state/MQTTAppState.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  
  //var box = Hive.box('MqttBox');
  var login;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context)=>login),
      ],
      child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context)=> const Pin(),
        '/main': (context)=> const Main(),
        '/settings_MQTT': (context)=>   MyCustomForm(),
        '/settings': (context)=> const Settings(),
        '/settings_ALARM': (context)=> const SettingsAlarm(),
        '/map': (context)=> const Mapscreen(),
        },
      ),
    ),
    
  );
}



class Main extends StatelessWidget {
  const Main ({Key? key}) : super(key: key);

  
  
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
          'iCar',
          style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
            ),
          ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero, 
            children:  <Widget>[
              const DrawerHeader(
                child: Text('Меню настроек'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ListTile(
              title: const Text('Настройки MQTT'),
              leading: const Icon(
                Icons.settings,
                ),
              onTap: () {
                Navigator.pushNamed(context, '/settings_MQTT');
              },
            ),
            
            ListTile(
              title: const Text('Настройки топиков'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),

            ListTile(
              title: const Text('Настройки сигнализации'),
              leading: const Icon(
                Icons.settings,
                ),
              onTap: () {
                Navigator.pushNamed(context, '/settings_ALARM');
              },
            ), 
           
            ],
          ),
        ), 
          
        
        body: SafeArea(
          child: Column(
            children: [
                //ЛОКАЦИЯ
              Row(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 16.0,
                  //     top: 16.0,
                      
                  //   ),
                    
                  //   child: Image.asset(
                  //     "assets/img/staying_mode_dark.png",
                  //     height: 50,
                  //     ),
                    
                  // ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0,top: 16.0,),
                    child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/map');
                            }, // Image tapped
                            splashColor: Colors.white10, // Splash color over image
                            child: Ink.image(
                                fit: BoxFit.cover, // Fixes border issues
                                width: 45,
                                height: 45,
                                image: const AssetImage('assets/img/staying_mode_dark.png'),
                      ),
                    ),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      top: 16.0,
                    ),
                    child: Text('Локация'),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              // СИМ КАРТВ
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Image.asset(
                        "assets/img/ic_sim_card_horizontal.png",
                        height: 30,
                        //width: 50,
                      ),
                    ),
                    const Text('99р'),
                  ],
                ),
              ),

              // АВТОМОБИЛЬ
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          //padding: 8.0,
                          //color: const Color.fromARGB(255, 255, 255, 255),
                          child: Image.asset(
                              "assets/img/car_full_body_square.png")),
                    ),
                  ],
                ),
              ),

              // ИНДИКАТОРЫ ТОРМОЗА И КПП
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset(
                      "assets/img/camper_status_brake_dark.png",
                      height: 30,
                      //width: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(
                      "assets/img/camper_status_parking_dark.png",
                      height: 30,
                      //width: 50,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 5,
              ),

              Container(
                height: 30,
                color: const Color.fromARGB(149, 173, 170, 170),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('GSM'),
                    Text('data1'),                    
                  ],
                ),
              ),

              // НИЖНИЕ КНОПКИ
              Stack(
              children: [
                
                Container(
                  child: Column(
                  children: <Widget>[
                  Container(
                    height: 80,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: IconButton(
                              onPressed: () {
                                // ignore: avoid_print
                                print('112');
                              },
                              icon: Image.asset(
                                "assets/img/command_2_button.png",
                                height: 100,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                  "assets/img/command_35_main_control_button.png")),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    
                    height: 80,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                  "assets/img/command_35_main_control_button.png")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                  "assets/img/command_1_button.png")),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
                
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 140,
                          height: 140,
                          child: MaterialButton(
                            shape: const CircleBorder(
                              side: BorderSide(
                                width: 2,
                                color: Colors.blue,
                                style: BorderStyle.solid,
                              ),
                            ),
                          child: const Text(
                            "Start",
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 214, 85),
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                            ),
                          ),
                          onPressed: (){}
                            
                          ),
                        ),
                    ),
                  ),
                
                  
                   
                
              ],
             ),
            
            
            
            ],
          ),
        ),
      ),
    );
  }
}
