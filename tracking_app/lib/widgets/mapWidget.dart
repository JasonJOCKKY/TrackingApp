import 'package:flutter/material.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/map.png',
      fit: BoxFit.cover,
    );
  }
}
