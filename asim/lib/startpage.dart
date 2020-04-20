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
import 'startpageWidgets.dart';
import 'appointmentpage.dart';
import 'bookingpage.dart';

asimColors col = new asimColors();
StartPageWidgets spwidgets = new StartPageWidgets();

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);

  static const String routeName = "/StartPage";

  final String title;

  @override
  StartPageState createState() => new StartPageState();
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

  @override
  Widget build(BuildContext context) {
    UserInfoDb userInfoDb = ModalRoute.of(context).settings.arguments;
    print("Start Page: User info pushed into route...");
    userInfoDb.printUser();

    AppointmentPage appPage = new AppointmentPage();
    appPage.setName(userInfoDb.name);

    ProfileDisplay profileDisplay = new ProfileDisplay();
    profileDisplay.setUser(userInfoDb);

    BookingPage bookingPage = new BookingPage();

    List<Widget> widgetOptions = <Widget>[
      appPage.page(),
      bookingPage.book(),
      profileDisplay.profile(),
    ];

    // appPage.setName(userInfoDb.name);
    userInfoDb.printUser();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'ASIM',
          style: GoogleFonts.abrilFatface(
            fontSize: 23,
            color: col.c64Purple(),
          ),
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