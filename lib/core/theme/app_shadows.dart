
import 'package:flutter/material.dart';

class AppShadows {
  static  BoxShadow shadow_2xs = BoxShadow(
    //color: Color(0xff000000).withOpacity(0.05),
    offset: Offset(0, 1),
    blurRadius: 0,
    spreadRadius: 0,
  );
  static  BoxShadow shadow_xs = BoxShadow(
    //color: Color(0xff000000),
    offset: Offset(0, 1),
    blurRadius: 1,
    spreadRadius: 0,
  );
  static  BoxShadow shadow_sm = BoxShadow(
    //color: Color(0xff000000).withOpacity(0.1),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );


}