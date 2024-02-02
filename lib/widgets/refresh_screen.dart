
import 'package:flutter/material.dart';

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
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 3));
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: Container(
                  color: Colors.blue,
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
