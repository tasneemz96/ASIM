import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'generaluse.dart';
import 'loginsignupWidgets.dart';
import 'package:asim/colors.dart';
import 'startpage.dart';
import 'dbInfo.dart';

Nationality countries = new Nationality();
Months months = new Months();
asimColors col = new asimColors();
LoginSignupWidgets lswidgets = LoginSignupWidgets();
UserInfoDb userInfoDb = UserInfoDb();
Future<UserInfoDb> _futureUser;

TextStyle myTitleStyle() {
  return GoogleFonts.abrilFatface(
    fontSize: 23,
    color: col.c64Purple(),
  );
}

class LoginSignup extends StatefulWidget {
  LoginSignup({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginSignupState createState() {
    return new LoginSignupState();
  }
}

class LoginSignupState extends State<LoginSignup> {
  final _formKeylogin = GlobalKey<FormState>();
  final _formKeysignup = GlobalKey<FormState>();

  String nationalityValue;

  String genderUser = 'Male';
  bool insurance_val = true;
  Genders _genders = Genders.male;
  Insurance _insurance = Insurance.yes;
  Handicap _handicap = Handicap.yes;

  String dobUser = " ";
  DateTime selectedDate = DateTime((DateTime.now().year - 18));
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime((DateTime.now().year - 18)));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dobUser =
            "${selectedDate.day} ${months.stringifyMonth(selectedDate.month.toInt())} ${selectedDate.year}";
      });
  }

  String stringifyGender(_genders) {
    switch (_genders) {
      case Genders.male:
        return "Male";
        break;
      case Genders.female:
        return 'Female';
        break;
    }
  }

  FocusNode myFocusNode;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final insuranceController = TextEditingController();

  String n = 'default'; // ??

  void initState() {
    super.initState();
    nationalityValue = countries.getCountries().first.toString();
    myFocusNode = FocusNode();
    emailController.addListener(() => {});
    passwordController.addListener(() => {});
    nameController.addListener(() {});
    phoneController.addListener(() => {});
    insuranceController.addListener(() => {});
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    insuranceController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }
  // ********************************** gender widget ********************************

  Widget _gender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          MdiIcons.genderMaleFemale,
        ),
        Radio(
          value: Genders.male,
          groupValue: _genders,
          onChanged: (Genders value) {
            setState(() {
              _genders = value;
              genderUser = stringifyGender(_genders);
            });
          },
        ),
        Text(
          'Male',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Radio(
            value: Genders.female,
            groupValue: _genders,
            onChanged: (Genders value) {
              setState(() {
                _genders = value;
                genderUser = stringifyGender(_genders);
              });
            },
          ),
        ),
        Text(
          'Female',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

  // ******************************* nationality widget ********************************************

  Widget _nationality() {
    var items = countries.getCountries().map((s) {
      return new DropdownMenuItem<String>(
        value: s,
        child: new FittedBox(
          fit: BoxFit.contain,
          child: Text(
            s,
            style: new TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          MdiIcons.earth,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(17.0, 0.0, 0.0, 0.0),
          child: Text(
            'Nationality',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: DropdownButton<String>(
              underline: Container(
                height: 1,
                color: col.asbestos(),
              ),
              value: nationalityValue,
              items: items,
              onChanged: (String s) {
                nationalityValue = s;
                setState(() {
                  nationalityValue = s;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  // **************************** date of birth widget ****************************************************

  Widget _dob() {
    // String m = months.stringifyMonth(selectedDate.month.toInt());
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          MdiIcons.calendar,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
          child: Text(
            'Date of birth',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: OutlineButton(
              child: Text(
                "${selectedDate.day} ${months.stringifyMonth(selectedDate.month.toInt())} ${selectedDate.year}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onPressed: () => _selectDate(context),
            )),
      ],
    );
  }
// ***************************** disease widget ************************************

  bool alcoholism_val = false;
  bool hypertension_val = false;
  bool diabetes_val = false;

  Widget disease() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 17.0, 0),
              child: Icon(MdiIcons.heartPulse),
            ),
            Flexible(
              child: Text(
                'Do you have a history of any of the following illnesses?',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(27, 0, 0, 0),
              child: Checkbox(
                value: diabetes_val,
                onChanged: (bool value) {
                  setState(() {
                    diabetes_val = value;
                  });
                },
              ),
            ),
            Text(
              'Diabetes',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(27, 0, 0, 0),
              child: Checkbox(
                value: hypertension_val,
                onChanged: (bool value) {
                  setState(() {
                    hypertension_val = value;
                  });
                },
              ),
            ),
            Text(
              'Hypertension',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(27, 0, 0, 0),
              child: Checkbox(
                value: alcoholism_val,
                onChanged: (bool value) {
                  setState(() {
                    alcoholism_val = value;
                  });
                },
              ),
            ),
            Text(
              'Alcoholism',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  // ******************************************insurance widget************************************



  Widget insurance() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              MdiIcons.handHeart,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 0, 0, 0),
              child: Text('Do you have health insurance?',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        Container(
            padding: EdgeInsets.fromLTRB(27.0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Radio(
                  value: Insurance.yes,
                  groupValue: _insurance,
                  onChanged: (Insurance value) {
                    setState(() {
                      _insurance = value;
                      insurance_val=true;

                    });
                  },
                ),
                Text(
                  'Yes',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Radio(
                    value: Insurance.no,
                    groupValue: _insurance,
                    onChanged: (Insurance value) {
                      setState(() {
                        _insurance = value;
                        insurance_val = false;
                      });
                    },
                  ),
                ),
                Text(
                  'No',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            )),
      ],
    );
  }

  // ************************************handicap widget******************************************

  bool handicap_val = true;

  Widget handicap() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              MdiIcons.wheelchairAccessibility,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 0, 0, 0),
              child: Text('Are you a person of determination?',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        Container(
            padding: EdgeInsets.fromLTRB(27.0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Radio(
                  value: Handicap.yes,
                  groupValue: _handicap,
                  onChanged: (Handicap value) {
                    setState(() {
                      _handicap = value;
                      handicap_val = true;
                    });
                  },
                ),
                Text(
                  'Yes',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Radio(
                    value: Handicap.no,
                    groupValue: _handicap,
                    onChanged: (Handicap value) {
                      setState(() {
                        _handicap = value;
                        handicap_val = false;
                      });
                    },
                  ),
                ),
                Text(
                  'No',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            )),
      ],
    );
  }

  // **************************************** tab for login *****************************************

  Widget _loginForm() {
    return Form(
      key: _formKeylogin,
      child: (_futureUser == null)
          ? SingleChildScrollView(
              child: Container(
                color: col.antiFlashWhite(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 480),
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      lswidgets.email(),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: lswidgets.password(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: RaisedButton(
                            color: col.c64Purple(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            elevation: 0.0,
                            onPressed: () {
                              bool allGood = false;
                              if (_formKeylogin.currentState.validate()) {
                                allGood = true;
                              }
                              if (allGood) {
                                print(
                                    "Login: Captured login info: ${lswidgets.e}, ${lswidgets.pwd}");

                                setState(() {
                                  _futureUser = HttpConnect()
                                      .getUserProf(lswidgets.e, lswidgets.pwd);
                                });

                                _futureUser.then((value) {
                                  print("Login: Future object returned...");
                                  value.printUser();
                                  Navigator.pushNamed(
                                      context, StartPage.routeName,
                                      arguments: value);
                                });
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //),
            )
          : FutureBuilder<UserInfoDb>(
              future: _futureUser,
              builder: (context, snapshot) {
                  return Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(),
                      ));

              },
            ),
      //}),
    );
  }

  // ************************************************* tab for signup *************************************

  Widget _signupForm() {
    return Form(
      key: _formKeysignup,
      child: (_futureUser == null)
          ? SingleChildScrollView(
              child: Container(
                color: col.antiFlashWhite(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            'Registration',
                            style: TextStyle(
                              color: col.c64Purple(),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: lswidgets.email(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: lswidgets.password(),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            'Profile Details',
                            style: TextStyle(
                              color: col.c64Purple(),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: lswidgets.name(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: lswidgets.phone(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: _gender(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: _nationality(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: _dob(),
                      ),
                      /*Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: lswidgets.insurance(),
                      ),*/
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: disease(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: handicap(),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                        child: insurance(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: RaisedButton(
                            color: col.c64Purple(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            elevation: 0.0,
                            onPressed: () {
                              bool allGood = false;
                              if (_formKeysignup.currentState.validate()) {
                                allGood = true;
                              }
                              if (allGood) {
                                userInfoDb.setInfo(
                                    lswidgets.e,
                                    lswidgets.pwd,
                                    lswidgets.n,
                                    dobUser,
                                    genderUser,
                                    lswidgets.p,
                                    nationalityValue,
                                    insurance_val,
                                    handicap_val,
                                    diabetes_val,
                                    hypertension_val,
                                    alcoholism_val);
                                userInfoDb.printUser();
                                setState(() {
                                  _futureUser =
                                      HttpConnect().insertUser(userInfoDb);
                                });
                                _futureUser.then((value) {
                                  Navigator.pushNamed(
                                      context, StartPage.routeName,
                                      arguments: value);
                                });
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : FutureBuilder<UserInfoDb>(
              future: _futureUser,
              builder: (context, snapshot) {
                return Center(
                    child: Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ));
              },
            ),
    );
  }

  // ****************************************** build method with tabs *******************************
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: col.antiFlashWhite(),
          title: Text(
            'ASIM',
            style: myTitleStyle(),
          ),
          bottom: TabBar(
            indicatorColor: col.c64Purple(),
            tabs: [
              Tab(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 17,
                    color: col.c64Purple(),
                  ),
                ),
              ),
              Tab(
                  child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 17,
                  color: col.c64Purple(),
                ),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _loginForm(),
            _signupForm(),
          ],
        ),
      ),
    );
  }
}

List<String> genders = ['Male', 'Female'].toList();
List<bool> insurances = [true, false].toList();
List<bool> handicaps = [true, false].toList();
enum Genders { male, female }
enum Insurance { yes, no }
enum Handicap { yes, no }
