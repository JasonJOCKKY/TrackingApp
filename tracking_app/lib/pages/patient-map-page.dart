import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracking_app/pages/patient-menu-page.dart';
import 'package:tracking_app/widgets/map/interactive-map.dart';
import 'package:tracking_app/widgets/map-fab.dart';
import 'package:tracking_app/widgets/topbar.dart';

class PatientMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatientMapPageState();
}

class _PatientMapPageState extends State<PatientMapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InteractiveMapController _mapController = InteractiveMapController();

  // Functions for FABs
  // bool isMapCentered = false;
  bool isGridVisible = false;
  bool isTimelineShown = false;

  onCenterPressed() {
    _mapController.centerTo(
        currentPosition.latitude, currentPosition.longitude);
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

  // Custom Functions
  Position currentPosition;
  void onPositionChange(Position newPosition) {
    setState(() {
      currentPosition = newPosition;
    });
  }

  // Override Methods
  @override
  void initState() {
    super.initState();

    // Check Loaction Availability
    Geolocator.isLocationServiceEnabled().then((serviecEnabled) {
      if (serviecEnabled) {
        // Service Enabled
        Geolocator.checkPermission().then((permission) {
          if (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse) {
            // Always have permission
            Geolocator.getPositionStream(
              desiredAccuracy: LocationAccuracy.best,
            ).listen(onPositionChange);

            // Initialize the map
            Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.best)
                .then((newPosition) {
              _mapController.centerTo(
                  newPosition.latitude, newPosition.longitude);
            });
          } else {
            // Does Not Always have permission
            Geolocator.requestPermission();
          }
        });
      } else {
        // Service Not Enabled
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      drawer: PatientMenuPage(),
      drawerEnableOpenDragGesture: false,
      body: Stack(
        children: [
          InteractiveMap(
            controller: _mapController,
            showCurrentLocation: true,
          ),
          _fabs(),
          TopBar(),
        ],
      ),
    );
  }

  // Build Functions
  Widget _fabs() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Menu Button
                MapFab(
                  onPressed: () {
                    this._scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icons.menu,
                  isActive: false,
                ),
                // Center Button
                MapFab(
                  onPressed: this.onCenterPressed,
                  icon: Icons.near_me,
                  isActive: false,
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
