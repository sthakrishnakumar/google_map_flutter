import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSat = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            GoogleMap(
              mapType: isSat ? MapType.satellite : MapType.normal,
              initialCameraPosition: const CameraPosition(
                zoom: 14.46,
                target: LatLng(43.721998, -79.545075),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 20, top: 20),
              onPressed: () {
                setState(() {
                  isSat = !isSat;
                });
              },
              icon: Icon(
                Icons.map,
                size: 40,
                color: isSat ? Colors.white : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
