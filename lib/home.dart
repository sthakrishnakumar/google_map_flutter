import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();
  bool isSat = false;
  static const destiationCameraPosition = CameraPosition(
    zoom: 14.46,
    target: LatLng(27.910433, 84.886283),
  );
  static const currentCameraPosition = CameraPosition(
    zoom: 14.46,
    target: LatLng(27.703097, 85.320373),
  );

  Set<Marker> markersList = {};
  int markerId = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                FloatingActionButton(
                  onPressed: gotoDes,
                  child: const Icon(Icons.man),
                ),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  onPressed: gotoPrev,
                  child: const Icon(Icons.location_on),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            GoogleMap(
              onTap: (latlng) {
                log('${latlng.latitude},${latlng.longitude}');
                setState(() {
                  markersList.add(
                    Marker(
                      markerId: MarkerId(markerId.toString()),
                      position: LatLng(latlng.latitude, latlng.longitude),
                      infoWindow: InfoWindow(
                        title: 'Bagbazar',
                        snippet: '${latlng.latitude},${latlng.longitude}',
                      ),
                    ),
                  );
                  markerId = markerId + 1;
                });
              },
              onMapCreated: onMapCreated,
              markers: markersList,
              mapType: isSat ? MapType.satellite : MapType.normal,
              initialCameraPosition: currentCameraPosition,
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

  void onMapCreated(GoogleMapController mapController) {
    _controller.complete(mapController);
  }

  Future gotoDes() async {
    GoogleMapController desController = await _controller.future;
    desController.animateCamera(
      CameraUpdate.newCameraPosition(destiationCameraPosition),
    );
  }

  Future gotoPrev() async {
    GoogleMapController prevController = await _controller.future;
    prevController.animateCamera(
      CameraUpdate.newCameraPosition(currentCameraPosition),
    );
  }
}
