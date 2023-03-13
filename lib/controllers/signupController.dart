import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserProvider extends ChangeNotifier {
  UserModel _usermodel = UserModel(name: '', email: '', password: '');
  bool isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isChecking = false;
  UserModel get usermodel => _usermodel;
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



  //google signup
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

  //password regex
  bool isValidPass() {
    // Check if password meets requirements
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,14}$');
    return passwordRegex.hasMatch(_usermodel.password);
  }
  //mail regex
  bool isValidMail() {
    // Check if password meets requirements
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(_usermodel.email);
  }
  //manual signup
  void signUp() async {
    isChecking = true;
    notifyListeners();
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
      isChecking = false;
      notifyListeners();
    }
  }

}

