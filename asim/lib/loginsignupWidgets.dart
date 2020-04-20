import 'package:asim/colors.dart';
import 'package:asim/dbInfo.dart';
import 'package:flutter/material.dart';
import 'generaluse.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'generaluse.dart';
import 'loginsignup.dart';

Nationality countries = new Nationality();
LoginSignupState log = new LoginSignupState();
String nationalityValue;
UserInfoDb userInfoDb = UserInfoDb();

class LoginSignupWidgets {
  String e, n, d, p, g, nat, i, pwd;

  Widget email() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: TextFormField(
          focusNode: log.myFocusNode,
          controller: log.emailController,
          decoration: InputDecoration(
            icon: Icon(
              MdiIcons.email, color: col.asbestos(),
            ),
            labelText: "Email address",
            // hintText: 'Email address',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Enter email address';
            } else {
              e = value;
            }
            return null;
          },
        ));
  }

  Widget password() {
    return TextFormField(
      obscureText: true,
      controller: log.passwordController,
      decoration: InputDecoration(
          labelText: "Password",
          icon: Icon(
            MdiIcons.lockQuestion,
              color: col.asbestos()
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter password';
        } else {
          pwd = value;
        }
        return null;
      },
    );
  }



  Widget name() {
    return TextFormField(
      controller: log.nameController,
      decoration: InputDecoration(
          labelText: "Full name",
          icon: Icon(
            MdiIcons.account,
            color: col.asbestos(),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter full name';
        } else {
          n = value;
        }
        return null;
      },
    );
  }

  Widget phone() {
    return TextFormField(
      controller: log.phoneController,
      decoration: InputDecoration(
          labelText: "Phone number",
          prefixText: '+971',
          prefixStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          icon: Icon(
            MdiIcons.cellphone, color: col.asbestos()
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter phone number';
        } else {
          p = '971' + value;
        }
        return null;
      },
    );
  }

  Widget insurance() {
    return TextFormField(
      controller: log.insuranceController,
      decoration: InputDecoration(
          labelText: "Insurance company and type",
          icon: Icon(
            MdiIcons.handHeart, color: col.asbestos()
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter insurance details';
        } else {
          i = value;
        }
        return null;
      },
    );
  }
}
