import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generaluse.dart';
import 'loginsignupWidgets.dart';
import 'package:asim/colors.dart';

asimColors col = new asimColors();

class CheckAppointment {

  Widget greeting() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Hello Tasneem',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: col.asbestos(),
            height: 1.5,
          )),
    );
  }

  Widget noAppointment() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: viewportConstraints.maxWidth,
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    greeting(),
                    Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 300,
                        width: 300,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: col.silver(),
                                  offset: Offset(0, 2),
                                  blurRadius: 8.0)
                            ],
                            gradient: col.loginSignupBackground(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            MdiIcons.calendarCheckOutline,
                            color: Colors.white,
                            size: 150,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text('No upcoming appointments.',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Need an appointment? Click on \'Book Appointment\' below.',
                          style: TextStyle(
                            color: col.asbestos(),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      alignment: Alignment.topCenter,
                      child: Icon(
                        MdiIcons.arrowDown,
                        size: 100,
                        color: col.silver(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget hasAppointment(){
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: viewportConstraints.maxWidth,
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    greeting(),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Text('Upcoming Appointment',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 350,
                        height: 350,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          decoration: BoxDecoration(
                            gradient: col.loginSignupBackground(),
                            boxShadow: [
                              BoxShadow(
                                  color: col.silver(),
                                  offset: Offset(0, 2),
                                  blurRadius: 8.0)
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              /*Expanded(
                              child: */ Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.bottomLeft,
                                        margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Friday\n',
                                            style: TextStyle(
                                              // height: 1.5,
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '24 January 2020, 10:00 AM',
                                                  style: TextStyle(
                                                    height: 1.5,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16,
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    alignment: Alignment.topRight,
                                    child: Icon(MdiIcons.squareEditOutline,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              // ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    /*Expanded(
                                  child:*/ Container(
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                      child: Image.asset(
                                        'assets/images/doctor_icon.png',
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                    // ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        child: RichText(
                                          text: TextSpan(
                                              text: 'Appointment with\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white,
                                                  fontSize: 16),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Dr. Ben Cho\n',
                                                  style: TextStyle(
                                                      height: 1.5,
                                                      fontWeight: FontWeight.w800,
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                TextSpan(
                                                  text:
                                                  'Gynaecologist and Obstetrician',
                                                  style: TextStyle(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text('Click on the icon on the top right corner of your appointment card to edit or cancel the appointment',
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: col.asbestos(),
                          fontWeight: FontWeight.w300,
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}