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
      backgroundColor: Colors.purple,
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
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
              padding: const EdgeInsets.only(
                  top: 2.0, left: 16.0, right: 16.0, bottom: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
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
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 11.0),
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
                  const Text('Enter your details to start swoopin.',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .01 : size.height * .02),
                  //email field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
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
                      Provider.of<LoginController>(context, listen: false)
                          .email = value;
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .008 : size.height * .02),
                  //Password field
                  TextField(
                    controller: _passwordController,
                    obscureText:
                        Provider.of<LoginController>(context).isObscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          isKeyboard ? size.height * .001 : size.height * .2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    children: [
                      //google login
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(80, 80),
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
                          height: 70,
                          width: 70,
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
                            const Size(80, 80),
                          ),
                        ),
                        onPressed: () async {
                          try{
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
                          }on FirebaseAuthException catch (e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text('Login failed: ${e.message}'),
                              duration: const Duration(seconds: 5),
                            ));
                          }
                        },
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
                          const Text(
                            'New to Swoop?',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),

                          //to navigate signup page
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()),
                                );
                              },
                              child: const Text(
                                'Create an Account here',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      //signin action
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(150, 50),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
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
