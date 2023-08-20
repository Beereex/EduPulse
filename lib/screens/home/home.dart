import 'package:edupulse/screens/account/edit_account.dart';
import 'package:edupulse/screens/propositions/create_proposition.dart';
import 'package:edupulse/screens/propositions/my_propositions.dart';
import 'package:edupulse/screens/propositions/search_propositions.dart';
import 'package:edupulse/screens/vote/my_votes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupulse/screens/account/show_account.dart';
import 'package:edupulse/screens/vote/vote_list.dart';
import '../settings/settings.dart';
import '../authenticate/sign_in.dart';
import 'home_button.dart'; // Import your login page

class Home extends StatelessWidget {
  // Example data (replace with your actual data)
  String currentPhase = "Propositions";
  Duration timeRemaining = const Duration(days: 5, hours: 10, minutes: 15);
  String userRegion = "Région de Casablanca-Settat";
  double titleBarFontSize = 24;
  double buttonFontSize = 25;
  double buttonBoxSize = 180;
  double buttonIconSize = 80;

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
        iconTheme: IconThemeData(size: titleBarFontSize+10),
        title: GestureDetector(
          child: Text('EduPulse', style: TextStyle(fontSize: titleBarFontSize)),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.notifications,size: titleBarFontSize+10,),
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
            icon: Icon(Icons.settings,size: titleBarFontSize+10,),
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
                child: Text(
                  'Paramètres',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleBarFontSize,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, size: 40),
              tileColor: Colors.teal.shade900,
              title: const Text(
                'Mon compte',
                style: TextStyle(fontSize: 25,decoration: TextDecoration.underline),
              ),
              onTap: () {

              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.visibility, size: 35),
              title: const Text(
                'Consulter',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowAccount()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.edit, size: 35),
              title: const Text(
                'Modifier',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditAccount()),
                );
              },
            ),
            ListTile(
              tileColor: Colors.teal.shade900,
              leading: const Icon(Icons.description, size: 40),
              title: const Text(
                'Propositions',
                style: TextStyle(fontSize: 25,decoration: TextDecoration.underline),
              ),
              onTap: () {

              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.assignment, size: 35),
              title: const Text(
                'Mes propositions',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPropositions()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.search, size: 35),
              title: const Text(
                'Rechercher propositions',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPropositions()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.add_circle, size: 35),
              title: const Text(
                'Créer proposition',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateProposition()),
                );
              },
            ),
            ListTile(
              tileColor: Colors.teal.shade900,
              leading: const Icon(Icons.how_to_vote, size: 40),
              title: const Text(
                'Vote',
                style: TextStyle(fontSize: 25,decoration: TextDecoration.underline),
              ),
              onTap: () {

              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.thumbs_up_down, size: 35),
              title: const Text(
                'Mes vote',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyVotes()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.list, size: 35),
              title: const Text(
                'Liste des votes',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoteList()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, size: 40),
              title: const Text(
                'Déconnexion',
                style: TextStyle(fontSize: 25,decoration: TextDecoration.underline),
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
                textAlign: TextAlign.center,
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
            const SizedBox(height: 100), // Add spacing between phase info and buttons
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeButton(
                      iconData: Icons.add_circle,
                      text: "Créer Proposition",
                      backgroundColor: Colors.tealAccent.withOpacity(0.1),
                      fontSize: buttonFontSize,
                      iconSize: buttonIconSize,
                      boxSize: buttonBoxSize,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateProposition()),
                        );
                      }
                  ),
                  HomeButton(
                      iconData: Icons.search,
                      text: "Rechercher Propositions",
                      backgroundColor: Colors.tealAccent.withOpacity(0.1),
                      fontSize: buttonFontSize,
                      iconSize: buttonIconSize,
                      boxSize: buttonBoxSize,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPropositions()),
                        );
                      }
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeButton(
                      iconData: Icons.visibility,
                      text: "Mes Propositions",
                      backgroundColor: Colors.tealAccent.withOpacity(0.1),
                      fontSize: buttonFontSize,
                      iconSize: buttonIconSize,
                      boxSize: buttonBoxSize,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyPropositions()),
                        );
                      }
                  ),
                  HomeButton(
                      iconData: Icons.thumbs_up_down,
                      text: "Mes votes",
                      backgroundColor: Colors.tealAccent.withOpacity(0.1),
                      fontSize: buttonFontSize,
                      iconSize: buttonIconSize,
                      boxSize: buttonBoxSize,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyVotes()),
                        );
                      }
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
