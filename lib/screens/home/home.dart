import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/account/edit_account.dart';
import 'package:edupulse/screens/propositions/create_proposition.dart';
import 'package:edupulse/screens/propositions/my_propositions.dart';
import 'package:edupulse/screens/propositions/propositions_list.dart';
import 'package:edupulse/screens/vote/my_votes.dart';
import 'package:edupulse/services/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupulse/screens/account/show_account.dart';
import 'package:edupulse/screens/vote/vote_list.dart';
import 'package:intl/intl.dart';
import '../../models/user_infos.dart';
import '../settings/settings.dart';
import '../authenticate/sign_in.dart';
import 'home_button.dart';

class Home extends StatelessWidget {
  double titleBarFontSize = 24;
  double buttonFontSize = 25;
  double buttonBoxSize = 180;
  double buttonIconSize = 80;
  Color _menuCategoriesColor = Color.fromRGBO(111, 97, 211, 1);
  Color _phaseTextColor = Color.fromRGBO(53, 21, 93, 1);
  Color _phaseBarBackColor = Color.fromRGBO(207, 238, 247, 1);
  AppData data = AppData.instance;
  Map<String, dynamic>? settings;

  void showNotificationsMenu(BuildContext context) {}

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: titleBarFontSize + 10),
        title: GestureDetector(
          child: Text('EduPulse', style: TextStyle(fontSize: titleBarFontSize)),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.notifications,
              size: titleBarFontSize + 10,
            ),
            onSelected: (value) {},
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
              ];
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: titleBarFontSize + 10,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
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
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleBarFontSize,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 40,
                color: _phaseTextColor,
              ),
              tileColor: _phaseBarBackColor,
              title: Text(
                'Mon compte',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: _phaseTextColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
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
              tileColor: _phaseBarBackColor,
              leading: Icon(
                Icons.description,
                size: 40,
                color: _phaseTextColor,
              ),
              title: Text(
                'Propositions',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: _phaseTextColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.list_alt, size: 35),
              title: const Text(
                'Liste des propositions',
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
              tileColor: _phaseBarBackColor,
              leading: Icon(
                Icons.how_to_vote,
                size: 40,
                color: _phaseTextColor,
              ),
              title: Text(
                'Vote',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: _phaseTextColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
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
              tileColor: _phaseBarBackColor,
              leading: Icon(
                Icons.exit_to_app,
                size: 40,
                color: _phaseTextColor,
              ),
              title: Text(
                'Déconnexion',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: _phaseTextColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<UserInfos?>(
        future: data.getUserData(),
        builder: (BuildContext context, AsyncSnapshot<UserInfos?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Text("Error: ${snapshot.error}");
          else {
            data.userInfos = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.blueGrey[900],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      snapshot.data!.region,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FutureBuilder<Map<String, dynamic>?>(
                    future: data.getAppSettings(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error while loading app settings!!!");
                      } else {
                        settings = snapshot.data;
                        DateTime date = DateTime.now();
                        DateTime phaseStart = (settings?["phase_start"] as Timestamp).toDate();
                        DateTime phaseEnd = (settings?["phase_end"] as Timestamp).toDate();
                        DateTime phaseSwitch = (settings?["phase_switch"] as Timestamp).toDate();
                        String phase, dateString;
                        dynamic display = DateFormat("dd/MM/yyyy").format;

                        if(date.isBefore(phaseStart) || date.isAfter(phaseEnd)){
                          phase = "Rest";
                          dateString = "Prochaine phase: Undefined";
                        }
                        else if (date.isBefore(phaseSwitch)){
                          phase = "Propositions";
                          dateString = "de ${display(phaseStart)} à ${display(phaseSwitch)}";
                        }
                        else{
                          phase = "Votes";
                          dateString = "de ${display(phaseSwitch)} à ${display(phaseEnd)}";
                        }
                                 
                        
                        return Container(
                          width: double.infinity,
                          color: _phaseBarBackColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                "Phase des",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: _phaseTextColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "$phase",
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                  color: _phaseTextColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "$dateString",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: _phaseTextColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HomeButton(
                            iconData: Icons.add_circle,
                            text: "Créer Proposition",
                            //backgroundColor: Colors.tealAccent.withOpacity(0.1),
                            backgroundColor: _menuCategoriesColor,
                            fontSize: buttonFontSize,
                            iconSize: buttonIconSize,
                            boxSize: buttonBoxSize,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateProposition()),
                              );
                            }),
                        HomeButton(
                            iconData: Icons.list_alt,
                            text: "Liste des Propositions",
                            backgroundColor: _menuCategoriesColor,
                            fontSize: buttonFontSize,
                            iconSize: buttonIconSize,
                            boxSize: buttonBoxSize,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPropositions()),
                              );
                            }),
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
                            backgroundColor: _menuCategoriesColor,
                            fontSize: buttonFontSize,
                            iconSize: buttonIconSize,
                            boxSize: buttonBoxSize,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyPropositions()),
                              );
                            }),
                        HomeButton(
                            iconData: Icons.thumbs_up_down,
                            text: "Mes Votes",
                            backgroundColor: _menuCategoriesColor,
                            fontSize: buttonFontSize,
                            iconSize: buttonIconSize,
                            boxSize: buttonBoxSize,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyVotes()),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
