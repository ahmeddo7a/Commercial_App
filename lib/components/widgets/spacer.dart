import 'package:flutter/material.dart';

class MySpacer extends StatelessWidget {
  final double theWidth;
  final double theHeight;
   const MySpacer(
      {
        Key? key,
        this.theHeight=0,
        this.theWidth=0,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: myHeight*theHeight,
      width: myWidth*theWidth,
    );
  }
}
