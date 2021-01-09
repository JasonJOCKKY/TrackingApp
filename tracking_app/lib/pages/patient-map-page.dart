import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracking_app/pages/patient-menu-page.dart';
import 'package:tracking_app/widgets/map/interactive-map.dart';
import 'package:tracking_app/widgets/map-fab.dart';
import 'package:tracking_app/widgets/topbar.dart';

class PatientMapPage extends StatefulWidget {
  // final Position initialLocation;

  // const PatientMapPage({Key key, this.initialLocation}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatientMapPageState();
}

class _PatientMapPageState extends State<PatientMapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InteractiveMapController _mapController = InteractiveMapController();

  Stream<Position> positionStream;

  // Keeps track of the last known location
  Position currentPosition;

  // Functions for FABs
  bool isMapCentered = true;
  bool isGridVisible = false;
  bool isTimelineShown = false;

  onCenterPressed() {
    setState(() {
      isMapCentered = true;
      if (currentPosition != null) {
        _mapController.centerTo(
            currentPosition.latitude, currentPosition.longitude);
      }
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

  // Custom Functions

  // Override Methods
  @override
  void initState() {
    super.initState();

    positionStream = Geolocator.getPositionStream();
    positionStream.listen((newPosition) {
      currentPosition = newPosition;
      if (isMapCentered && _mapController.isReady) {
        _mapController.centerTo(newPosition.latitude, newPosition.longitude);
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
            onMapDrag: () {
              setState(() {
                isMapCentered = false;
              });
            },
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
