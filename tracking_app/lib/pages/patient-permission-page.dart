import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracking_app/pages/patient-map-page.dart';

class PatientPermissionPage extends StatefulWidget {
  final bool initialServiceENabled;
  final bool initialPermissionGranted;

  const PatientPermissionPage(
      {Key key, this.initialServiceENabled, this.initialPermissionGranted})
      : super(key: key);

  @override
  _PatientPermissionPageState createState() => _PatientPermissionPageState();
}

class _PatientPermissionPageState extends State<PatientPermissionPage> {
  Timer timer;

  bool isLoadingService = true;
  bool isLoadingPermission = true;

  bool isServiceEnabled = false;
  bool isPermissionGranted = false;

  List<bool> expansions = [false, false];

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

  @override
  void initState() {
    super.initState();

    log("initstate");
    timer = Timer.periodic(Duration(seconds: 1), (tmr) {
      Geolocator.isLocationServiceEnabled().then((result) {
        if (result != isServiceEnabled) {
          setState(() {
            isServiceEnabled = result;
            isLoadingService = false;
          });
        }
      });
      Geolocator.checkPermission().then((result) {
        if ((result == LocationPermission.always) != isPermissionGranted) {
          setState(() {
            isPermissionGranted = result == LocationPermission.always;
            isLoadingPermission = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    log("dispose");
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("build");

    // if (isServiceEnabled && isPermissionGranted) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => PatientMapPage()));
    //   return null;
    // }

    return Scaffold(
      body: isLoadingService || isLoadingPermission
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  HeaderBar(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      MediaQuery.of(context).padding.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dear User,",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Our app constantly collects your location data in the background and send it to our server in order to provide more accurate disease prevention data.  In order to use this app, please enable the following on your cell phone:",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 20),
                        ExpansionPanelList(
                          expansionCallback: (panelIndex, isExpanded) {
                            setState(() {
                              expansions[panelIndex] = !isExpanded;
                            });
                          },
                          children: [
                            expPanel(
                              onTap: isServiceEnabled
                                  ? null
                                  : Geolocator.openAppSettings,
                              label: "Enable Location Service",
                              icon: isServiceEnabled
                                  ? Icon(Icons.check)
                                  : Icon(Icons.check_box_outline_blank),
                              body:
                                  "Please go to your cell phone's settings and enable the location service.",
                              isExpanded: expansions[0],
                            ),
                            expPanel(
                              onTap: isPermissionGranted
                                  ? null
                                  : Geolocator.requestPermission,
                              label: "Grant Constant Permission",
                              icon: isPermissionGranted
                                  ? Icon(Icons.check)
                                  : Icon(Icons.check_box_outline_blank),
                              body:
                                  "Grant this app the permission to always access your location.",
                              isExpanded: expansions[1],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.logout),
                          label: Text("Log Out"),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Custom build methods
  ExpansionPanel expPanel(
      {Function() onTap,
      Icon icon,
      String label,
      String body,
      bool isExpanded}) {
    return ExpansionPanel(
      isExpanded: isExpanded,
      headerBuilder: (context, isExpanded) {
        return ListTile(
          onTap: onTap,
          title: Text(label),
          leading: icon,
          enabled: onTap != null,
        );
      },
      body: ListTile(
        title: Text(
            "Grant this app the permission to always access your location."),
        enabled: onTap != null,
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(10, 10 + topPadding, 10, 10),
      child: Text(
        "Location Permission Denied",
        style: Theme.of(context)
            .primaryTextTheme
            .headline2
            .apply(color: Colors.white),
      ),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
  }
}
