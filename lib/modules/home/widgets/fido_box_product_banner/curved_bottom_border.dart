//
//
// import 'package:flutter/material.dart';
//
// class CurvedBottomBorder extends ShapeBorder {
//   @override
//   EdgeInsetsGeometry get dimensions => EdgeInsets.zero;
//
//   @override
//   Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
//     return getOuterPath(rect, textDirection: textDirection);
//   }
//
//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     final size = rect.size;
//     final path = Path();
//     path.lineTo(0, size.height - 30);
//     path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 30);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
//
//   @override
//   ShapeBorder scale(double t) => this;
// }