import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_list/auth/signInSignUpResult.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  // untuk mendaftarkan user dengan input email dan password
  static Future<SignInSignUpResult> createUser(
      {String email, String pass}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return SignInSignUpResult(user: result.user);
    } catch (e) {
      return SignInSignUpResult(message: (e.message));
    }
  }

  // untuk login menggunakan email dan password yang sudah didaftarkan
  static Future<SignInSignUpResult> signInWithEmail(
      {String email, String pass}) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return SignInSignUpResult(user: result.user);
    } catch (e) {
      return SignInSignUpResult(message: (e.message));
    }
  }

  // untuk logout
  static void signOut() {
    _auth.signOut();
  }

  static Future<SignInSignUpResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential result =
          await _auth.signInWithCredential(credential);
      return SignInSignUpResult(user: result.user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
