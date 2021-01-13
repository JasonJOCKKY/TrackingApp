import 'package:flutter/material.dart';

class PatientMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Patient Tracking',
              style: DefaultTextStyle.of(context).style.apply(
                  fontSizeFactor: 3.0, color: Theme.of(context).canvasColor),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text(
              'Switch To Doctor',
              style: DefaultTextStyle.of(context).style,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Log Out',
              style: DefaultTextStyle.of(context).style,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
