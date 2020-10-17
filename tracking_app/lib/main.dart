import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'service/location_service.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(locationEnabled),
            Text(locationString),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
