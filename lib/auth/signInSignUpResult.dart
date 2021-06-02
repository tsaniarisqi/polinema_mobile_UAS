import 'package:firebase_auth/firebase_auth.dart';

// untuk memeriksa apakah proses autentifikasi berhasil atau gagal
// jika berhasil maka akan mendapatkan kembalian nilai user dari User
// dan jika gagal maka mendapatkan kembalian nilai error betripe string
class SignInSignUpResult {
  final User user;
  final String message;
  SignInSignUpResult({this.user, this.message});
}