import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_mqtt/mqtt.dart';
import 'package:app_mqtt/state/MQTTAppState.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:app_mqtt/widgets/settings_screen.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: prefer_typing_uninitialized_variables
  late final _hostValue;
  late final _portValue;
  late final _userValue;
  late final _passValue;
  late final _idValue;
  // late final _ioTimeoutValue;
  late final _keepAliveValue;
  late final _prefixValue;
  // late SettingsView settingsVariables;
  late MQTTAppState currentAppState;
  late MQTTManager manager;
  // final box = Hive.box('SettingsBox');
  @override
  void initState() {
    super.initState();
    SettingsViewState().getValue("url").then((value) => _hostValue=value);
    SettingsViewState().getIntValue("port").then((value) => _portValue=value);
    SettingsViewState().getValue("user").then((value) => _userValue=value);
    SettingsViewState().getValue("password").then((value) => _passValue=value);
    SettingsViewState().getValue("id").then((value) => _idValue=value);
    // const SettingsView().getValue("ioTimeout").then((value) => _ioTimeoutValue=value);
    SettingsViewState().getValue("keepAlive").then((value) => _keepAliveValue=value);
    SettingsViewState().getValue("prefix").then((value) => _prefixValue=value); 
    
  }

  @override
  void dispose() {
    
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    return Scaffold(
      appBar: AppBar(  
        centerTitle: true, 
        iconTheme: const IconThemeData(color: Colors.white),    
        backgroundColor: const Color.fromARGB(255, 92, 166, 226),
        title: const Text(
                      "iCar_v5.2",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
        actions: _onOff(currentAppState.getAppConnectionState),           
      ),
      drawer:  Drawer(
        shadowColor: Colors.amberAccent,
        surfaceTintColor: const Color.fromARGB(255, 92, 166, 226),
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 92, 166, 226),
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
            // ListTile(
            //   title: const Text('Topic'),
            //   leading: const Icon(
            //     Icons.settings,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, '/topic'),
            // ),
            // ListTile(
            //   title: const Text('Alarm Settings'),
            //   leading: const Icon(
            //     Icons.settings,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, '/settings'),
            // ),
            // ListTile(
            //   title: const Text('Настройки4'),
            //   leading: const Icon(
            //     Icons.settings,
            //   ),
            //   onTap: () => Navigator.pushNamed(context, '/settings'),
            // ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: const Color.fromARGB(255, 92, 166, 226),
        onRefresh: refreshComand, 
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
            child: Column(
              children: [
                _buildConnectionStateText(
                  _prepareStateMessageFrom(currentAppState.getAppConnectionState),currentAppState.getAppConnectionState),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [                  
                  _locationButton(currentAppState.getAppConnectionState),
                  const SizedBox(width: 10),
                  const Text('Geolocation'),
                ],
              ),
                // СИМ КАРТА
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _simButton(currentAppState.getAppConnectionState),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        const Text('Balance:'),
                        Text('${currentAppState.getUssd}р',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
              ),
                // Центр
                Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding:  const EdgeInsets.only(left: 20.0,right: 20.0),
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
                      Positioned(
                        left: 40.0,
                        bottom: 20.0,
                        // bottom: 0.0,
                        // right: 0.0,
                        child: Text('${currentAppState.getVbat}v'),
                      ),
                      // Positioned(
                      //   top: 70.0,
                      //   left: 150.0,
                      //   bottom: 30.0,
                      //   // bottom: 0.0,
                      //   // right: 0.0,
                      //   child: SizedBox(
                      //     width: 35,
                      //     height: 35,
                      //     //color: const Color.fromARGB(255, 86, 140, 201),
                      //     child: Image.asset("assets/img/term.png")
                      //   ),
                      // ),
                      _timerButton(currentAppState.getAppConnectionState),
                      
                      // Positioned(
                      //    //left: 0,
                      //   // bottom: 32.0,
                      //   //  top: 26.0,
                      //    right: -8,
                      //   child: RotatedBox(
                      //     quarterTurns: 3,
                      //     child: IconButton(
                      //       color: const Color.fromARGB(255, 92, 166, 226),
                      //       icon: const Icon(Icons.key,size: 35.0), 
                      //       onPressed: () {}, //=> newMethod(context),
                      //     ),
                      //   ),
                      // ),
                      // const Positioned(
                      //   // left: 40.0,
                      //    bottom: 39.0,
                      //   //  top: 26.0,
                      //     right: 115.0,
                      //   child: Text('25°С',style: TextStyle(
                      //       fontSize: 22,
                      //     ),
                      //   )
                        
                      // ),
                    ],
                    
                  ),
                ),
              ],
            ),
                ),
                // ИНДИКАТОРЫ ТОРМОЗА И КПП
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _brackeIcon(currentAppState.getAppConnectionState, currentAppState.getBrackeStatus),
                    _gearboxIcon(currentAppState.getAppConnectionState, currentAppState.getGearboxStatus)
                  ],
                ),
            
                const SizedBox(
                  height: 5,
                ),
                Container(
                height: 30,
                color: const Color.fromARGB(125, 224, 201, 201),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [                    
                    _viewInfoText(currentAppState.getRssi,'${currentAppState.getRssi}dB'),
                    // _viewInfoText(currentAppState.getVbat,'${currentAppState.getVbat}v'),
                    _viewInfoText(currentAppState.getC,'C:${currentAppState.getC}'),
                    _viewInfoText(currentAppState.getCF,'CF:${currentAppState.getCF}'),
                    Row(children: [
                        const Icon(Icons.thermostat_outlined),
                      _viewInfoText(currentAppState.getDs0,'${currentAppState.getDs0}°'),
                     ],
                    ),
                    
                    _viewInfoText(currentAppState.getDs1,'${currentAppState.getDs1}°'),
                    _viewInfoText(currentAppState.getDs2,'${currentAppState.getDs2}°'),
                    _viewInfoText(currentAppState.getDs3,'${currentAppState.getDs3}°'),
                    Row(
                      children: [
                        const Icon(Icons.access_time),
                        _viewInfoText(currentAppState.getUptime,'${currentAppState.getUptime}ч'),     
                      ],
                    ),
                    
                  ],
                ),
              ),
                // нижние кнопки
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
              
                _startButton(currentAppState.getAppConnectionState, currentAppState.getBrackeStatus, currentAppState.getGearboxStatus),
                Expanded(
              flex:2,
              child: Column(
                children: <Widget>[
                  _lockButton(currentAppState.getAppConnectionState,currentAppState.getSecurity),
                    Container(
                    width: 150,
                    height: 2,
                    color: const Color.fromARGB(255, 92, 166, 226),
                  ), 
                  _unlockButton(currentAppState.getAppConnectionState,currentAppState.getSecurity),
                    // IconButton(
                    // onPressed: (){},
                    // icon: const Icon(Icons.lock_open,
                    // size: 50.0,color: Color.fromARGB(255, 92, 166, 226)
                    // ),
                    // ),
                    
                ],
              )
                      ),
                    ],
                  ),
               
              
              ],
            ),
          ),
          ]
        ),
      )
    );
    
  }

  Widget _timerButton(MQTTAppConnectionState state){
    if (state == MQTTAppConnectionState.connected){
      return Positioned(
                        // left: 40.0,
                        // bottom: 32.0,
                         top: 26.0,
                        right: 75.0,
                        child: IconButton(
                          color: const Color.fromARGB(255, 92, 166, 226),
                          icon: const Icon(Icons.timer,size: 40.0), 
                          onPressed: ()  => newMethod(context),
                        ),
                      );
    } else {
      return const Positioned(
                        // left: 40.0,
                        // bottom: 32.0,
                         top: 26.0,
                        right: 75.0,
                        child: IconButton(
                          color: Color.fromARGB(255, 157, 158, 157),
                          icon: Icon(Icons.timer,size: 40.0), 
                          onPressed: null,
                        ),
                      );
    }
  }

  Widget _locationButton(MQTTAppConnectionState state){
    if(state == MQTTAppConnectionState.connected){
      return Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color:  const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/map');
                          _publishMessage('user_f73fd7c4/C5', 'comandlocation');
                        },
                        iconSize: 40,
                        icon: const Icon(Icons.location_on, 
                        color: Color.fromARGB(255, 207, 20, 6)
                        ),
                      ),
                    ),
                  );
    } else {
      return Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color:  const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                      child: const IconButton(
                        onPressed: null,
                        iconSize: 40,
                        icon: Icon(Icons.location_on, 
                        color: Color.fromARGB(255, 157, 158, 157),
                        ),
                      ),
                    ),
                  );
    }
  }
  
  Widget _simButton(MQTTAppConnectionState state){
    if (state == MQTTAppConnectionState.connected){
      return Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color:  const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: (){
                          _publishMessage('user_f73fd7c4/C5', 'comandbalans');
                        },
                        iconSize: 40,
                        icon: const Icon(Icons.sim_card, 
                        color: Color.fromARGB(255, 247, 243, 14)
                        ),
                      ),
                    ),
                  );
    } else {
      return Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color:  const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                      child: const IconButton(
                        onPressed: null,
                        iconSize: 40,
                        icon: Icon(Icons.sim_card, 
                        color: Color.fromARGB(255, 157, 158, 157),
                        ),
                      ),
                    ),
                  );
    }
  }
  
  Future<void> refreshComand() async {
    var state = currentAppState.getAppConnectionState;
    if (state == MQTTAppConnectionState.connected){
      _publishMessage('user_f73fd7c4/C5', 'comandRefresh');
      Future.delayed(const Duration(seconds: 4));
    } else {
      Future.delayed(const Duration(seconds: 4));
    }
  }

  List<Widget> _onOff(MQTTAppConnectionState state) {
    
      return  <Widget>[
        IconButton(
          icon: const Icon(
            Icons.power_settings_new,
          size: 40, 
          color:  Color.fromARGB(255, 255, 255, 255),
        ),
          onPressed: state == MQTTAppConnectionState.disconnected
                 ? _configureAndConnect
                 : _disconnect,
          
        )

      ];
        
  }

  Widget _buildConnectionStateText(String status,MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              color: const Color.fromARGB(255, 133, 255, 52),
              child: Text(status, textAlign: TextAlign.center)),
        ),
      ],
    );
      case MQTTAppConnectionState.connecting:
        return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              color: const Color.fromARGB(255, 255, 252, 82),
              child: Text(status, textAlign: TextAlign.center)),
        ),
      ],
    );
      case MQTTAppConnectionState.disconnected:
        return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              color: const Color.fromARGB(255, 255, 36, 36),
              child: Text(status, textAlign: TextAlign.center)),
        ),
      ],
    );
    }
    
  }

  String _prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        return 'Connected';
      case MQTTAppConnectionState.connecting:
        return 'Connecting';
      case MQTTAppConnectionState.disconnected:
        return 'Disconnected';
    }
  }
  
  Widget _startButton(MQTTAppConnectionState state, String state2, String state3){
    if (state == MQTTAppConnectionState.connected && state2 == 'lock0' && state3 == 'neutral'){
      return SizedBox(
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
              onPressed: (){
                _publishMessage('user_f73fd7c4/C5','comandstart');
              },
              child:  const Text("Start", 
                style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold
        )
                ),
              ),
            );
    } else if (state == MQTTAppConnectionState.connecting){
      return const SizedBox(
              width: 130,
              height: 130,
              child: MaterialButton(
                shape: CircleBorder(
                side: BorderSide(
                  width: 4,
                  color: Color.fromARGB(255, 92, 166, 226),
                  style: BorderStyle.solid,
                ),
              ),
              color: Color.fromARGB(255, 187, 94, 94),
              textColor:  Color.fromARGB(255, 81, 54, 201),
              onPressed: null,
              child:  Text("Wait", 
                style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold
        )
                ),
              ),
            );
    } else {
      return const SizedBox(
              width: 130,
              height: 130,
              child: MaterialButton(
                shape: CircleBorder(
                side: BorderSide(
                  width: 4,
                  color: Color.fromARGB(255, 92, 166, 226),
                  style: BorderStyle.solid,
                ),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              textColor: Color.fromARGB(255, 157, 158, 157),
              onPressed: null,
              child:  Text("Start", 
                style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold
        )
                ),
              ),
            );
    }
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

  Widget _viewInfoText(String state, String text) {
    if (state == '') {
      
      return  Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: false,
              child: Text(text),
            );
    } else {
      return  Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
              child: Text(text),
            );
    }
  }
  
  Widget _brackeIcon(MQTTAppConnectionState state, String state2){
    if(state == MQTTAppConnectionState.connected && state2 == 'lock0'){
      return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                "assets/img/brake_green.png",
                height: 30,
                //width: 50,
              ),
            );
    } else if(state == MQTTAppConnectionState.connected && state2 == 'lock1'){
      return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                "assets/img/brake_red.png",
                height: 30,
                //width: 50,
              ),
            );
  } else {
      return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  "assets/img/brake_grey.png",
                  height: 30,
                  //width: 50,
                ),
              );
  }
}

  Widget _gearboxIcon(MQTTAppConnectionState state, String state2){
    if(state == MQTTAppConnectionState.connected && state2 == 'nonneutral'){
      return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                "assets/img/parking_red.png",
                height: 30,
                //width: 50,
              ),
            );
    } else if(state == MQTTAppConnectionState.connected && state2 == 'neutral'){
      return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                "assets/img/parking_green.png",
                height: 30,
                //width: 50,
              ),
            );
  } else {
      return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  "assets/img/parking_grey.png",
                  height: 30,
                  //width: 50,
                ),
              );
  }
}

  Widget _lockButton(MQTTAppConnectionState state, String state2){
    if(state == MQTTAppConnectionState.connected && state2 == 'lock0') {
      return IconButton(          
          onPressed: (){},
          icon: const Icon(Icons.lock_outline,
          size: 50.0,color: Color.fromARGB(255, 92, 166, 226)
          ),
        );
    } else {
      return const IconButton(          
          onPressed: null,
          icon: Icon(Icons.lock_outline,
          size: 50.0,color: Color.fromARGB(255, 157, 158, 157),
          ),
        );
    }
  }

  Widget _unlockButton(MQTTAppConnectionState state, String state2){
    if(state == MQTTAppConnectionState.connected && state2 == 'lock1') {
      return IconButton(          
          onPressed: (){},
          icon: const Icon(Icons.lock_open,
          size: 50.0,color: Color.fromARGB(255, 92, 166, 226)
          ),
        );
    } else {
      return const IconButton(          
          onPressed: null,
          icon: Icon(Icons.lock_open,
          size: 50.0,color: Color.fromARGB(255, 157, 158, 157),
          ),
        );
    }
  }

  void _configureAndConnect() {
        
    manager = MQTTManager(
        host: _hostValue,
        port: _portValue,
        user: _userValue,
        pass: _passValue,
        topic: '$_prefixValue/c5',
        identifier: _idValue,
        state: currentAppState, 
        keepAlive: _keepAliveValue);
        // _ioTimeout: _ioTimeout),
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }

  void _publishMessage(String top, String text) {
    manager.publish(top, text);    
  }


}

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