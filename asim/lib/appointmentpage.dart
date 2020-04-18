import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

asimColors col = asimColors();

class AppointmentPage {

  String name;

  AppointmentPage(){}

  void setName(String userFName){
    this.name = userFName;
  }

  Widget greeting() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Hello, ${this.name.split(' ')[0]}',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: col.asbestos(),
            height: 1.5,
          )),
    );
  }

  // @override
  Widget page(){
          return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                height: 690,
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
                            borderRadius: BorderRadius.circular(5),
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
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
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
           //  ),
           );
     //   });
  }
  }