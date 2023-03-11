import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModel with ChangeNotifier {
  late String email;
  late String password;
  bool isLoading = false;
  bool isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    isLoading = true;
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
