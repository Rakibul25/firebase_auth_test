import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/views/dialog.dart';
import 'package:firebase_auth_test/views/login_view.dart';
import 'package:firebase_auth_test/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/signupController.dart';
import '../models/user.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //to adjust screen size when keyboard popup
    final bool isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
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
                          isKeyboard ? size.height * .01 : size.height * .07),
                  const Text('SignUp',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .01 : size.height * .02),
                  //name field
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Enter your FullName",
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
                      context.read<UserProvider>().setName(value);
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .008 : size.height * .02),
                  //to show email valid or not
                  Text(
                    context.watch<UserProvider>().isValidMail()
                        ? 'Email Valid'
                        : '* Email Invalid',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .008 : size.height * .01),
                  //email field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Enter your E-Mail ID",
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
                      context.read<UserProvider>().setEmail(value);
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .008 : size.height * .02),
                  //to show password valid or not
                  Text(
                    context.watch<UserProvider>().isValidPass()
                        ? 'Password Valid'
                        : '* Password Invalid',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .008 : size.height * .01),
                  //password
                  TextField(
                    controller: _passwordController,
                    obscureText: Provider.of<UserProvider>(context).isObscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Enter Password',
                      labelStyle:
                          const TextStyle(fontSize: 15, color: Colors.white),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<UserProvider>(context, listen: false)
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
                      context.read<UserProvider>().setPassword(value);
                    },
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .01 : size.height * .01),
                  Visibility(
                    visible:
                        context.watch<UserProvider>().isValidPass() == false,
                    child: Container(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Password must contain",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "At least 8 charecters and at most 14 charecters.",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Both uppercase and lowercase letters.",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "A number.",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "A special charecter(e.g. @#&).",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .01 : size.height * .04),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //manual signup action
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  context.read<UserProvider>().isValidPass()
                                      ? MaterialStateProperty.all<Color>(
                                          Colors.white)
                                      : MaterialStateProperty.all<Color>(
                                          Colors.white),
                              fixedSize: MaterialStateProperty.all<Size>(
                                const Size(300, 50),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            onPressed: context
                                        .read<UserProvider>()
                                        .isValidPass() &&
                                    context.read<UserProvider>().isValidMail()
                                ? () {
                                    context.read<UserProvider>().isLoading
                                        ? null
                                        : showDialog(
                                            context: context,
                                            builder: (c) {
                                              return loadingDialog(
                                                  message: "Loading");
                                            });
                                    Future.delayed(const Duration(seconds: 2))
                                        .then((value) {
                                      Navigator.pop(
                                          context); // Dismiss the dialog
                                    });
                                    context.read<UserProvider>().signUp();
                                    UserModel usermodel = UserModel(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: "pass");
                                    Future.delayed(const Duration(seconds: 3))
                                        .then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                userdata: context
                                                    .read<UserProvider>()
                                                    .usermodel
                                                    .name
                                                    .toString())),
                                      );
                                    });

                                    // Handle form submission
                                  }
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade600,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginView()),
                                );
                              },
                              child: const Text(
                                'Already have an account? LogIn.',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          isKeyboard ? size.height * .001 : size.height * .05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Or Sign Up Using',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google sign up
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
                              .read<UserProvider>()
                              .googleLogin()
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              userdata: context
                                                  .read<UserProvider>()
                                                  .user
                                                  .email
                                                  .toString(),
                                            )),
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
                                .read<UserProvider>()
                                .signInWithFacebook()
                                .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(
                                                userdata: context
                                                    .read<UserProvider>()
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

// Wrap SignupScreen with UserProvider
class SignupScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: SignupScreen(),
    );
  }
}
