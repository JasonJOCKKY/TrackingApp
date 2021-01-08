import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracking_app/pages/patient-map-page.dart';
import 'package:tracking_app/pages/patient-permission-page.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  bool isLoadingStatus = true;
  bool isLoadingPosition = true;

  bool isServiceEnabled = false;
  bool isPermissionGranted = false;

  Timer timer;
  Stream<Position> positionStream;

  // Location Methods
  void openServiceSetting() {
    Geolocator.openLocationSettings();
  }

  void requestPermission() {
    Geolocator.requestPermission().then((result) {
      setState(() {
        isPermissionGranted = result == LocationPermission.always;
      });
    });
  }

  Future<bool> checkLocationStatus() async {
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    isPermissionGranted =
        await Geolocator.checkPermission() == LocationPermission.always;

    return isServiceEnabled && isPermissionGranted;
  }

  Timer startStatusTimer() {
    return Timer.periodic(Duration(seconds: 1), (tmr) {
      checkLocationStatus().then((enabled) {
        if (enabled) {
          timer.cancel();
          if (positionStream == null) {
            positionStream = Geolocator.getPositionStream();
          }
        }
      });
    });
  }

  // Override Methods
  @override
  void initState() {
    super.initState();

    isLoadingStatus = true;
    checkLocationStatus().then((isEnabled) {
      isLoadingStatus = false;
      if (isEnabled) {
        positionStream = Geolocator.getPositionStream();
      } else {
        timer = startStatusTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Loading Screen
    if (isLoadingStatus || (!isLoadingStatus && isLoadingPosition)) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // Permission page or map page
    return isServiceEnabled && isPermissionGranted
        ? PatientMapPage()
        : PatientPermissionPage(
            initialServiceENabled: isServiceEnabled,
            initialPermissionGranted: isPermissionGranted,
          );
  }
}
