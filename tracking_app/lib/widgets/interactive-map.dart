import 'package:flutter/material.dart';

class InteractiveMap extends StatefulWidget {
  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image(
        image: AssetImage('assets/map.png'),
        fit: BoxFit.fitHeight,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class InteractiveMapController {
  // Public Methods
}
