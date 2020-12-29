import 'dart:ui';

import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData _mq = MediaQuery.of(context);
    double _width = _mq.size.width;
    double _height = _mq.padding.top;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          width: _width,
          height: _height,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
