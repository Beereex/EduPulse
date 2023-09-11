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
import 'package:edupulse/screens/vote/national_voting_list.dart';
import 'package:intl/intl.dart';
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
  String? phase;
  String? dateString;
  String? phaseIntro;

  bool isAdmin = false;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void showNotificationsMenu(BuildContext context) {}

  @override
  void initState() {
    init();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.isAdmin = widget.data.userInfos!.userType == "admin" ? true : false;
      });
    });
  }

  Future init() async {
    await widget.data.getUserData().then((result) {
      widget.data.userInfos = result;
    });
  }

  Future<String?> getRegion() async {
    String? region;
    await widget.data.getUserData().then((result) {
      region = result?.region;
    });
    return region;
  }

  Future<bool?> getAdminState() async {
    bool isAdmin = false;
    await widget.data.getUserData().then((result) {
      isAdmin = result?.userType == "admin" ? true : false;
    });
    return isAdmin;
  }

  void logout(BuildContext context) async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    });
  }

  Future<List<String>> initializeText() async {
    List<String> text = [];
    await widget.data.getAppSettings().then((result) {
      widget.settings = result;
      DateTime date = DateTime.now();
      DateTime phaseStart =
          (widget.settings?["phase_start"] as Timestamp).toDate();
      DateTime phaseEnd = (widget.settings?["phase_end"] as Timestamp).toDate();
      DateTime phaseSwitch =
          (widget.settings?["phase_switch"] as Timestamp).toDate();
      dynamic display = DateFormat("dd/MM/yyyy").format;

      if (date.isBefore(phaseStart) || date.isAfter(phaseEnd)) {
        AppData.instance.currentPhase = widget.phase = "Rest";
        widget.dateString = "Prochaine phase: Undefined";
        widget.phaseIntro = "Phase de";
      } else {
        widget.phaseIntro = "Phases des";
        if (date.isBefore(phaseSwitch)) {
          AppData.instance.currentPhase = widget.phase = "Propositions";
          widget.dateString =
              "de ${display(phaseStart)} à ${display(phaseSwitch)}";
        } else {
          AppData.instance.currentPhase = widget.phase = "Votes";
          widget.dateString =
              "de ${display(phaseSwitch)} à ${display(phaseEnd)}";
        }
      }
    });
    text.add(widget.phaseIntro!);
    text.add(widget.phase!);
    text.add(widget.dateString!);
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: widget.titleBarFontSize + 10),
        title: GestureDetector(
          child: Text('EduPulse',
              style: TextStyle(fontSize: widget.titleBarFontSize)),
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
                'Vote nationale',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NationalVotingList()),
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
            /*FutureBuilder<bool?>(
                future: getAdminState(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  else if(snapshot.hasError){
                    print("${snapshot.error}");
                    return Container();
                  }
                  else{
                    return Visibility(
                      visible: snapshot.data,
                      child: ListTile(
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
                      ),
                    );
                  }
                }
            ),*/
            Visibility(
              visible: widget.isAdmin,
              child: ListTile(
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
              ),
            ),
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
            FutureBuilder<String?>(
              future: getRegion(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error loading the region");
                } else {
                  return Container(
                    width: double.infinity,
                    color: Colors.blueGrey[900],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      snapshot.data,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
            Container(
              width: double.infinity,
              color: widget._phaseBarBackColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: FutureBuilder<List<String>>(
                future: initializeText(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Column(
                      children: [
                        Text(
                          snapshot.data[0],
                          style: TextStyle(
                            fontSize: 24,
                            color: widget._phaseTextColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          snapshot.data[1],
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            color: widget._phaseTextColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data[2],
                          style: TextStyle(
                            fontSize: 23,
                            color: widget._phaseTextColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    );
                  }
                },
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
                          MaterialPageRoute(builder: (context) => MyVotes()),
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
