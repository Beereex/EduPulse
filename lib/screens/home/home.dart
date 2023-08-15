import 'package:flutter/material.dart';
import '../settings/settings.dart'; // Import your settings page

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduPulse', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 90,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Paramètres',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
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
              title: Text('Déconnexion'),
              onTap: () {
                // Add your logic for logout
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Bienvenue sur la page d\'accueil d\'EduPulse', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
