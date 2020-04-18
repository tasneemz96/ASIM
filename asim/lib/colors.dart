import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class asimColors{
  Color c64Purple() {
    return Color(0xff706fd3);
  }

  Color gloomyPurple() {
    return Color(0xff8854d0);
  }

  Color asbestos() {
    return Color(0xff7f8c8d);
  }

  Color silver() {
    return Color(0xffbdc3c7);
  }

  Color antiFlashWhite(){
    return Color(0xfff1f2f6);
  }

  LinearGradient loginSignupBackground() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.3, 1],
        colors: [c64Purple(), gloomyPurple()]);
  }

}