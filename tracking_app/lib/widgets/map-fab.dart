import 'package:flutter/material.dart';

class MapFab extends StatelessWidget {
  const MapFab(
      {Key key, this.onPressed, this.icon, this.isActive, this.mini = false})
      : super(key: key);

  final Function onPressed;
  final IconData icon;
  final bool isActive;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    final color1 = Theme.of(context).canvasColor;
    final color2 = Theme.of(context).primaryColor;

    return FloatingActionButton(
      onPressed: this.onPressed,
      child: Icon(this.icon),
      backgroundColor: isActive ? color2 : color1,
      foregroundColor: isActive ? color1 : color2,
      mini: this.mini,
      heroTag: null,
    );
  }
}
