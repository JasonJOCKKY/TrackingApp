import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tracking_app/widgets/mapFAB.dart';
import 'service/location_service.dart';
import 'widgets/mapWidget.dart';

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
      home: MyHomePage(title: 'Patient Tracking Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String locationEnabled = "The location service is not enabled.";
  String locationString = "N/A";

  onLocationUpdate(LocationData newLocation) {
    locationString =
        "Latitude: ${newLocation.latitude}\nLongitude: ${newLocation.longitude}";
  }

  @override
  void initState() {
    super.initState();

    serviceCheckLocationEnabled().then((bool locationIsEnabled) {
      if (locationIsEnabled) {
        setState(() {
          locationEnabled = "The location service is enabled!";
        });

        serviceLocationStream().listen((LocationData newLocation) {
          setState(() {
            onLocationUpdate(newLocation);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [MapWidget()],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MapFAB(
                    icon: Icon(Icons.near_me),
                    isMini: false,
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MapFAB(
                    icon: Icon(Icons.timeline),
                    isMini: true,
                  ),
                  MapFAB(
                    icon: Icon(Icons.visibility),
                    isMini: false,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
