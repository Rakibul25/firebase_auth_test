import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginModel with ChangeNotifier {
  late String email;
  late String password;
  bool isLoading = false;
  bool isLogging = false;
  bool isChecking = false;
  bool isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

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

  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void dispose() {
    // Clean up any resources used by the controller.
  }
}
