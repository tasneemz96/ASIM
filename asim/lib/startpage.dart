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
import 'package:asim/colors.dart';

import 'appointmentpage.dart';
import 'bookingpage.dart';

asimColors col = new asimColors();

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);

  static const String routeName = "/StartPage";

  final String title;

  static UserInfoDb userInfoDb;
  static void setUser(UserInfoDb user){
    userInfoDb = user;
    // print("setting user in start page... ${userInfoDb.email}");
  }

  @override
  StartPageState createState() => new StartPageState(userInfoDb);
}



class StartPageState extends State<StartPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static String userFName = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  UserInfoDb userInfoDb;
  void setUser(UserInfoDb user){
    this.userInfoDb = user;
  }

  StartPageState(UserInfoDb userInfoDb){
    this.userInfoDb = userInfoDb;
    this.setUser(userInfoDb);
    // print("sending user thru constructor... ${userInfoDb.email}");
  }

  @override
  Widget build(BuildContext context) {
    userInfoDb = ModalRoute.of(context).settings.arguments;
    print("Start Page: User info pushed into route...");
    print("${userInfoDb}");

    AppointmentPage appPage = new AppointmentPage();
    appPage.setName(userInfoDb.name);
    appPage.setUser(userInfoDb);

    ProfileDisplay profileDisplay = new ProfileDisplay();
    profileDisplay.setUser(userInfoDb);

    BookingPage bookingPage = new BookingPage();
    bookingPage.setUser(userInfoDb);

    List<Widget> widgetOptions = <Widget>[
      appPage.apps(),
      bookingPage,
      profileDisplay.profile(),
    ];

    // appPage.setName(userInfoDb.name);
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
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      )/*widgetOptions.elementAt(_selectedIndex)*/,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.calendarTextOutline),
            title: Text('My Appointments',
                style: TextStyle(
                  fontSize: 12,
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.plusCircle,
              size: 50,
            ),
            title: Text('Book Appointment',
                style: TextStyle(
                  fontSize: 12,
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountCircleOutline),
            title: Text('My Profile',
                style: TextStyle(
                  fontSize: 12,
                )),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: col.c64Purple(),
        onTap: _onItemTapped,
      ),
    );
  }
}