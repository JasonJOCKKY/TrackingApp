import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracking_app/widgets/patient-menu-drawer.dart';
import 'package:tracking_app/widgets/map/interactive-map.dart';
import 'package:tracking_app/widgets/map-fab.dart';
import 'package:tracking_app/widgets/top-bar.dart';

class PatientMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatientMapPageState();
}

class _PatientMapPageState extends State<PatientMapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InteractiveMapController _mapController = InteractiveMapController();

  Stream<Position> _positionStream;

  // Keeps track of the last known location
  Position _currentPosition;

  // Functions for FABs
  bool _isMapCentered = true;
  bool _isGridVisible = false;
  bool _isTimelineShown = false;

  onCenterPressed() {
    setState(() {
      _isMapCentered = true;
      if (_currentPosition != null) {
        _mapController.centerTo(
            _currentPosition.latitude, _currentPosition.longitude);
      }
    });
  }

  onGridToggle() {
    setState(() {
      _isGridVisible = !_isGridVisible;
    });
  }

  onTimelineTogger() {
    setState(() {
      _isTimelineShown = !_isTimelineShown;
    });
  }

  // Custom Functions

  // Override Methods
  @override
  void initState() {
    super.initState();

    _positionStream = Geolocator.getPositionStream();
    _positionStream.listen((newPosition) {
      _currentPosition = newPosition;
      if (_isMapCentered && _mapController.isReady) {
        _mapController.centerTo(newPosition.latitude, newPosition.longitude);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      drawer: PatientMenuDrawer(),
      drawerEnableOpenDragGesture: false,
      body: Stack(
        children: [
          InteractiveMap(
            controller: _mapController,
            showCurrentLocation: true,
            onMapDrag: () {
              setState(() {
                _isMapCentered = false;
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
                  isActive: this._isMapCentered,
                ),
              ],
            ),
            Column(
              verticalDirection: VerticalDirection.up,
              children: [
                MapFab(
                    onPressed: this.onGridToggle,
                    icon: Icons.visibility,
                    isActive: this._isGridVisible),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MapFab(
                    onPressed: this.onTimelineTogger,
                    icon: Icons.timeline,
                    isActive: this._isTimelineShown,
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
