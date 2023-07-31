import 'package:flutter/material.dart';


class Mapscreen extends StatelessWidget {
  const Mapscreen ({Key? key}) :super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Текущее положение'),
        ),
      
      backgroundColor: const Color.fromARGB(255, 233, 225, 224),
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Map page'),
              SizedBox(height: 15),
              // TextButton.icon(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.black),
              //     foregroundColor: MaterialStateProperty.all(Colors.white),
              //   ),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: const Icon(Icons.arrow_back_ios_new),
              //   label: const Text('Вернуться назад'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}