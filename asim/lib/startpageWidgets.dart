import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generaluse.dart';
import 'loginsignupWidgets.dart';
import 'package:asim/colors.dart';
import 'hasappointment.dart';

asimColors col = new asimColors();
CheckAppointment checkAppointment = new CheckAppointment();

class StartPageWidgets {

  static Widget appointmentPage() {
    bool hasAppointment = true;

    if (!hasAppointment) {
      checkAppointment.noAppointment();
    } else {
      checkAppointment.hasAppointment();
    }
  }
  
}