import 'package:flutter/material.dart';
import '../settings/settings.dart';
import '../authenticate/sign_in.dart'; // Import your login page

class Home extends StatelessWidget {

  void showNotificationsMenu(BuildContext context) {
    // Add your code to show the notifications menu here
  }

  void logout(BuildContext context) {
    // Add your logout logic here
    // For example, you can clear user authentication and navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()), // Navigate to login page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduPulse', style: TextStyle(fontSize: 24)),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.notifications),
            onSelected: (value) {
              // Add your logic for handling menu item selection
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Notification 1'),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text('Notification 2'),
                  value: 2,
                ),
                // Add more items here
              ];
            },
          ),
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
              leading: Icon(Icons.account_circle), // Use the appropriate icon for Account
              title: Text('Compte'),
              onTap: () {
                // Add your logic for Account
              },
            ),
            ListTile(
              leading: Icon(Icons.description), // Use the appropriate icon for Propositions
              title: Text('Propositions'),
              onTap: () {
                // Add your logic for Propositions
              },
            ),
            ListTile(
              leading: Icon(Icons.how_to_vote), // Use the appropriate icon for Voting
              title: Text('Vote'),
              onTap: () {
                // Add your logic for Voting
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Déconnexion'),
              onTap: () {
                logout(context); // Call the logout function
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
