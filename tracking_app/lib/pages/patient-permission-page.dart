import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientPermissionPage extends StatefulWidget {
  final bool isServiceEnabled;
  final bool isPermissionGranted;
  final Function() openLoactionSetting;
  final Function() requestPermission;

  const PatientPermissionPage(
      {Key key,
      this.isServiceEnabled,
      this.isPermissionGranted,
      this.openLoactionSetting,
      this.requestPermission})
      : super(key: key);

  @override
  _PatientPermissionPageState createState() => _PatientPermissionPageState();
}

class _PatientPermissionPageState extends State<PatientPermissionPage> {
  List<bool> expansions = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
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
                    "Our app constantly collects your location data in the background and send it to our server in order to provide more accurate disease prevention data.  In order to use this app, please enable the following on your cell phone:",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 20),
                  ExpansionPanelList(
                    expansionCallback: (panelIndex, isExpanded) {
                      setState(() {
                        expansions[panelIndex] = !isExpanded;
                      });
                    },
                    children: [
                      expPanel(
                        onTap: widget.isServiceEnabled
                            ? null
                            : widget.openLoactionSetting,
                        label: "Enable Location Service",
                        icon: widget.isServiceEnabled
                            ? Icon(Icons.check)
                            : Icon(Icons.check_box_outline_blank),
                        body:
                            "Please go to your cell phone's settings and enable the location service.",
                        isExpanded: expansions[0],
                      ),
                      expPanel(
                        onTap: widget.isPermissionGranted
                            ? null
                            : widget.requestPermission,
                        label: "Grant Constant Permission",
                        icon: widget.isPermissionGranted
                            ? Icon(Icons.check)
                            : Icon(Icons.check_box_outline_blank),
                        body:
                            "Grant this app the permission to always access your precise location in order to generate more reliable risk zones.",
                        isExpanded: expansions[1],
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
      {Function() onTap,
      Icon icon,
      String label,
      String body,
      bool isExpanded}) {
    return ExpansionPanel(
      isExpanded: isExpanded,
      headerBuilder: (context, isExpanded) {
        return ListTile(
          onTap: onTap,
          title: Text(label),
          leading: icon,
          enabled: onTap != null,
        );
      },
      body: ListTile(
        title: Text(body),
        enabled: onTap != null,
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
