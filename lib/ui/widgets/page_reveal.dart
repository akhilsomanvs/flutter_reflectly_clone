import 'dart:math';

import 'package:flutter/material.dart';

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;
  final Offset clickedGlobalPosition;

  PageReveal({this.revealPercent, this.child, this.clickedGlobalPosition});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealClipper(revealPercent: revealPercent, clickedPosition: clickedGlobalPosition),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;
  final Offset clickedPosition;

  CircleRevealClipper({this.clickedPosition, this.revealPercent});

  @override
  Rect getClip(Size size) {
    final epicenter = clickedPosition != null ? clickedPosition : Offset(size.width / 2, size.height * 0.9);
    //Distance between spicenter to top Corners
    double theta = atan(epicenter.dy / epicenter.dx);

    final distanceToCorner = epicenter.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return Rect.fromLTWH(epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
