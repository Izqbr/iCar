import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_mqtt/state/MQTTAppState.dart';
import 'widgets/home_screen.dart';
import 'widgets/settings_screen.dart';
import 'widgets/map_screen.dart';
import 'widgets/pin_screen.dart';
import 'widgets/home_screen_1.dart';
import 'widgets/topic_set.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
   

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
       
          
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/pin',
        routes:{
          '/pin': (context) => const PinCodeWidget(),
          '/': (context) =>  ChangeNotifierProvider<MQTTAppState>(
              create: (_) => MQTTAppState(),
              child: const MQTTView(),
            ),
          '/MyPage': (context) => const MyHomePage(), 
          '/settings': (context) =>  SettingsView(),
          '/map': (context) => const MapView(),
          '/topic':(context) => TopicSet(),
                },

       
    );
  }
}