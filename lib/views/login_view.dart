import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/login_model.dart';

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
            Colors.red,
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
                  SizedBox(height: 16.0),
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
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text('Welcome back',
                                style: TextStyle(fontSize: 25, color: Colors.white)),
                          ),
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 15,),
                  Text('Enter your details to start swoopin.',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Enter you E-mail ID", //babel text
                      hintText: "example: mdrakib.mri93@gmail.com", //hint text
                      hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white54), //hint text style
                      labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: emailtap? Colors.white : Colors.black12 ,
                    ),
                    onTap: () {
                      setState(() {
                        emailtap = true; // Update the state of the widget when the TextField is tapped
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        emailtap = false; // Reset the state of the widget when editing is complete
                      });
                    },
                    onChanged: (value) {
                      emailtap = true;
                      Provider.of<LoginModel>(context, listen: false).email =
                          value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: Provider.of<LoginModel>(context).isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          Provider.of<LoginModel>(context, listen: false)
                              .toggleObscure();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      Provider.of<LoginModel>(context, listen: false).password =
                          value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: Provider.of<LoginModel>(context).isLoading
                        ? null
                        : () async {
                            try {
                              await Provider.of<LoginModel>(context,
                                      listen: false)
                                  .login();
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Login failed: ${e.message}'),
                                duration: Duration(seconds: 3),
                              ));
                            }
                          },
                    child: Provider.of<LoginModel>(context).isLoading
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(),
                      ),
                      SizedBox(width: 16.0),
                      Text('or sign in with'),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: isKeyboard ? size.height * .1 : size.height * .4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.g_mobiledata),
                        label: Text('Google'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.facebook),
                        label: Text('Facebook'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New to our app?'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Create an account'),
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
