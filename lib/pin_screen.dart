import 'package:flutter/material.dart';
//import 'package:my_app/main.dart';

class Pin extends StatelessWidget {
  const Pin ({Key? key}) :super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 225, 224),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Pin Screen'),
              const SizedBox(height: 15),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/main');
                },
                icon: const Icon(Icons.keyboard),
                label: const Text('Вводим пин'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}