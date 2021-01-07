import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientPermissionPage extends StatefulWidget {
  final String patientName;

  const PatientPermissionPage({Key key, this.patientName}) : super(key: key);

  @override
  _PatientPermissionPageState createState() => _PatientPermissionPageState();
}

class _PatientPermissionPageState extends State<PatientPermissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderBar(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dear User,",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Our app constantly collects your location data in the background and send it to our server in order to provide more accurate disease prevention data.  In order to use this app, please enable the following on your cellphone:",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 20),
                  ExpansionPanelList(
                    expansionCallback: (panelIndex, isExpanded) {
                      log("expansion");
                    },
                    children: [
                      expPanel(
                        onTap: null,
                        label: "Enable Location Service",
                        icon: Icon(Icons.check_box_outline_blank),
                        body: "Enable your cellphone's location service.",
                      ),
                      expPanel(
                        onTap: null,
                        label: "Grant Constant Permission",
                        icon: Icon(Icons.check_box_outline_blank),
                        body:
                            "Grant this app the permission to always access your location.",
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    label: Text("Log Out"),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom build methods
  ExpansionPanel expPanel(
      {Function onTap, Icon icon, String label, String body}) {
    return ExpansionPanel(
      isExpanded: true,
      headerBuilder: (context, isExpanded) {
        return ListTile(
          onTap: () {},
          title: Text(label),
          leading: Icon(
            Icons.check_box_outline_blank,
          ),
        );
      },
      body: ListTile(
        title: Text(
            "Grant this app the permission to always access your location."),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(10, 10 + topPadding, 10, 10),
      child: Text(
        "Location Permission Denied",
        style: Theme.of(context)
            .primaryTextTheme
            .headline2
            .apply(color: Colors.white),
      ),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
  }
}
