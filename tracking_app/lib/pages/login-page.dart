import 'package:flutter/material.dart';
import 'package:tracking_app/pages/doctor-map-page.dart';
import 'package:tracking_app/pages/patient-page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientPage()));
              },
              icon: Icon(Icons.account_box),
              label: Text("Patient Login"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorMapPage()));
              },
              icon: Icon(Icons.medical_services),
              label: Text("Doctor Login"),
            ),
          ],
        ),
      ),
    );
  }
}
