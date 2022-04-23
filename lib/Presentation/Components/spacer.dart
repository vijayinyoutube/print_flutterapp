import 'package:flutter/material.dart';

class HeightSpacer extends StatelessWidget {
  final double myHeight;

  const HeightSpacer({Key? key, required this.myHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: myHeight,
    );
  }
}

class WidthSpacer extends StatelessWidget {
  final double myWidth;

  const WidthSpacer({Key? key, required this.myWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: myWidth,
    );
  }
}

