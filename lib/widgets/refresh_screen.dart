// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
// import 'package:native_toast/native_toast.dart';
import 'package:tasty_toast/tasty_toast.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

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
            onPressed: ()=> showToast(context, "Default toast"),
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

  void show (context){
  showToast(context, "Default toast");
  }
  Future<void> refFunc() async {
          //EasyLoading.showToast('Toast');
          await Future.delayed(const Duration(seconds: 1));
          //showToast(context, "Default toast");
          // await NativeToast().makeText(
          //       message: "Refresh send",
          //       duration: NativeToast.shortLength,
          //     );
          // Fluttertoast.showToast(
          //   msg: "This is Center Short Toast",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0
          // );
        }
  
}
