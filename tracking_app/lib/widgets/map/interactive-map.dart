import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DefaultCameras {
  // ignore: non_constant_identifier_names
  static final USA = CameraPosition(
    target: LatLng(37.9643, -91.8318),
    zoom: 6,
  );
}

class InteractiveMap extends StatefulWidget {
  final InteractiveMapController controller;
  final Function() onMapDrag;

  /// Show a marker for the current position on the map
  final bool showCurrentLocation;

  /// Trajectory
  final bool showGrid;
  final bool showTrajectory;

  const InteractiveMap({
    Key key,
    @required this.controller,
    this.showCurrentLocation = false,
    this.showGrid = false,
    this.showTrajectory = false,
    this.onMapDrag,
  }) : super(key: key);

  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  GoogleMapController _googleMapController;

  // Custom Functions

  // Override Functions
  @override
  void initState() {
    super.initState();

    // Set up the controller
    widget.controller.isReady = false;
    widget.controller.centerTo = centerTo;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        if (widget.onMapDrag != null) {
          widget.onMapDrag();
        }
      },
      child: GoogleMap(
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
        initialCameraPosition: DefaultCameras.USA,
        myLocationEnabled: widget.showCurrentLocation,
        myLocationButtonEnabled: false,
        rotateGesturesEnabled: false,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          _googleMapController = controller;
          widget.controller.isReady = true;
        },
      ),
    );
  }

  // Controller Functions
  void centerTo(double latitude, double longitude) {
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    )));
  }
}

class InteractiveMapController {
  // Public Methods
  bool isReady = false;

  /// Center the camera to a specified location
  Function(double latitude, double longitude) centerTo;
}
