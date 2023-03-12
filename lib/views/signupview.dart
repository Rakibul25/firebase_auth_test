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
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Enter your FullName",
                        //babel text
                        hintText: "Rakibul Islam",
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
                        context.read<UserProvider>().setName(value);
                      },
                    ),
                    SizedBox(
                        height:
                        isKeyboard ? size.height * .008 : size.height * .02),
                    Text(
                      context.watch<UserProvider>().isValidMail()
                          ? 'Email Valid'
                          : '* Email Invalid',
                      style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
                    SizedBox(
                        height:
                        isKeyboard ? size.height * .008 : size.height * .02),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Enter your E-Mail ID",
                        //babel text
                        hintText: "mdrakib.mri93@gmail.com",
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
                        context.read<UserProvider>().setEmail(value);
                      },
                    ),
                    SizedBox(
                        height:
                        isKeyboard ? size.height * .008 : size.height * .02),

                    TextField(
                      controller: _passwordController,
                      obscureText: Provider.of<UserProvider>(context).isObscure,
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
                            Provider.of<UserProvider>(context, listen: false)
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
                        context.read<UserProvider>().setPassword(value);
                      },
                    ),
                    SizedBox(
                        height:
                        isKeyboard ? size.height * .008 : size.height * .02),
                    Text(
                      context.watch<UserProvider>().isValidPass()
                          ? 'Password Valid'
                          : '* Password Invalid',
                      style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
                    SizedBox(
                        height:
                        isKeyboard ? size.height * .002 : size.height * .008),
                    Container(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("A password must contain", style: TextStyle(fontSize: 15,color: Colors.white),),
                          SizedBox(height: 10,),
                          Row(children: [
                            Icon(Icons.fiber_manual_record,size: 10,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("At least 8 charecters and at most 14 charecters.", style: TextStyle(fontSize: 15,color: Colors.white),),],),
                          Row(children: [
                            Icon(Icons.fiber_manual_record,size: 10,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Both uppercase and lowercase letters.", style: TextStyle(fontSize: 15,color: Colors.white),),],),
                          Row(children: [
                            Icon(Icons.fiber_manual_record,size: 10,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("A number.", style: TextStyle(fontSize: 15,color: Colors.white),),],),
                          Row(children: [
                            Icon(Icons.fiber_manual_record,size: 10,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("A special charecter(e.g. @#&).", style: TextStyle(fontSize: 15,color: Colors.white),),],),
                        ],
                      )
                    ),
                    SizedBox(
                        height:
                        isKeyboard ? size.height * .001 : size.height * .05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Or Sign Up Using',
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
                              Size(70, 70),
                            ),
                          ),

                          onPressed: () {
                            context.read<UserProvider>().googleLogin();
                            print("tap");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(userdata: context.read<UserProvider>().user.email.toString())),
                            );
                            },
                          child: Image.asset(
                            "assets/google.png",
                            height: 60,
                            width: 60,
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
                              Size(70, 70),
                            ),
                          ),
                          onPressed: () {  },
                          child: Image.asset(
                            "assets/fb.png",
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                        isKeyboard ? size.height * .001 : size.height * .08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Existing Swoop User?',
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()),
                                  );
                                },
                                child: Text(
                                  'Login here',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                )),
                          ],
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: context.read<UserProvider>().isValidPass()
                                ?
                            MaterialStateProperty.all<Color>(Colors.white) : MaterialStateProperty.all<Color>(Colors.grey),
                            fixedSize: MaterialStateProperty.all<Size>(
                              Size(150, 50),
                            ),
                          ),
                          onPressed: context.read<UserProvider>().isValidPass() && context.read<UserProvider>().isValidMail()
                              ? () {
                            context.read<UserProvider>().isLoading?
                            showDialog(
                                context: context,
                                builder: (c){
                                  return loadingDialog(message: "message");
                                }): null;
                            context.read<UserProvider>().signUp();
                            UserModel usermodel = UserModel(name: _nameController.text, email: _emailController.text, password: "pass");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(userdata: context.read<UserProvider>().usermodel.name.toString())),
                            );
                            // Handle form submission
                          }
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Create",
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
