import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'service/location_service.dart';
import 'widgets/mapfab.dart';

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

  // Functions for FABs
  bool isMapCentered = false;
  bool isGridVisible = false;
  bool isTimelineShown = false;

  onCenterToggle() {
    setState(() {
      isMapCentered = !isMapCentered;
    });
  }

  onGridToggle() {
    setState(() {
      isGridVisible = !isGridVisible;
    });
  }

  onTimelineTogger() {
    setState(() {
      isTimelineShown = !isTimelineShown;
    });
  }

  // Override Methods
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
      drawer: Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(locationEnabled),
            Text(locationString),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              verticalDirection: VerticalDirection.up,
              children: [
                MapFab(
                  onPressed: this.onCenterToggle,
                  icon: Icons.near_me,
                  isActive: this.isMapCentered,
                ),
              ],
            ),
            Column(
              verticalDirection: VerticalDirection.up,
              children: [
                MapFab(
                    onPressed: this.onGridToggle,
                    icon: Icons.visibility,
                    isActive: this.isGridVisible),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MapFab(
                    onPressed: this.onTimelineTogger,
                    icon: Icons.timeline,
                    isActive: this.isTimelineShown,
                    mini: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
