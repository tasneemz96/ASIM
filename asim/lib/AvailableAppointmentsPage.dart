import 'package:asim/appointmentpage.dart';
import 'package:asim/bookingpage.dart';
import 'package:asim/dbInfo.dart';
import 'package:asim/profiledisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generaluse.dart';
import 'loginsignupWidgets.dart';
import 'startpage.dart';
import 'package:asim/colors.dart';

import 'appointmentpage.dart';
import 'bookingpage.dart';
import 'package:asim/dbInfo.dart';
import 'package:flutter/cupertino.dart';

asimColors col = new asimColors();
Future<Map<String, dynamic>> _futureBook;

class AvailableAppointmentsPage extends StatefulWidget {
  AvailableAppointmentsPage({Key key, this.title}) : super(key: key);

  static const String routeName = "/AvailableAppointmentsPage";

  final String title;

  @override
  AvailableAppointmentsPageState createState() =>
      new AvailableAppointmentsPageState();
}

class AvailableAppointmentsPageState extends State<AvailableAppointmentsPage> {
  Widget build(BuildContext buildContext) {
    ArgumentBundle argumentBundle = ModalRoute.of(context).settings.arguments;
    List<AppointmentInfoDB> appointments = argumentBundle.appointments;
    UserInfoDb userInfoDb = argumentBundle.userInfoDb;
    print("passing user to available appointments page.. ");
    userInfoDb.printUser();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'ASIM',
          style: col.myTitleStyle(),
        ),
      ),
      body: (appointments.length > 0 ) ? new ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (BuildContext ctxt, int Index) {
            AppointmentInfoDB appointment = appointments[Index];
            String doctor = appointment.doctor;
            String specialization = appointment.specialization;
            String appointmentDate =
                "${appointment.appointmentdate.day} ${Months().stringifyMonth(appointment.appointmentdate.month)} ${appointment.appointmentdate.year}";
            String appointmentTime;
            String hour;
            String minute = (appointment.appointmentdate.minute < 10) ? "0${appointment.appointmentdate.minute}" : "${appointment.appointmentdate.minute}";
            if(appointment.appointmentdate.hour < 10){
              hour = "0${appointment.appointmentdate.hour}";
              appointmentTime = "$hour:$minute AM";
            }
            else if(appointment.appointmentdate.hour > 12){
              hour = "${appointment.appointmentdate.hour - 12}";
              appointmentTime = "$hour:$minute PM";
            }
            else if(appointment.appointmentdate.hour==12){
              hour = "${appointment.appointmentdate.hour}";
              appointmentTime = "$hour:$minute PM";
            }
            else{
              hour = "${appointment.appointmentdate.hour}";
              appointmentTime = "$hour:$minute AM";
            }

            return Container(
              margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: col.silver(),
                      offset: Offset(0, 0),
                      blurRadius: 3.5,
                    )
                  ]),
              child: FlatButton(
                  onPressed: () {
                    String confirm = "Confirm appointment";
                    return showDialog(
                        context: buildContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("$confirm"),
                              content: Text(
                                "Would you like to book an appointment with ${doctor} on ${appointmentDate} at $appointmentTime?",
                              ),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text(
                                    "Yes".toUpperCase(),
                                    style: TextStyle(
                                        color: col.c64Purple(), fontSize: 17),
                                  ),
                                  onPressed: () {
                                    _futureBook = HttpConnect()
                                        .bookAppointment(appointment, userInfoDb);
                                    _futureBook.then((value) {
                                      print("Login: Future object returned...");
                                      print("${value["success"]}");
                                      print("${value['patient']}");
                                      if (value["success"] == true) {
                                        print("successful booking");
                                        StartPageState s = new StartPageState(value['patient']);
                                        Navigator.pushNamed(
                                            context, StartPage.routeName,
                                            arguments: value['patient']).then((_){
                                              setState(() {
                                                StartPage.setUser(value['patient']);
                                              });
                                        });
                                      } else {
                                        print("failed booking");
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                                ),
                                new FlatButton(
                                  child: new Text(
                                    "Not now".toUpperCase(),
                                    style: TextStyle(
                                        color: col.c64Purple(), fontSize: 17),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]);
                        });
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "$doctor\n",
                          style: doctorName(),
                          children: <TextSpan>[
                            TextSpan(
                              text: "$specialization\n".toUpperCase(),
                              style: specializationLabel(),
                            ),
                            TextSpan(
                              text: "$appointmentDate $appointmentTime",
                              style: info(),
                            )
                          ]))),
            ); /* myListTile(
              doctor: doctor,
              specialization: specialization,
              appointmentDate: appointmentDate,
              appointmentTime: appointmentTime,
              appointment: appointments[Index],
              userInfoDb: userInfoDb,
            );*/
          }): Center(
      child: Text("No available appointments", style: info(),)
    )
    );
  }
}

class myListTile extends StatelessWidget {
  String doctor;
  String specialization;
  String appointmentDate;
  String appointmentTime;
  AppointmentInfoDB appointment;
  UserInfoDb userInfoDb;

  myListTile(
      {Key key,
      this.doctor,
      this.specialization,
      this.appointmentDate,
      this.appointmentTime,
      this.appointment,
      this.userInfoDb})
      : super(key: key);

  Widget build(BuildContext buildContext) {
    return Container(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: col.silver(),
                    offset: Offset(0, 0),
                    blurRadius: 3.5,
                  )
                ]),
            child: FlatButton(
                onPressed: () {
                  String confirm = "Confirm appointment";
                  return showDialog(
                      context: buildContext,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("$confirm"),
                            content: Text(
                              "Would you like to book an appointment with ${doctor} on ${appointmentDate} at $appointmentTime?",
                            ),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text(
                                  "Yes".toUpperCase(),
                                  style: TextStyle(
                                      color: col.c64Purple(), fontSize: 17),
                                ),
                                onPressed: () {
                                  _futureBook = HttpConnect()
                                      .bookAppointment(appointment, userInfoDb);
                                  _futureBook.then((value) {
                                    print("Login: Future object returned...");
                                    print("${value["success"]}");
                                    print("${value['patient']}");
                                    if (value["success"] == true) {
                                      print("successful booking");
                                      StartPageState s = new StartPageState(value['patient']);
                                      Navigator.pushNamed(
                                          context, StartPage.routeName,
                                          arguments: value['patient']);
                                    } else {
                                      print("failed booking");
                                      Navigator.of(context).pop();
                                    }
                                  });
                                },
                              ),
                              new FlatButton(
                                child: new Text(
                                  "Not now".toUpperCase(),
                                  style: TextStyle(
                                      color: col.c64Purple(), fontSize: 17),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ]);
                      });
                },
                child: RichText(
                    text: TextSpan(
                        text: "$doctor\n",
                        style: doctorName(),
                        children: <TextSpan>[
                      TextSpan(
                        text: "$specialization\n".toUpperCase(),
                        style: specializationLabel(),
                      ),
                      TextSpan(
                        text: "$appointmentDate $appointmentTime",
                        style: info(),
                      )
                    ]))),
          );
  }
}

TextStyle doctorName() {
  return TextStyle(
    color: Colors.black87,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

TextStyle specializationLabel() {
  return TextStyle(
      color: col.asbestos(),
      fontSize: 14,
      height: 1.75,
      fontWeight: FontWeight.w300);
}

TextStyle info() {
  return TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}
