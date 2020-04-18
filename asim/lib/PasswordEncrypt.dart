import 'package:crypto/crypto.dart';
import 'dart:convert';

class PasswordEncrypt{
  String password;
  var pwdBytes;
  var pwdEncryptedHex;

  PasswordEncrypt( {
   this.password,
   this.pwdBytes,
   this.pwdEncryptedHex
  });

  encrypt(String pwd){
    this.password = pwd;
    this.pwdBytes = utf8.encode(password);
    this.pwdEncryptedHex = md5.convert(pwdBytes);
    return pwdEncryptedHex;
  }

}