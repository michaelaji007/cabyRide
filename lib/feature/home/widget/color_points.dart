import 'package:flutter/material.dart';

class PointsWithColor extends StatelessWidget {
  final Color? colour;
  final margin;
  PointsWithColor({this.colour, this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.0,
      width: 9.0,
      margin: margin,
      decoration: BoxDecoration(
          color: colour, borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

class Points extends StatelessWidget {
  const Points({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 33.0, top: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
//              margin: EdgeInsets.only(left: 100.0),

      height: 3.0,
      width: 3.0,
    );
  }
}
