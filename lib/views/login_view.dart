import 'package:firebase_auth_test/models/user.dart';
import 'package:firebase_auth_test/views/profile.dart';
import 'package:firebase_auth_test/views/signupview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/login_model.dart';
import 'dialog.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool emailtap = false;

  bool passtap = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent,
            Colors.purple,
          ],
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0, bottom: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_left_sharp,
                            size: 35,
                            color: Colors.white,
                          ),
                          Text('Go back',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text('Welcome back',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .008 : size.height * .04),
                  Text('Enter your details to start swoopin.',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .01 : size.height * .02),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Enter you E-mail ID",
                      //babel text
                      hintText: "example: mdrakib.mri93@gmail.com",
                      //hint text
                      hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54),
                      //hint text style
                      labelStyle: TextStyle(fontSize: 17, color: Colors.white),
                      //label style
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    onChanged: (value) {
                      Provider.of<LoginModel>(context, listen: false).email =
                          value;
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .008 : size.height * .02),
                  TextField(
                    controller: _passwordController,
                    obscureText: Provider.of<LoginModel>(context).isObscure,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<LoginModel>(context, listen: false)
                              .toggleObscure();
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    onChanged: (value) {
                      Provider.of<LoginModel>(context, listen: false).password =
                          value;
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .001 : size.height * .003),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (c){
                                Future.delayed(Duration(seconds: 5), () {
                                  Navigator.of(context).pop(true);
                                });
                                return loadingDialog(message: "message");
                              });
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .001 : size.height * .2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Or Log In Using',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(80, 80),
                          ),
                        ),

                        onPressed: () {
                          context.read<LoginModel>().googleLogin();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(userdata: context.read<LoginModel>().user.email.toString())),
                          );
                        },
                        child:Image.asset(
                                "assets/google.png",
                                height: 70,
                                width: 70,
                              ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(80, 80),
                          ),
                        ),

                        onPressed: () {  },
                        child: Image.asset(
                                "assets/fb.png",
                                height: 70,
                                width: 70,
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .02 : size.height * .1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New to Swoop?',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()),
                                );
                              },
                              child: Text(
                                'Create an Account here',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(150, 50),
                          ),
                        ),
                        onPressed: Provider.of<LoginModel>(context).isLoading
                            ? null
                            : () async {
                                try {
                                  await Provider.of<LoginModel>(context,
                                          listen: false)
                                      .login();
                                  context.read<LoginModel>().isChecking? null:
                                  showDialog(
                                      context: context,
                                      builder: (c){
                                        return loadingDialog(message: "Logging In");
                                      });
                                  Future.delayed(Duration(seconds: 3)).then((value) {
                                    Navigator.pop(context); // Dismiss the dialog
                                  });
                                  context.read<LoginModel>().isLogging? null:
                                  showDialog(
                                      context: context,
                                      builder: (c){
                                        return loadingDialog(message: "Checking Account Info");
                                      });
                                  Future.delayed(Duration(seconds: 5)).then((value) {
                                    Navigator.pop(context); // Dismiss the dialog
                                  });

                                  print("tap");
                                  Future.delayed(Duration(seconds: 5)).then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(userdata: context.read<LoginModel>().email.toString())),
                                    );
                                  });
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Login failed: ${e.message}'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Log In",
                              style:
                                  TextStyle(color: Colors.purple, fontSize: 20),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
