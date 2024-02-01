import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 118, 192, 253),
        title: const Text('Map'),
      ),
      body:  FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(47.289037, 39.763495),
          initialZoom: 17.0,
      ),
        children: [
          TileLayer(urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
          const MarkerLayer(
            markers: [
             Marker(
              width: 30.0,
              height: 30.0,
              point: LatLng(47.289037, 39.763495), 
              child: Icon(Icons.location_on, color: Color.fromARGB(255, 207, 20, 6), size: 50.0)
                  
                
              )
              //child: Icon(Icons.pin_drop, color: Colors.red)
             
            ]
          )
        ]
        
      )
    );  
  }
}