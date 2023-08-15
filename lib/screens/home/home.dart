import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authenticate/sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isDrawerOpen = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  Future<void> _signOutAndNavigateToLogin() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduPulse'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _toggleDrawer,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('Option 1'),
              onTap: () {
                // Add your logic for Option 1
              },
            ),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Option 2'),
              onTap: () {
                // Add your logic for Option 2
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Option 3'),
              onTap: () {
                // Add your logic for Option 3
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text('Option 4'),
              onTap: () {
                // Add your logic for Option 4
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: _signOutAndNavigateToLogin,
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to EduPulse Home'),
      ),
    );
  }
}
