import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupulse/screens/account/account.dart';
import 'package:edupulse/screens/propositions/propositions.dart';
import 'package:edupulse/screens/vote/vote.dart';
import '../settings/settings.dart';
import '../authenticate/sign_in.dart';
import 'home_button.dart'; // Import your login page

class Home extends StatelessWidget {
  // Example data (replace with your actual data)
  String currentPhase = "Propositions";
  Duration timeRemaining = const Duration(days: 5, hours: 10, minutes: 15);
  String userRegion = "Région de Casablanca-Settat"; // Example region

  void showNotificationsMenu(BuildContext context) {
    // Add your code to show the notifications menu here
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

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
          child: const Text('EduPulse', style: TextStyle(fontSize: 24)),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.notifications),
            onSelected: (value) {
              // Add your logic for handling menu item selection
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Notification 1'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Notification 2'),
                ),
                // Add more items here
              ];
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
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
            SizedBox(
              height: 90,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Paramètres',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, size: 40),
              title: const Text(
                'Compte',
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Account()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.description, size: 40),
              title: const Text(
                'Propositions',
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Propositions()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.how_to_vote, size: 40),
              title: const Text(
                'Vote',
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vote()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, size: 40),
              title: const Text(
                'Déconnexion',
                style: TextStyle(fontSize: 25),
              ),
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
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Text(
                userRegion,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.cyanAccent.shade100, // Accent color for current phase
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    currentPhase,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                      color: Colors.teal.shade900
                    ),
                  ),
                  const SizedBox(height: 10),
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
            const SizedBox(height: 20), // Add spacing between phase info and buttons
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_circle, size: 50),
                        onPressed: () {
                          // Add logic for creating a proposition
                        },
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Créer Proposition",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.search, size: 50),
                        onPressed: () {
                          // Add logic for searching propositions
                        },
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Rechercher Propositions",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.withOpacity(0.07),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.visibility, size: 50),
                          onPressed: () {
                            // Add logic for viewing user's propositions
                          },
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Mes Propositions",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.chat_bubble, size: 50),
                        onPressed: () {
                          // Add logic for chatting or commenting
                        },
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Commenter / Discuter",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    HomeButton(
                      iconData: Icons.add_alarm,
                      text: 'Test',
                      backgroundColor: Colors.tealAccent.withOpacity(0.1),
                      onTap: () { print("huh"); },)
                  ],
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
