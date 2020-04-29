import 'package:asim/AvailableAppointmentsPage.dart';
import 'package:asim/dbInfo.dart';
import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

asimColors col = asimColors();

class BookingPage extends StatefulWidget {
  UserInfoDb userInfoDb;
  void setUser(UserInfoDb user){
    this.userInfoDb = user;
    print("setting user in booking page... ${userInfoDb.email}");
  }
  @override
  BookingPageState createState() => new BookingPageState(userInfoDb);

}

class BookingPageState extends State<BookingPage> {

  UserInfoDb userInfoDb;
  void setUser(UserInfoDb user){
    this.userInfoDb = user;
  }

  BookingPageState(UserInfoDb userInfoDb){
    this.userInfoDb = userInfoDb;
    this.setUser(userInfoDb);
    print("sending user thru constructor... ${userInfoDb.email}");
  }

  Future<List<AppointmentInfoDB>> _futureAppointments;


  Widget specialistButton(String specialist) {
    return Container(

        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
        child: SizedBox(
          height: 90,
          width: 340,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              specialist.toUpperCase(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            onPressed: () {
              // get available appointments
              setState(() {
                _futureAppointments = HttpConnect().getAppointments(specialist);
              });
              _futureAppointments.then((value) {
                print("Retrived ${value.length} appointments");
                List<AppointmentInfoDB> appointments = value;
                ArgumentBundle argumentBundle = new ArgumentBundle(appointments: appointments, userInfoDb: userInfoDb);
                Navigator.pushNamed(
                    context, AvailableAppointmentsPage.routeName,
                    arguments: argumentBundle);
              });
            },
          ),
        ));
  }

  Widget build(BuildContext context) {
    print("User in specialists page...");
    if(userInfoDb==null){
      print("User not passed :( ");
    }
    else{
      userInfoDb.printUser();
    }
    return SingleChildScrollView(
                child:  Container(
                  alignment: Alignment.topLeft,
              // height: 690,
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: /*(_futureAppointments == null)
                  ? */ Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Choose a specialist",
                      style: TextStyle(
                          fontSize: 25,
                          color: col.asbestos(),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  specialistButton('Paediatrics'),
                  specialistButton('Obstetrics & Gynaecology'),
                  specialistButton('Cardiology'),
                  specialistButton('E.N.T.'),
                  specialistButton('Nephrology'),
                ],
              )  /*: FutureBuilder<List<AppointmentInfoDB>>(
                future: _futureAppointments,
                builder: (context, snapshot) {
                  return  Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(),
                        )
                  );
                },
              ),*/
            ));

  }
}
