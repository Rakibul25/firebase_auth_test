import 'package:firebase_auth_test/models/user.dart';
import 'package:firebase_auth_test/views/profile.dart';
import 'package:firebase_auth_test/views/signupview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../controllers/login_controller.dart';
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
    //to adjust screen size when keyboard popup
    final bool isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueGrey.shade600,
            Colors.blueGrey.shade900,
          ],
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 16.0, right: 16.0, bottom: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height:
                      isKeyboard ? size.height * .02 : size.height * .1),
                  const Text('LogIn',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .01 : size.height * .02),
                  //email field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Enter E-mail ID",
                      //label text
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
                      Provider.of<LoginController>(context, listen: false)
                          .email = value;
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .03 : size.height * .02),
                  //Password field
                  TextField(
                    controller: _passwordController,
                    obscureText:
                        Provider.of<LoginController>(context).isObscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Enter Password',
                      labelStyle:
                          const TextStyle(fontSize: 15, color: Colors.white),
                      border: const OutlineInputBorder(),
                      //to hide and visible password
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<LoginController>(context, listen: false)
                              .toggleObscure();
                        },
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    onChanged: (value) {
                      Provider.of<LoginController>(context, listen: false)
                          .password = value;
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .001 : size.height * .003),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
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
                          isKeyboard ? size.height * .001 : size.height * .1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //signin action
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(300, 50),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: Provider.of<LoginController>(context)
                                .isLoading
                            ? null
                            : () async {
                                try {
                                  await Provider.of<LoginController>(context,
                                          listen: false)
                                      .login();
                                  context.read<LoginController>().isChecking
                                      ? null
                                      : showDialog(
                                          context: context,
                                          builder: (c) {
                                            return loadingDialog(
                                                message: "Logging In");
                                          });
                                  Future.delayed(const Duration(seconds: 3))
                                      .then((value) {
                                    Navigator.pop(
                                        context); // Dismiss the dialog
                                  });
                                  context.read<LoginController>().isLogging
                                      ? null
                                      : showDialog(
                                          context: context,
                                          builder: (c) {
                                            return loadingDialog(
                                                message:
                                                    "Checking Account Info");
                                          });
                                  Future.delayed(const Duration(seconds: 5))
                                      .then((value) {
                                    Navigator.pop(
                                        context); // Dismiss the dialog
                                  });

                                  print("tap");
                                  Future.delayed(const Duration(seconds: 5))
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(
                                              userdata: context
                                                  .read<LoginController>()
                                                  .email
                                                  .toString())),
                                    );
                                  });
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Login failed: ${e.message}'),
                                    duration: const Duration(seconds: 3),
                                  ));
                                }
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              "Log In",
                              style:
                                  TextStyle(color: Colors.blueGrey.shade600, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: const Text(
                            'New here? Sign Up',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .08 : size.height * .1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Or Log In Using',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google login
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(60, 60),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<LoginController>()
                              .googleLogin()
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                            userdata: context
                                                .read<LoginController>()
                                                .user
                                                .email
                                                .toString())),
                                  ));
                        },
                        child: Image.asset(
                          "assets/google.png",
                          height: 60,
                          width: 60,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(60, 60),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            await context
                                .read<LoginController>()
                                .signInWithFacebook()
                                .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(
                                                userdata: context
                                                    .read<LoginController>()
                                                    .userName
                                                    .toString(),
                                              )),
                                    ));
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Login failed: ${e.message}'),
                              duration: const Duration(seconds: 5),
                            ));
                          }
                        },
                        child: Image.asset(
                          "assets/fb.png",
                          height: 60,
                          width: 60,
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
