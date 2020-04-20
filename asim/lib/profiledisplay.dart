import 'package:asim/dbInfo.dart';
import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

asimColors col = asimColors();

class ProfileDisplay {
  UserInfoDb userInfoDb;

  void setUser(UserInfoDb user) {
    this.userInfoDb = user;
  }

  TextStyle info(){
    return TextStyle(
        color: Colors.black, fontSize: 16, height:1.15,
    );
  }
  TextStyle subheading(){
    return TextStyle(
      color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold,
    );
  }

  RichText medicalhistory(){
    if(!(userInfoDb.handicap || userInfoDb.diabetes || userInfoDb.hypertension || userInfoDb.alcoholism)){
      return RichText(
        text: TextSpan( text: 'No medical history' , style : info(),),
      );
    }
    else{
      return RichText(
        text: TextSpan(
          text: (userInfoDb.handicap) ? 'Is a person of determination\n' : '',
          style: info(),
          children: <TextSpan>[
            TextSpan(
              text: userInfoDb.diabetes ? 'Has a history of diabetes\n' : '',
              style: info(),
            ),
            TextSpan(
              text: userInfoDb.hypertension ? 'Has a history of hypertension\n' : '',
              style: info(),
            ),
            TextSpan(
              text: userInfoDb.alcoholism ? 'Has a history of alcoholism\n' : '',
              style: info(),
            )
          ]
        ),
      );
    }
  }


  Widget profile() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: 690,
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: col.silver(), offset: Offset(0, 0), blurRadius: 5.0)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  alignment: Alignment.center,
                  child: Text(
                    "${userInfoDb.name}",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: col.asbestos(),
                      height: 1.5,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Contact information'.toUpperCase(), style: subheading(), )
                ),

                Container(
                  child: RichText(
                      text: TextSpan(
                          text: 'Email\n',
                          style:
                          TextStyle(color: col.asbestos(), fontSize: 14, height: 2.3),
                          children: <TextSpan>[
                            TextSpan(
                              text:  "${userInfoDb.email}\n",
                              style: info(),
                            ),
                            TextSpan(
                              text: "Phone\n",
                            ),
                            TextSpan(
                              text: "${userInfoDb.phone}",
                              style: info(),
                            ),
                          ]
                      )
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: Text('Personal details'.toUpperCase(), style: subheading(), )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: RichText(
                    text: TextSpan(
                        style:
                        TextStyle(color: col.asbestos(), fontSize: 14, height: 2.3),
                        text: "Gender\n",
                        children: <TextSpan>[
                          TextSpan(
                            text: "${userInfoDb.gender}\n",
                            style: info(),
                          ),
                          TextSpan(
                            text: "Nationality\n",
                          ),
                          TextSpan(
                            text: "${userInfoDb.nationality}\n",
                            style: info(),
                          ),
                          TextSpan(
                            text: "Date of birth\n",
                          ),
                          TextSpan(
                            text:  "${userInfoDb.dob}\n",
                            style: info(),
                          ),
                          TextSpan(
                            text: "Insurance\n",
                          ),
                          TextSpan(
                            text: (userInfoDb.insurance) ? "Has health insurance" : "No health insurance",
                            style: info(),
                          ),
                        ]),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: Text('Medical history'.toUpperCase(), style: subheading(), )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: medicalhistory(),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
