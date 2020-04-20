import 'package:asim/dbInfo.dart';
import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

asimColors col = asimColors();

class ProfileDisplay{
  UserInfoDb userInfoDb;

  void setUser(UserInfoDb user){
    this.userInfoDb = user;
  }

  Widget profile(){
    return Center(
      child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18, height: 2),
                text: "Name: ${userInfoDb.name} \n",
                children: <TextSpan>[
                  TextSpan(
                      text: "Date of birth: ${userInfoDb.dob} \n"
                  ),
                  TextSpan(
                    text: "Gender: ${userInfoDb.gender} \n",
                  ),
                  TextSpan(
                    text: "Phone: ${userInfoDb.phone} \n",
                  ),
                  TextSpan(
                    text: "Nationality: ${userInfoDb.nationality} \n",
                  ),
                  TextSpan(
                    text: "Insurance: ${userInfoDb.insurance} \n",
                  ),
                  TextSpan(
                    text: "Diabetes: ${userInfoDb.diabetes}\n",
                  ),
                  TextSpan(
                    text: "Hypertension: ${userInfoDb.hypertension}\n",
                  ),
                  TextSpan(
                    text: "Alcoholism: ${userInfoDb.alcoholism}\n",
                  )
                ]
            ),
          )
      ),
    );

  }
}