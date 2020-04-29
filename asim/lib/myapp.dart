import 'package:asim/startpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';
import 'loginsignup.dart';
import 'startpage.dart';
import 'AvailableAppointmentsPage.dart';

asimColors col = asimColors();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      StartPage.routeName: (BuildContext context) =>
      new StartPage(title: "StartPage"),
      AvailableAppointmentsPage.routeName: (BuildContext context) =>
      new AvailableAppointmentsPage(title: "AvailableAppointmentsPage"),
    };

    final String appTitle = "ASIM";

    return new MaterialApp(
      theme: ThemeData(
        canvasColor: col.antiFlashWhite(),
        accentColor: col.c64Purple(),
        primaryColor: col.c64Purple(),
        cursorColor: col.c64Purple(),
        iconTheme: IconThemeData(color: col.asbestos()),
      ),
      title: appTitle,
      home: new LoginSignup(),
      routes: routes,
    );
  }
}
