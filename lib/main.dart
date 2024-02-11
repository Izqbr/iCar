// import 'package:app_mqtt/widgets/refresh_screen.dart';
// import 'package:app_mqtt/redux/app_state.dart';
// import 'package:app_mqtt/redux/reducers.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:app_mqtt/state/MQTTAppState.dart';
import 'widgets/home_screen.dart';
import 'widgets/settings_screen.dart';
import 'widgets/map_screen.dart';
import 'widgets/topic_set.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
  await Hive.initFlutter();
  await Hive.openBox('SettingsBox');
  // final Store<AppStateRedux> store = Store(reducer,initialState: AppStateRedux(vbat: "14.3"));  
  runApp(const MyApp()
    );
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
   

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
       
          
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes:{
          // '/pin': (context) => const PinCodeWidget(),
          '/': (context) =>  ChangeNotifierProvider<MQTTAppState>(
              create: (_) => MQTTAppState(),
              child: const HomeView(),
            ),
          '/settings': (context) =>  const SettingsView(),
          '/map': (context) => const MapView(),
          '/topic':(context) => TopicSet(),
                },

       
    );
  }
}



