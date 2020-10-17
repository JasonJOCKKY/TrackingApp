import 'package:flutter/material.dart';

class MapFAB extends StatefulWidget {
  MapFAB({Key key, this.icon, this.isMini, this.onPressed}) : super(key: key);

  final Icon icon;
  final bool isMini;
  final Function onPressed;

  @override
  _MapFABState createState() => _MapFABState();
}

class _MapFABState extends State<MapFAB> {
  bool _isActive = false;

  void _pressed() {
    setState(() {
      _isActive = !_isActive;
    });
    if (widget.onPressed != null) widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: _pressed,
          child: widget.icon,
          mini: widget.isMini,
          backgroundColor: _isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          foregroundColor: !_isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
        ));
  }
}
