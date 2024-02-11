import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';



class MyHomePage extends StatelessWidget {
  const MyHomePage ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer:  Drawer(
        shadowColor: Colors.amberAccent,
        surfaceTintColor: const Color.fromARGB(255, 119, 8, 82),
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Header'),
            ),
            ListTile(
              title: const Text('MQTT Settings'),
              leading: const Icon(
                Icons.settings,
              ),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            ListTile(
              title: const Text('Topic'),
              leading: const Icon(
                Icons.settings,
              ),
              onTap: () => Navigator.pushNamed(context, '/topic'),
            ),
            ListTile(
              title: const Text('Alarm Settings'),
              leading: const Icon(
                Icons.settings,
              ),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            ListTile(
              title: const Text('Настройки4'),
              leading: const Icon(
                Icons.settings,
              ),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      
      body:  SafeArea(
          child: Column(
            
            children: [              
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        color: Colors.deepOrangeAccent,
                        child: const Text('status', textAlign: TextAlign.center)),
                  ),
                ],
              ),
              //ЛОКАЦИЯ
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 5.0,
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/img/staying_mode_dark.png",
                        height: 50,
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context,'/map');
                      },
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
          
              //const SizedBox(height: 5),
          
              // СИМ КАРТВ
               Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: IconButton(
                        icon: const Icon(
                          Icons.sim_card,
                          color: Color.fromARGB(255, 92, 166, 226),
                          size: 60.0,
                        ),
                        onPressed: (){},
                      ),
                    ),
                    const Text('99р'),
                  ],
                ),
              ),
          
              // АВТОМОБИЛЬ
              const CenterImage(),
          
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
                color: const Color.fromARGB(125, 224, 201, 201),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // StoreConnector<int,int>(
                    //   converter: (store) => store.state,
                    //   builder: (context, state) => Text(state.toString())
                    // ),
                    Text('data2'),
                    Text('data3'),
                  ],
                ),
              ),
              
              const SizedBox(height: 10.0),
              
              // НИЖНИЕ КНОПКИ
              Row(
                children: [
                  Expanded(
          flex:2,
          child: Column(
            children: <Widget>[
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.thermostat_auto_outlined,size: 50.0,color: Color.fromARGB(255, 92, 166, 226)),
                ),
              Container(
                width: 150,
                height: 2,
                color: const Color.fromARGB(255, 92, 166, 226),
              ),  
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.surround_sound_outlined ,size: 50.0,color: Color.fromARGB(255, 92, 166, 226)),
                ),
            ],
          )
                  ),
                  SizedBox(
                width: 130,
                height: 130,
                child: MaterialButton(
                  shape: const CircleBorder(
                  side: BorderSide(
                    width: 4,
                    color: Color.fromARGB(255, 92, 166, 226),
                    style: BorderStyle.solid,
                  ),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                textColor: const Color.fromARGB(255, 12, 207, 55),
                onPressed: (){},
                child:  const Text("Start", 
                  style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold
          )
                  ),
                ),
              ),
                  Expanded(
          flex:2,
          child: Column(
            children: <Widget>[
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.lock_outline,size: 50.0,color: Color.fromARGB(255, 92, 166, 226)),
                ),
                Container(
                width: 150,
                height: 2,
                color: const Color.fromARGB(255, 92, 166, 226),
              ), 
                IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/ref");
                },
                icon: const Icon(Icons.lock_open,
                size: 50.0,color: Color.fromARGB(255, 92, 166, 226)
                ),
                ),
                
            ],
          )
                  ),
                ],
              ),
              
              //const start_bottom(),
              const SizedBox(height: 10.0),
              
            ],
            
          ),
          
        )
        
    );
  }

  // Future<void> _refresh() { 
  //   return Future.delayed(const Duration(seconds: 4));
  // }
  
}

class CenterImage extends StatelessWidget {
  const CenterImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Image.asset("assets/img/car_full_body_square.png"),
                Positioned(
                  left: 40.0,
                  bottom: 32.0,
                  // bottom: 0.0,
                  // right: 0.0,
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    //color: const Color.fromARGB(255, 86, 140, 201),
                    child: Image.asset("assets/img/bat.png")
                  ),
                ),
                const Positioned(
                  left: 40.0,
                  bottom: 20.0,
                  // bottom: 0.0,
                  // right: 0.0,
                  child: Text("12,7v"),
                ),
                Positioned(
                  top: 70.0,
                  left: 150.0,
                  bottom: 30.0,
                  // bottom: 0.0,
                  // right: 0.0,
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    //color: const Color.fromARGB(255, 86, 140, 201),
                    child: Image.asset("assets/img/term.png")
                  ),
                ),
                Positioned(
                  // left: 40.0,
                  // bottom: 32.0,
                   top: 26.0,
                  right: 75.0,
                  child: IconButton(
                    color: const Color.fromARGB(255, 92, 166, 226),
                    icon: const Icon(Icons.timer,size: 40.0), 
                    onPressed: ()  => newMethod(context),
                  ),
                ),
                Positioned(
                   //left: 0,
                  // bottom: 32.0,
                  //  top: 26.0,
                   right: -8,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: IconButton(
                      color: const Color.fromARGB(255, 92, 166, 226),
                      icon: const Icon(Icons.key,size: 35.0), 
                      onPressed: () {}, //=> newMethod(context),
                    ),
                  ),
                ),
                const Positioned(
                  // left: 40.0,
                   bottom: 39.0,
                  //  top: 26.0,
                    right: 115.0,
                  child: Text('25°С',style: TextStyle(
                      fontSize: 22,
                    ),
                  )
                  
                ),
              ],
              
            ),
          ),
        ],
      ),
    );
  }
  Future<String?> newMethod(BuildContext context) {
    return showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Set Timer'),
                    content: const SliderExample(),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Set',
                        style: TextStyle(
                          color: Color.fromARGB(255, 92, 166, 226),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ],
                  ),
                );
  }
}

// class _Buttons extends StatelessWidget {
//   const _Buttons({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }

  
// }

// class start_bottom extends StatelessWidget {
//   const start_bottom({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       children: <Widget>[
//         Container(
//           height: 90,
//           color: const Color.fromARGB(139, 187, 172, 172),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: IconButton(
//                     onPressed: () {
//                       print('112');
//                     },
//                     icon: Image.asset(
//                       "assets/img/command_35_main_control_button.png",
//                       height: 100,
//                     )
//                   ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Image.asset("assets/img/command_35_main_control_button.png")
//                   ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 90,
//           color: const Color.fromARGB(138, 144, 158, 197),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Image.asset(
//                         "assets/img/command_35_main_control_button.png")),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: IconButton(
//                     onPressed: () => newMethod(context),
//                     icon: Image.asset(
//                         "assets/img/command_35_main_control_button.png")),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10.0),
        
        
//        ],
//       )
//     );
//   }















  
// }





class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Slider(
          activeColor: const Color.fromARGB(255, 92, 166, 226),
          value: _currentSliderValue,
          max: 30.0,
          divisions: 30,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
    );
    
  }
}
