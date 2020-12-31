import 'package:flutter/material.dart';
import 'package:tracking_app/pages/patient_menu_page.dart';
import 'package:tracking_app/widgets/mapfab.dart';
import 'package:tracking_app/widgets/topbar.dart';

class PatientMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatientMapPageState();
}

class _PatientMapPageState extends State<PatientMapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      drawer: PatientMenuPage(),
      drawerEnableOpenDragGesture: false,
      body: Stack(
        children: [
          // Background
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
          // Top Bar
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
