import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tracking_app/widgets/patient-menu-drawer.dart';
import 'package:tracking_app/widgets/map/interactive-map.dart';
import 'package:tracking_app/widgets/map-fab.dart';
import 'package:tracking_app/widgets/searchbar.dart';
import 'package:tracking_app/widgets/top-bar.dart';

class DoctorMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoctorMapPageState();
}

class _DoctorMapPageState extends State<DoctorMapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InteractiveMapController _mapController = InteractiveMapController();

  // Functions for Panel
  final double _defaultPanelHeight = 100;
  double _minPanelHeight;
  double _maxPanelHeight;

  // Functions for search bar
  final TextEditingController _searchBarController = TextEditingController();

  // Functions for FABs
  bool _isGridVisible = false;

  onGridToggle() {
    setState(() {
      _isGridVisible = !_isGridVisible;
    });
  }

  // Override Methods
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      drawer: PatientMenuDrawer(),
      drawerEnableOpenDragGesture: false,
      body: _panel(context),
    );
  }

  // Widget builder functions
  Widget _panel(context) {
    MediaQueryData _mq = MediaQuery.of(context);
    _minPanelHeight = _defaultPanelHeight + _mq.padding.bottom;
    _maxPanelHeight = _mq.size.height - _mq.padding.top - _mq.viewInsets.bottom;

    return SlidingUpPanel(
      minHeight: _minPanelHeight,
      maxHeight: _maxPanelHeight,
      body: _background(),
      panelBuilder: (sc) => _panelBody(sc),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  Widget _panelBody(ScrollController sc) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: 40,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: SearchBar(
            textController: _searchBarController,
            hintText: "Patient ID",
            onSearch: (str) => {},
          ),
        ),
      ],
    );
  }

  Widget _background() {
    return Stack(
      children: [
        InteractiveMap(
          controller: _mapController,
        ),
        // FABs
        _fabs(),
        // TopBar
        TopBar(),
      ],
    );
  }

  Widget _fabs() {
    final double _defaultPadding = 20;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(_defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Left Column
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Menu Button
                MapFab(
                  onPressed: () {
                    this._scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icons.menu,
                  isActive: false,
                ),
              ],
            ),
            // Right Column
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Visibility Button
                MapFab(
                  onPressed: this.onGridToggle,
                  icon: Icons.visibility,
                  isActive: this._isGridVisible,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
