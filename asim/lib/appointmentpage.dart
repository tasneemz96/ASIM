import 'package:asim/dbInfo.dart';
import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'generaluse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

asimColors col = asimColors();

class AppointmentPage {
  String name;
  static UserInfoDb userInfoDb;

  AppointmentPage() {}


  List<String> userAppointments;

  void setName(String userFName) {
    this.name = userFName;
  }

   void setUser(UserInfoDb userInfoDb) {
    userInfoDb = userInfoDb;
    userAppointments = userInfoDb.appointments;
  }




  Future<List<AppointmentInfoDB>> _futureAppointments;

  Months months = new Months();

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

  List<AppointmentInfoDB> appointmentInfo;

  Widget apps() {
    _futureAppointments = HttpConnect().getPatientAppointments(userAppointments);
    _futureAppointments.then((value){
      appointmentInfo = value;
    });
    return (_futureAppointments == null)
        ? SingleChildScrollView(
            child: Center(
            child: Container(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          ))
        : FutureBuilder<List<AppointmentInfoDB>>(
            future: _futureAppointments,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(),
                        ),
                        Text("Retrieving your upcoming appointments...",
                        style: TextStyle(color: col.asbestos(), fontWeight: FontWeight.w300, height: 2),)
                      ],
                    ),);
              }
              else{
                List<AppointmentInfoDB> appointments = snapshot.data;
                return new Column(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: greeting(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 10, 10, 20),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text("Let's take a look at your upcoming appointments",
                          style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w600),),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border(bottom: BorderSide(color: col.c64Purple())),
                            boxShadow: [BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 5,
                            )]
                        ),
                      ),
                      (appointments.length > 0)? new Expanded(
                          child: ListView.builder(
                            itemCount: appointments.length,
                            itemBuilder: (BuildContext ctxt, int Index){
                              AppointmentInfoDB appointment = appointments[Index];
                              DateTime appointmentdate = appointment.appointmentdate;
                              String day = (appointmentdate.day < 10) ? "0${appointmentdate.day}" : "${appointmentdate.day}";
                              String month = months.stringifyMonth(appointmentdate.month);
                              String year = "${appointmentdate.year}";

                              String hour;
                              String minute = (appointmentdate.minute < 10) ? "0${appointmentdate.minute}" : "${appointmentdate.minute}";

                              String date;

                              if(appointmentdate.hour < 10){
                                hour = "0${appointmentdate.hour}";
                                date = "$day $month $year $hour:$minute AM";
                              }
                              else if(appointmentdate.hour < 12){
                                hour = "${appointmentdate.hour}";
                                date = "$day $month $year $hour:$minute AM";
                              }
                              else if(appointmentdate.hour == 12){
                                hour = "${appointmentdate.hour}";
                                date = "$day $month $year $hour:$minute PM";
                              }
                              else{
                                hour = "${appointmentdate.hour  - 12}";
                                date = "$day $month $year $hour:$minute PM";
                              }

                              return Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    //borderRadius: BorderRadius.circular(5),
                                    border: Border(bottom: BorderSide(color: Colors.black12)),
                                  ),
                                  child: ListTile(
                                      title: Text("${appointments[Index].doctor}", style: doctorName(),),
                                      subtitle: RichText(
                                          text: TextSpan(
                                              text: "${appointments[Index].specialization.toUpperCase()}\n",
                                              style: specializationLabel(),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "$date", style: info(),
                                                )
                                              ]
                                          )
                                      )
                                  ));
                            },
                          )
                      ) : Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Text("No upcoming appointments", style: doctorName(),)
                      ),
                    ],


                  );

              }

            },
          );
  }

  TextStyle specializationLabel() {
    return TextStyle(
        color: col.asbestos(),
        fontSize: 14,
        height: 1.75,
        fontWeight: FontWeight.w300);
  }


  TextStyle doctorName() {
    return TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle info() {
    return TextStyle(
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }

  // @override
  Widget page() {
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
