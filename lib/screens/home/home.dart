import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupulse/screens/account/account.dart';
import 'package:edupulse/screens/propositions/propositions.dart';
import 'package:edupulse/screens/vote/vote.dart';
import '../settings/settings.dart';
import '../authenticate/sign_in.dart'; // Import your login page

class Home extends StatelessWidget {
  // Example data (replace with your actual data)
  String currentPhase = "Propositions";
  Duration timeRemaining = Duration(days: 5, hours: 10, minutes: 15);
  String userRegion = "Région de Casablanca-Settat"; // Example region

  void showNotificationsMenu(BuildContext context) {
    // Add your code to show the notifications menu here
  }

  void logout(BuildContext context) async {
    await
    FirebaseAuth.instance.signOut(); // Sign out from Firebase

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;

    return "$days j - $hours h - $minutes min";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            child: Text('EduPulse', style: TextStyle(fontSize: 24)),
          onTap: (){
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
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
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle,size: 40,),
              title: Text('Compte',style: TextStyle(fontSize: 25),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Account()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description,size: 40,),
              title: Text('Propositions',style: TextStyle(fontSize: 25),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Propositions()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.how_to_vote,size: 40,),
              title: Text('Vote',style: TextStyle(fontSize: 25),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vote()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,size: 40,),
              title: Text('Déconnexion',style: TextStyle(fontSize: 25),),
              onTap: () {
                logout(context); // Call the logout function
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blueGrey[900], // Dark theme color
              padding: EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Text(
                "$userRegion",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.cyan.shade200, // Dark theme color for current phase
              padding: EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "$currentPhase",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.deepOrange.shade500,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Temps restant: ${formatDuration(timeRemaining)}",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Rest of the content...
          ],
        ),
      ),
    );
  }
}
