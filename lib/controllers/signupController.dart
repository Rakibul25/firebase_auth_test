import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel _usermodel = UserModel(name: '', email: '', password: '');
  bool isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true;

  UserModel get usermodel => _usermodel;

  void setName(String name) {
    _usermodel.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _usermodel.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _usermodel.password = password;
    notifyListeners();
  }
  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  bool isValid() {
    // Check if password meets requirements
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,14}$');
    return passwordRegex.hasMatch(_usermodel.password);
  }
  void signUp() async {
    try {
      // Create new user in Firebase Authentication
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: _usermodel.email, password: _usermodel.password);

      // Save user's name to Firestore database
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': _usermodel.name,
        'email': _usermodel.email,
        'password': _usermodel.password,
      });

      // Clear the form fields
      _usermodel = UserModel(name: '', email: '', password: '');

      // Notify listeners that the user has been signed up
      notifyListeners();
    } catch (e) {
      // Handle errors during sign up
      print(e.toString());
    } finally{
      isLoading = false;
      notifyListeners();
    }
  }

}

