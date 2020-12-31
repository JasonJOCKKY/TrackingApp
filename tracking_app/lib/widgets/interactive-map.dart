import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InteractiveMap extends StatefulWidget {
  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(45.521563, -122.677433),
        zoom: 11.0,
      ),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      rotateGesturesEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}

class InteractiveMapController {
  // Public Methods
}

// return Container(
//   alignment: Alignment.center,
//   child: Image(
//     image: AssetImage('assets/map.png'),
//     fit: BoxFit.fitHeight,
//     width: double.infinity,
//     height: double.infinity,
//   ),
// );
