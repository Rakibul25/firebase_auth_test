import 'package:firebase_auth_test/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/login_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginModel>(
          create: (context) => LoginModel(),
        ),
      ],
      child: MaterialApp(
        title: 'My App',
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginView(),
        },
      ),
    );
  }
}
