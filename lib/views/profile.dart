import 'package:firebase_auth_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/homeController.dart';

class HomePage extends StatefulWidget {
  final String userdata;

  HomePage({required this.userdata});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Account",
                style: TextStyle(fontSize: 20, color: Colors.black)),
            Row(
              children: [
                const Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.purple,
                ),
                const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 15, color: Colors.purple),
                ),
              ],
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.userdata}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _controller.rateApp();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Interesets',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              //share app
              onTap: () {
                _controller.shareApp();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Preferences',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                //_controller.rateApp();
                await Share.share("https//www.playstore.com", subject: "App");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Share This App',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _controller.rateApp();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rate Us',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _controller.rateApp();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'About Us',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _controller.rateApp();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // index of current page
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.manage_accounts),
            label: '${widget.userdata}',
          ),
          const BottomNavigationBarItem(
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
