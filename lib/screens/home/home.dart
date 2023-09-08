import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/account/edit_account.dart';
import 'package:edupulse/screens/propositions/create_proposition.dart';
import 'package:edupulse/screens/propositions/my_propositions.dart';
import 'package:edupulse/screens/propositions/propositions_list.dart';
import 'package:edupulse/screens/settings/admin_panel.dart';
import 'package:edupulse/screens/vote/my_votes.dart';
import 'package:edupulse/services/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupulse/screens/account/show_account.dart';
import 'package:edupulse/screens/vote/vote_list.dart';
import 'package:intl/intl.dart';
import '../../models/user_infos.dart';
import '../settings/preferences.dart';
import '../authenticate/sign_in.dart';
import 'home_button.dart';

class Home extends StatefulWidget {
  double titleBarFontSize = 24;
  double buttonFontSize = 25;
  double buttonBoxSize = 180;
  double buttonIconSize = 80;
  final Color _menuCategoriesColor = const Color.fromRGBO(111, 97, 211, 1);
  final Color _phaseTextColor = const Color.fromRGBO(53, 21, 93, 1);
  final Color _phaseBarBackColor = const Color.fromRGBO(207, 238, 247, 1);
  AppData data = AppData.instance;
  Map<String, dynamic>? settings;
  bool _isAdmin = false;
  String? phase;
  String? dateString;

  @override
  State<StatefulWidget> createState() => _HomeState();
}



class _HomeState extends State<Home>{
  void showNotificationsMenu(BuildContext context) {}

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async{
    await widget.data.getUserData().then((result){
      widget.data.userInfos = result;
    });
    await widget.data.getAppSettings().then((result){
      widget.settings = result;
      DateTime date = DateTime.now();
      DateTime phaseStart = (widget.settings?["phase_start"] as Timestamp).toDate();
      DateTime phaseEnd = (widget.settings?["phase_end"] as Timestamp).toDate();
      DateTime phaseSwitch = (widget.settings?["phase_switch"] as Timestamp).toDate();
      dynamic display = DateFormat("dd/MM/yyyy").format;

      if(date.isBefore(phaseStart) || date.isAfter(phaseEnd)){
        widget.phase = "Rest";
        widget.dateString = "Prochaine phase: Undefined";
      }
      else if (date.isBefore(phaseSwitch)){
        widget.phase = "Propositions";
        widget.dateString = "de ${display(phaseStart)} à ${display(phaseSwitch)}";
      }
      else{
        widget.phase = "Votes";
        widget.dateString = "de ${display(phaseSwitch)} à ${display(phaseEnd)}";
      }
    });
    setAdmin(widget.data.userInfos?.userType ?? "");
  }

  void setAdmin(String type){
    if(type == "admin"){
      setState(() {
        widget._isAdmin = true;
      });
    }
    else{
      setState(() {
        widget._isAdmin = false;
      });
    }
  }

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
        iconTheme: IconThemeData(size: widget.titleBarFontSize + 10),
        title: GestureDetector(
          child: Text('EduPulse', style: TextStyle(fontSize: widget.titleBarFontSize)),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.notifications,
              size: widget.titleBarFontSize + 10,
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
              size: widget.titleBarFontSize + 10,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Preferences()),
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
                    fontSize: widget.titleBarFontSize,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 40,
                color: widget._phaseTextColor,
              ),
              tileColor: widget._phaseBarBackColor,
              title: Text(
                'Mon compte',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: widget._phaseTextColor,
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
              tileColor: widget._phaseBarBackColor,
              leading: Icon(
                Icons.description,
                size: 40,
                color: widget._phaseTextColor,
              ),
              title: Text(
                'Propositions',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: widget._phaseTextColor,
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
              tileColor: widget._phaseBarBackColor,
              leading: Icon(
                Icons.how_to_vote,
                size: 40,
                color: widget._phaseTextColor,
              ),
              title: Text(
                'Vote',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: widget._phaseTextColor,
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
              tileColor: widget._phaseBarBackColor,
              leading: Icon(
                Icons.settings,
                size: 40,
                color: widget._phaseTextColor,
              ),
              title: Text(
                'Paramètres',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: widget._phaseTextColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 55),
              leading: const Icon(Icons.person, size: 35),
              title: const Text(
                'Préférences',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Preferences()),
                );
              },
            ),
            (widget.data.userInfos?.userType == "admin")
                ? (ListTile(
                  contentPadding: EdgeInsets.only(left: 55),
                  leading: const Icon(Icons.admin_panel_settings, size: 35),
                  title: const Text(
                    'Administration',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPanel()),
                    );
                  },
                ))
              : SizedBox(),
            ListTile(
              tileColor: widget._phaseBarBackColor,
              leading: Icon(
                Icons.exit_to_app,
                size: 40,
                color: widget._phaseTextColor,
              ),
              title: Text(
                'Déconnexion',
                style: TextStyle(
                  fontSize: 27,
                  decoration: TextDecoration.underline,
                  color: widget._phaseTextColor,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blueGrey[900],
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Text(
                widget.data.userInfos?.region ?? "Undefined",
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
              color: widget._phaseBarBackColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Phase des",
                    style: TextStyle(
                      fontSize: 24,
                      color: widget._phaseTextColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "${widget.phase}",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                      color: widget._phaseTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${widget.dateString}",
                    style: TextStyle(
                      fontSize: 23,
                      color: widget._phaseTextColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
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
                      backgroundColor: widget._menuCategoriesColor,
                      fontSize: widget.buttonFontSize,
                      iconSize: widget.buttonIconSize,
                      boxSize: widget.buttonBoxSize,
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
                      backgroundColor: widget._menuCategoriesColor,
                      fontSize: widget.buttonFontSize,
                      iconSize: widget.buttonIconSize,
                      boxSize: widget.buttonBoxSize,
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
                      backgroundColor: widget._menuCategoriesColor,
                      fontSize: widget.buttonFontSize,
                      iconSize: widget.buttonIconSize,
                      boxSize: widget.buttonBoxSize,
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
                      backgroundColor: widget._menuCategoriesColor,
                      fontSize: widget.buttonFontSize,
                      iconSize: widget.buttonIconSize,
                      boxSize: widget.buttonBoxSize,
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
      ),
    );
  }
}
