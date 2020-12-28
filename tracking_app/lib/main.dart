import 'package:flutter/material.dart';
import 'package:tracking_app/pages/doctor_map_page.dart';
import 'package:tracking_app/pages/patient_map_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Tracking',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DoctorMapPage(),
    );
  }
}
