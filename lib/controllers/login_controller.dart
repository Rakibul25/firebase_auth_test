import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController with ChangeNotifier {
  late String email;
  late String password;
  bool isLoading = false;
  bool isLogging = false;
  bool isChecking = false;
  bool isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userName = "";

  //facebook signup
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile', 'user_birthday']
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final userData = await FacebookAuth.instance.getUserData();

    userName = userData['name'].toString();
    notifyListeners();

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    notifyListeners();
  }


  //google login
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }



  //manual login
  Future<void> login() async {
    isLoading = true;
    notifyListeners();
    isLogging = true;
    notifyListeners();
    isChecking = true;
    notifyListeners();

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Logged in as ${userCredential.user!.email}');
    } on FirebaseAuthException catch (e) {
      print('Login failed: ${e.message}');
      throw e;
    } finally {
      isLoading = false;
      notifyListeners();
      isLogging = false;
      notifyListeners();
      isChecking = false;
      notifyListeners();
    }
  }


  //for password hiding
  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void dispose() {
    // Clean up any resources used by the controller.
  }
}
