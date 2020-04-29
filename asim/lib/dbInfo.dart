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
  List<String> appointments;

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

  void setAppointments(List<String> appointments){
    this.appointments = appointments;
  }

}

class AppointmentInfoDB{
  String doctor;
  String specialization;
  DateTime appointmentdate;

  AppointmentInfoDB({this.doctor, this.specialization, this.appointmentdate});

  void printAppointment(){
    print("${this.doctor},"
        "${this.specialization},"
        "${this.appointmentdate}");
  }

  factory AppointmentInfoDB.fromJson(Map<String, dynamic> json) {
    return AppointmentInfoDB(
        doctor: json['doctor'],
        specialization: json['specialization'],
        appointmentdate: json['date']
    );
  }

  void setInfo(String doctor, String specialization, DateTime appointmentdate){
    this.doctor = doctor;
    this.specialization = specialization;
    this.appointmentdate = appointmentdate;
  }

}

class ArgumentBundle{
  List<AppointmentInfoDB> appointments;
  UserInfoDb userInfoDb;

  ArgumentBundle({this.appointments, this.userInfoDb});
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
        '"alcoholism": "${userInfoDb.alcoholism}",'
        '"appointments": { "numApps": "0"}}';

    String signUpURL = serverURL + '/signup';

    final response = await http.post(Uri.encodeFull(signUpURL),
        headers: { "accept": "application/json",
          'content-type': "application/json"
        },
        body: j);

    var parsed = json.decode(response.body);
    print("$parsed");

    if(parsed['patient'] != null){
      var parsedResponse = parsed['patient'];

      bool i = (parsedResponse['insurance'].contains('true')) ? true : false;
      bool handi = (parsedResponse['handicap'].contains('true')) ? true : false;
      bool di = (parsedResponse['diabetes'].contains('true')) ? true : false;
      bool hy = (parsedResponse['hypertension'].contains('true')) ? true : false;
      bool al = (parsedResponse['alcoholism'].contains('true')) ? true : false;

      var parsedApps = parsed['patient']['appointments'];


      List<String> appointments = new List<String>();
      if(int.parse(parsedApps['numApps']) >0){

        for(int i=0;i<parsedApps['numApps'];i++){
          String appointment = parsedApps["${i+1}"];
          appointments.add(appointment);
        }

      }

      userInfoDb.setAppointments(appointments);

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

    }
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
      
      var parsedApps = parsedResponse['appointments'];

      List<String> appointments = new List<String>();
      if(int.parse(parsedApps['numApps']) >0){

        for(int i=0;i<int.parse(parsedApps['numApps']);i++){
          String appointment = parsedApps["${i+1}"];
          appointments.add(appointment);
        }

      }

      userInfoDb.setAppointments(appointments);

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

  Future<List<AppointmentInfoDB>> getAppointments(String specialization) async{
    String appointmentURL = serverURL + "/availableappointments";

    String specializationRequest = '{ "specialization" : "${specialization}" }';

    print("Sending request for appointments.. ");

    final response = await http.post(Uri.encodeFull(appointmentURL),
        headers: {"accept": "application/json",
          'content-type': "application/json"},
        body: specializationRequest);

    print("Got response..");

    var parsedResponse = json.decode(response.body);

    print(parsedResponse);

    int numAppointments = parsedResponse["numAppointments"];
    List<AppointmentInfoDB> appointments = new List<AppointmentInfoDB>();

    // parse JSON and add the appointments to a list
    for(int i=0;i<numAppointments;i++){
      print(parsedResponse["${i+1}"]);
      AppointmentInfoDB appointment = new AppointmentInfoDB();

      // parse doctor field
      String doctor = parsedResponse["${i+1}"]["doctor"];
      // parse specialization field
      String specialization = parsedResponse["${i+1}"]["specialization"];
      // parse date and split into date and time
      String dateStr = parsedResponse["${i+1}"]["date"]; // get the appointment string
      String date = dateStr.split(' ')[0];
      print("$dateStr");
      print("$date");

      String time = dateStr.split(' ')[1];
      print("$time");

      // parse out year, month, day
      int year = int.parse(date.split('-')[2]);
      int month = int.parse(date.split('-')[1]);
      int day = int.parse(date.split('-')[0]);
      // parse out hour and minute
      int hour = int.parse(time.split(':')[0]);
      int minute = int.parse(time.split(':')[1]);
      // create DateTime object
      DateTime appointmentDate = new DateTime(year, month, day, hour, minute);
      // set appointment info
      appointment.setInfo(doctor, specialization, appointmentDate);
      // add to list
      appointments.add(appointment);
    }
    return appointments;
  }

  Future<Map<String, dynamic>> bookAppointment(AppointmentInfoDB appointmentInfoDB, UserInfoDb userInfoDb) async{

    String bookingURL = serverURL + "/bookappointment";

    String appday = (appointmentInfoDB.appointmentdate.day < 10) ? "0${appointmentInfoDB.appointmentdate.day}" : "${appointmentInfoDB.appointmentdate.day}";
    String appmonth = (appointmentInfoDB.appointmentdate.month < 10)? "0${appointmentInfoDB.appointmentdate.month}":"${appointmentInfoDB.appointmentdate.month}";
    String apphour = (appointmentInfoDB.appointmentdate.hour < 10)? "0${appointmentInfoDB.appointmentdate.hour}":"${appointmentInfoDB.appointmentdate.hour}";
    String appminute = (appointmentInfoDB.appointmentdate.minute < 10)? "0${appointmentInfoDB.appointmentdate.minute}":"${appointmentInfoDB.appointmentdate.minute}";

    String date = "$appday-$appmonth-${appointmentInfoDB.appointmentdate.year}";
    String time = "$apphour:$appminute";

    DateTime booking = new DateTime.now();
    String day = (booking.day < 10) ? "0${booking.day}" : "${booking.day}";
    String month = (booking.month < 10) ? "0${booking.month}" : "${booking.month}";
    String year = "${booking.year}";
    String hour = (booking.hour < 10) ? "0${booking.hour}" : "${booking.hour}";
    String minute = (booking.minute < 10) ? "0${booking.minute}" : "${booking.minute}";
    String bookingDate = "$day-$month-$year $hour:$minute";

    String send= '{"bookingDate": "$bookingDate",'
        '"appointment": '
        '{"doctor": "${appointmentInfoDB.doctor}", '
        '"specialization": "${appointmentInfoDB.specialization}", '
        '"date": "$date $time"}, '
        '"patient": '
        '{"email":"${userInfoDb.email}", '
        '"password": "${userInfoDb.encryptedPassword}"}}';

    final response = await http.post(Uri.encodeFull(bookingURL),
        headers: {"accept": "application/json",
          'content-type': "application/json"},
        body: send);

    var parsedResponse = json.decode(response.body);

    bool success;
    if(parsedResponse["status"]==1){
      success = true;
    }
    else{
      success = false;
    }

    if(parsedResponse['email'] != null){
      bool i = (parsedResponse['insurance'].contains('true')) ? true : false;
      bool handi = (parsedResponse['handicap'].contains('true')) ? true : false;
      bool di = (parsedResponse['diabetes'].contains('true')) ? true : false;
      bool hy = (parsedResponse['hypertension'].contains('true')) ? true : false;
      bool al = (parsedResponse['alcoholism'].contains('true')) ? true : false;

      var parsedApps = parsedResponse['appointments'];

      List<String> appointments = new List<String>();
      if(int.parse(parsedApps['numApps']) >0){

        for(int i=0;i<int.parse(parsedApps['numApps']);i++){
          String appointment = parsedApps["${i+1}"];
          appointments.add(appointment);
        }

      }

      userInfoDb.setAppointments(appointments);

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
    }

    Map<String, dynamic> result = { "success" : success, "patient" : userInfoDb};
    return result;

  }

  Future<List<AppointmentInfoDB>> getPatientAppointments(List<String> appointments) async{
    String appointmentsURL = serverURL + "/patientappointments";
    String send = '{"appointmentIDs": [';
    for(int i=0;i<appointments.length;i++){
      if(i==(appointments.length - 1)){
        send += '"${appointments[i]}"';
      }
      else{
        send += '"${appointments[i]}",';
      }
    }
    send += ']}';

    final response = await http.post(Uri.encodeFull(appointmentsURL),
        headers: {"accept": "application/json",
          'content-type': "application/json"},
        body: send);

    var parsedResponse = json.decode(response.body);

    // AppointmentInfoDB dummy = new AppointmentInfoDB();

    int numAppointments = parsedResponse["numAppointments"];
    List<AppointmentInfoDB> appointmentsInfo = new List<AppointmentInfoDB>();

    // parse JSON and add the appointments to a list
    for(int i=0;i<numAppointments;i++){
      print(parsedResponse["${i+1}"]);
      AppointmentInfoDB appointment = new AppointmentInfoDB();

      // parse doctor field
      String doctor = parsedResponse["${i+1}"]["doctor"];
      // parse specialization field
      String specialization = parsedResponse["${i+1}"]["specialization"];
      // parse date and split into date and time
      String dateStr = parsedResponse["${i+1}"]["date"]; // get the appointment string
      String date = dateStr.split(' ')[0];
      print("$dateStr");
      print("$date");

      String time = dateStr.split(' ')[1];
      print("$time");

      // parse out year, month, day
      int year = int.parse(date.split('-')[2]);
      int month = int.parse(date.split('-')[1]);
      int day = int.parse(date.split('-')[0]);
      // parse out hour and minute
      int hour = int.parse(time.split(':')[0]);
      int minute = int.parse(time.split(':')[1]);
      // create DateTime object
      DateTime appointmentDate = new DateTime(year, month, day, hour, minute);
      // set appointment info
      appointment.setInfo(doctor, specialization, appointmentDate);
      // add to list
      appointmentsInfo.add(appointment);
    }
    return appointmentsInfo;

    /*dummy.setInfo("Dr. Ben Cho", "Obstetrics & Gynaecology", DateTime.now());
    List<AppointmentInfoDB> dummyAppointments = new List<AppointmentInfoDB>();
    dummyAppointments.add(dummy);

    return dummyAppointments;*/

  }
}


