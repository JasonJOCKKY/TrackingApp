import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tracking_app/pages/patient_menu_page.dart';
import 'package:tracking_app/widgets/mapfab.dart';
import 'package:tracking_app/widgets/topbar.dart';

class DoctorMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoctorMapPageState();
}

class _DoctorMapPageState extends State<DoctorMapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Functions for FABs
  bool isGridVisible = false;

  onGridToggle() {
    setState(() {
      isGridVisible = !isGridVisible;
    });
  }

  // Override Methods
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      drawer: PatientMenuPage(),
      drawerEnableOpenDragGesture: false,
      body: _panel(context),
    );
  }

  // Widget builder functions
  Widget _panel(context) {
    MediaQueryData _mq = MediaQuery.of(context);
    double _panelWidth = _mq.size.width;

    return SlidingUpPanel(
      // minHeight: _minPanelHeight,
      // maxHeight: _maxPanelHeight,
      body: _background(),
      header: _panelHeader(_panelWidth),
      panelBuilder: (sc) => _panelBody(sc),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  Widget _panelBody(ScrollController sc) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(""),
    );
  }

  Widget _panelHeader(double panelWidth) {
    return Container(
      width: panelWidth,
      child: Column(
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
          _textField(),
        ],
      ),
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.amber,
          child: Image(
            image: AssetImage('assets/map.png'),
            fit: BoxFit.fitHeight,
            width: double.infinity,
            height: double.infinity,
          ),
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
                  isActive: this.isGridVisible,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              textInputAction: TextInputAction.search,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                hintText: "Patient ID",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () => {},
          //   child: Text("Cancel"),
          // ),
        ],
      ),
    );
  }
}
