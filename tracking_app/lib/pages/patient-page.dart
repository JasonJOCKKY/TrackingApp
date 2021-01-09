import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracking_app/pages/patient-map-page.dart';
import 'package:tracking_app/pages/patient-permission-page.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with WidgetsBindingObserver {
  bool isLoadingStatus = true;
  bool isLoadingPosition = false;

  bool isServiceEnabled = false;
  bool isPermissionGranted = false;

  Stream<Position> positionStream;

  // Location Methods
  void openServiceSetting() {
    Geolocator.openLocationSettings();
  }

  void requestPermission() {
    Geolocator.requestPermission().then((permission) {
      if (permission != LocationPermission.always) {
        Geolocator.openAppSettings();
      }
    });
  }

  Future<bool> checkLocationStatus() async {
    isLoadingStatus = true;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    final permission = await Geolocator.checkPermission();
    isPermissionGranted = permission == LocationPermission.always;
    isLoadingStatus = false;

    log("permission = " + permission.toString());

    return isServiceEnabled && isPermissionGranted;
  }

  // Override Methods
  @override
  void initState() {
    super.initState();

    checkLocationStatus().then((value) {
      setState(() {});
    });

    // For observing app's lifecycle
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // When app is resumed
    if (state == AppLifecycleState.resumed) {
      checkLocationStatus().then((value) {
        setState(() {});
      });
    }
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
            isServiceEnabled: isServiceEnabled,
            isPermissionGranted: isPermissionGranted,
            openLoactionSetting: openServiceSetting,
            requestPermission: requestPermission,
          );
  }
}
