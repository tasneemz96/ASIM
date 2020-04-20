import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './PasswordEncrypt.dart';

String serverURL = 'http://192.168.0.136:3000/app';

class UserInfoDb {
  String email;
  String password;
  String encryptedPassword;
  String name;
  String phone;
  String gender;
  String nationality;
  bool insurance;
  String dob;
  bool handicap;
  bool diabetes;
  bool hypertension;
  bool alcoholism;

  PasswordEncrypt passwordEncrypt = new PasswordEncrypt();

  UserInfoDb({this.email, this.password, this.name, this.phone, this.gender, this.nationality,
    this.insurance, this.dob, this.handicap, this.diabetes, this.alcoholism, this.hypertension});

  /*List<String> getAllInfo(){
    List<String> allInfo = [this.email, this.name, this.dob, this.gender, this.phone, this.nationality, this.insurance];
    return allInfo;
  }*/

  void printUser(){
    print("${this.email},"
        // "${this.password}, "
        "${this.encryptedPassword},"
        "${this.name},"
        "${this.dob},"
        "${this.gender},"
        "${this.phone},"
        "${this.nationality},"
        "${this.insurance},"
        "${this.handicap},"
        "${this.diabetes},"
        "${this.hypertension},"
        "${this.alcoholism}");
  }

  factory UserInfoDb.fromJson(Map<String, dynamic> json) {
    return UserInfoDb(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      dob: json['dob'],
      gender: json['gender'],
      phone: json['phone'],
      nationality: json['nationality'],
      insurance: json['insurance'],
      handicap: json['handicap'],
      diabetes: json['diabetes'],
      hypertension: json['hypertension'],
      alcoholism: json['alcoholism']
    );
  }

  void setInfo(String e, String pwd, String n, String d, String g, String p, String nat, bool i, bool handi, bool di, bool hy, bool al){
    this.email = e;
    this.password = pwd;
    this.encryptedPassword = "${passwordEncrypt.encrypt(this.password)}";
    this.name = n;
    this.dob = d;
    this.gender = g;
    this.phone = p;
    this.nationality = nat;
    this.insurance = i;
    this.handicap = handi;
    this.diabetes = di;
    this.hypertension = hy;
    this.alcoholism = al;
  }

  void setInfoEncrypted(String e, String pwd, String n, String d, String g, String p, String nat, bool i, bool handi, bool di, bool hy, bool al){
    this.email = e;
    this.password = 'encrypted';
    this.encryptedPassword = pwd;
    this.name = n;
    this.dob = d;
    this.gender = g;
    this.phone = p;
    this.nationality = nat;
    this.insurance = i;
    this.handicap = handi;
    this.diabetes = di;
    this.hypertension = hy;
    this.alcoholism = al;
  }

}

class HttpConnect{
  Future<UserInfoDb> insertUser(UserInfoDb userInfoDb) async {

    String j = '{"email": "${userInfoDb.email}", '
        '"password": "${userInfoDb.encryptedPassword}", '
        '"name": "${userInfoDb.name}", '
        '"dob": "${userInfoDb.dob}", '
        '"gender": "${userInfoDb.gender}", '
        '"phone": "${userInfoDb.phone}", '
        '"nationality": "${userInfoDb.nationality}", '
        '"insurance": "${userInfoDb.insurance}",'
        '"handicap": "${userInfoDb.handicap}",'
        '"diabetes": "${userInfoDb.diabetes}",'
        '"hypertension" : "${userInfoDb.hypertension}",'
        '"alcoholism": "${userInfoDb.alcoholism}"}';

    String signUpURL = serverURL + '/signup';

    final response = await http.post(Uri.encodeFull(signUpURL),
        headers: { "accept": "application/json",
          'content-type': "application/json"
        },
        body: j);

    var parsedResponse = json.decode(response.body);
    print("$parsedResponse");

    return userInfoDb;

  }

  Future<UserInfoDb> getUserProf(String email, String password) async {

    PasswordEncrypt passwordEncrypt = new PasswordEncrypt();

    String loginCred = '{ "email" : "${email}",'
        '"password" : "${passwordEncrypt.encrypt(password)}" }';

    String loginURL = serverURL + '/login';

    print("DB Info: Sending credentials: $loginCred");

    final response = await http.post(Uri.encodeFull(loginURL),
        headers: {"accept": "application/json",
          'content-type': "application/json"},
        body: loginCred);

    var parsedResponse = json.decode(response.body);
    print("DB Info: Received JSON: $parsedResponse");
    if(parsedResponse['email'] != null){
      UserInfoDb userInfoDb = new UserInfoDb();
      bool i = (parsedResponse['insurance'].contains('true')) ? true : false;
      bool handi = (parsedResponse['handicap'].contains('true')) ? true : false;
      bool di = (parsedResponse['diabetes'].contains('true')) ? true : false;
      bool hy = (parsedResponse['hypertension'].contains('true')) ? true : false;
      bool al = (parsedResponse['alcoholism'].contains('true')) ? true : false;

      userInfoDb.setInfoEncrypted(parsedResponse['email'],
          parsedResponse['password'],
          parsedResponse['name'],
          parsedResponse['dob'],
          parsedResponse['gender'],
          parsedResponse['phone'],
          parsedResponse['nationality'],
          i,
          handi,
          di,
          hy,
          al);
      print("DB Info: Received user profile info...");
      userInfoDb.printUser();
      return userInfoDb;
    }
    else{
      return null;
    }
  }
}


