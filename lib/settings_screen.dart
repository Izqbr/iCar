import 'package:flutter/material.dart';


class Settings extends StatelessWidget {
  const Settings ({Key? key}) :super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Настройки'),
        ),
      body: const SafeArea(
        child: Column(
          children: [
            // Container(
            //     color: const Color.fromARGB(255, 92, 166, 226),
            //     child: Row(
            //       //crossAxisAligment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         IconButton(
            //             color: const Color.fromARGB(255, 255, 255, 255),
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //             icon: const Icon(Icons.arrow_back_ios_new),
            //             ),
            //         const Text(
            //           "Настройки",

            //           style: TextStyle(
                        
            //             color: Color.fromARGB(255, 207, 201, 201),
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20,
            //           ),
            //         ),
                    
            //       ],
            //     ),
            //   ),
          ],
        ),
        
      ),
    );
  }
}







// child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('Settings page'),
//               TextButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.black),
//                   foregroundColor: MaterialStateProperty.all(Colors.white),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back_ios_new),
//                 label: const Text('Вернуться назад'),
//               ),
//             ],
//           ),
//         ),