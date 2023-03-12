import 'package:firebase_auth_test/models/user.dart';
import 'package:flutter/material.dart';

import '../controllers/homeController.dart';


class HomePage extends StatefulWidget {
  final UserModel userModel;

  HomePage({required this.userModel});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(userModel: widget.userModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.userModel.name} - ${widget.userModel.email}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Push Notifications',
                  style: TextStyle(fontSize: 18),
                ),

              ],
            ),
            SizedBox(height: 32),
            Text(
              'Other Options',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                _controller.rateApp();
              },
              child: Text(
                'Rate App',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                _controller.shareApp();
              },
              child: Text(
                'Share App',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // index of current page
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // add logic to navigate to selected page
        },
      ),
    );
  }
}
