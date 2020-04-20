import 'package:asim/dbInfo.dart';
import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

asimColors col = asimColors();

class BookingPage{
  UserInfoDb userInfoDb;

  void setUser(UserInfoDb user) {
    this.userInfoDb = user;
  }

  Container specialistButton(String specialist){
    return Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(
                color: col.silver(),
                offset: Offset(0,0),
                blurRadius: 3.5,
              )]
          ),
          child: SizedBox(
            height: 50,
            width: 300,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(specialist.toUpperCase(), style: TextStyle(fontSize: 18),),
              onPressed: (){
                // do nothing for now
              },
            ),
          )
      );
  }

  Widget book(){
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: 690,
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                alignment: Alignment.centerLeft,
                child: Text("Choose a specialist",
                  style: TextStyle(
                      fontSize: 25,
                      color: col.asbestos(),
                      fontWeight: FontWeight.w300),
                ),
              ),
              specialistButton('Paediatrics'),
              specialistButton('Obstetrics & Gynaecology'),
              specialistButton('Internal Medicine'),
              specialistButton('E.N.T'),
              specialistButton('Neurology'),

            ],
          ),
        )
      ),
    );
  }
}