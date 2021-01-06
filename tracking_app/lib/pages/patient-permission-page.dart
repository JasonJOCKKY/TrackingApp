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
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("Location Permission Denied"),
            Text(
                "Dear user, our app constantly collects your location data in the background and send it to our server in order to provide more accurate desease prevention data.  In order to use this app, please enable your cellphone's location service:\n1. Enable your cellphone's location service.\n2. Grant this app the permission to always access your location."),
            SettingButton(
              onPressed: null,
              lable: "Enable Location Service",
            ),
            SettingButton(
              onPressed: null,
              lable: "Grant Constant Permission",
            ),
          ],
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final Function() onPressed;
  final String lable;

  const SettingButton({Key key, this.onPressed, this.lable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width - 50;

    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.check_box_outline_blank),
      label: Text(lable),
      // color: Theme.of(context).primaryColor,
      // textColor: Theme.of(context).canvasColor,
    );
  }
}
