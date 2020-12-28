import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tracking_app/pages/patient_menu_page.dart';
import 'package:tracking_app/widgets/mapfab.dart';

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
      // appBar: AppBar(
      //   toolbarHeight: 0,
      // ),
      drawer: PatientMenuPage(),
      drawerEnableOpenDragGesture: false,
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        panel: _Panel(),
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
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Menu Button
                    MapFab(
                      onPressed: () {
                        this._scaffoldKey.currentState.openDrawer();
                      },
                      icon: Icons.menu,
                      isActive: false,
                    ),
                    // Visibility Button
                    MapFab(
                      onPressed: this.onGridToggle,
                      icon: Icons.visibility,
                      isActive: this.isGridVisible,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PanelState();
}

class _PanelState extends State<_Panel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 7,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ],
    );
  }
}
