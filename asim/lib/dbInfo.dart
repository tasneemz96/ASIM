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
  String insurance;
  String dob;
  PasswordEncrypt passwordEncrypt = new PasswordEncrypt();

  UserInfoDb({this.email, this.password, this.name, this.phone, this.gender, this.nationality,
    this.insurance, this.dob});

  List<String> getAllInfo(){
    List<String> allInfo = [this.email, this.name, this.dob, this.gender, this.phone, this.nationality, this.insurance];
    return allInfo;
  }

  void printUser(){
    print("${this.email},"
        // "${this.password}, "
        "${this.encryptedPassword},"
        "${this.name},"
        "${this.dob},"
        "${this.gender},"
        "${this.phone},"
        "${this.nationality},"
        "${this.insurance} ");
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
      insurance: json['insurance']
    );
  }

  void setInfo(String e, String pwd, String n, String d, String g, String p, String nat, String i){
    this.email = e;
    this.password = pwd;
    this.encryptedPassword = "${passwordEncrypt.encrypt(this.password)}";
    this.name = n;
    this.dob = d;
    this.gender = g;
    this.phone = p;
    this.nationality = nat;
    this.insurance = i;
  }

  void setInfoEncrypted(String e, String pwd, String n, String d, String g, String p, String nat, String i){
    this.email = e;
    this.password = 'encrypted';
    this.encryptedPassword = pwd;
    this.name = n;
    this.dob = d;
    this.gender = g;
    this.phone = p;
    this.nationality = nat;
    this.insurance = i;
  }

}

class HttpConnect{
  Future<UserInfoDb> insertUser(UserInfoDb userInfoDb) async {

    String j = '{"email": "${userInfoDb.email}", '
        '"password" : "${userInfoDb.encryptedPassword}", '
        '"name": "${userInfoDb.name}", '
        '"dob": "${userInfoDb.dob}", '
        '"gender": "${userInfoDb.gender}", '
        '"phone": "${userInfoDb.phone}", '
        '"nationality": "${userInfoDb.nationality}", '
        '"insurance": "${userInfoDb.insurance}"}';

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
      userInfoDb.setInfoEncrypted(parsedResponse['email'],
          parsedResponse['password'],
          parsedResponse['name'],
          parsedResponse['dob'],
          parsedResponse['gender'],
          parsedResponse['phone'],
          parsedResponse['nationality'],
          parsedResponse['insurance']);
      print("DB Info: Received user profile info...");
      userInfoDb.printUser();
      return userInfoDb;
    }
    else{
      return null;
    }
  }
}


