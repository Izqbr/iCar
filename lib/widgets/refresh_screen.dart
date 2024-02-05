import 'package:flutter/material.dart';
import 'package:app_mqtt/servises/local_notification_servis.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();



class RefVariant extends StatelessWidget {
  const RefVariant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,     
        backgroundColor: const Color.fromARGB(255, 92, 166, 226),
        title: const Text(
                      "iCar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.power_settings_new,size: 40, color: Color.fromARGB(255, 255, 255, 255),)
          )

        ],           
      
        ),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: const Color.fromARGB(255, 92, 166, 226),
          onRefresh: () => Future.delayed(const Duration(seconds: 1)),
            
            
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: Container(
                  color: const Color.fromARGB(255, 234, 244, 252),
                  child: const Center(
                    child: Text("No results found."),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }

  
  
}
class OnePage extends StatefulWidget {
  const OnePage({super.key});

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {

  @override
  void initState(){
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,     
        backgroundColor: const Color.fromARGB(255, 92, 166, 226),
        title: const Text(
                      "iCar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.power_settings_new,size: 40, color: Color.fromARGB(255, 255, 255, 255),)
          )

        ],           
      
        ),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: const Color.fromARGB(255, 92, 166, 226),
          onRefresh: refFunc,
            
            
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: Container(
                  color: const Color.fromARGB(255, 234, 244, 252),
                  child:  Center(
                    child: Column(
                      children: [
                        const Text("No results found."),
                        const SizedBox(height: 40),
                        TextButton(
                          onPressed: (){
                            Noti.showBigTextNotification(
                              id: 0,
                              title: "New message title", 
                              body: "Your long body", 
                              payload: 666,
                              fln: flutterLocalNotificationsPlugin);
                          },
                          child: const Text('Click'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> refFunc() async {await Future.delayed(const Duration(seconds: 1));}
}