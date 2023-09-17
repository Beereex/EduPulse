import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/account/edit_account.dart';
import 'package:edupulse/screens/home/menu_section.dart';
import 'package:edupulse/screens/propositions/create_proposition.dart';
import 'package:edupulse/screens/propositions/my_propositions.dart';
import 'package:edupulse/screens/propositions/propositions_list.dart';
import 'package:edupulse/screens/settings/admin_panel.dart';
import 'package:edupulse/screens/vote/my_votes.dart';
import 'package:edupulse/services/app_data.dart';
import 'package:flutter/material.dart';
import 'package:edupulse/screens/account/show_account.dart';
import 'package:edupulse/screens/vote/national_voting_list.dart';
import 'package:intl/intl.dart';
import '../settings/preferences.dart';
import 'home_button.dart';

class Home extends StatefulWidget {
  final double titleBarFontSize = 24;
  final double buttonFontSize = 25;
  final double buttonBoxSize = 180;
  final double buttonIconSize = 80;
  final Color _menuCategoriesColor = const Color.fromRGBO(111, 97, 211, 1);
  final Color _phaseBarBackColor = const Color.fromRGBO(207, 238, 247, 0);
  final Color _textColor = const Color.fromRGBO(232, 232, 232, 1);
  AppData data = AppData.instance;
  Map<String, dynamic>? settings;
  String? phase;
  String? dateString;
  String? phaseIntro;
  double menuIconSize = 30;



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

  bool getAdminState(){
    bool isAdmin = false;
    widget.data.getUserData().then((result) {
      isAdmin = result?.userType == "admin" ? true : false;
    });
    return isAdmin;
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
        AppData.instance.currentPhase = widget.phase = "Repos";
        widget.dateString = "de ${display(phaseEnd)} à --/--/----";
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

  void refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: widget.titleBarFontSize + 10),
        title: GestureDetector(
          child: Text('EduPulse',
              style: TextStyle(fontSize: widget.titleBarFontSize, color: widget._textColor),),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: widget.titleBarFontSize + 10,
              color: const Color.fromRGBO(232, 232, 232, 1),
            ),
            onPressed: () {
              refresh();
            },
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.notifications,
              size: widget.titleBarFontSize + 10,
              color: const Color.fromRGBO(232, 232, 232, 1),
            ),
            onSelected: (value) {},
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Notification 1', style: TextStyle(color: Color.fromRGBO(232, 232, 232, 1)),),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Notification 2', style: TextStyle(color: Color.fromRGBO(232, 232, 232, 1)),),
                ),
              ];
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: widget.titleBarFontSize + 10,
              color: const Color.fromRGBO(232, 232, 232, 1),
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
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 7),
          children: [
            SizedBox(
              height: 105,
              child: DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: widget._textColor,
                    fontSize: widget.titleBarFontSize,
                  ),
                ),
              ),
            ),
            MenuSection(
              menuData: {
                'Profil' : ShowAccount(),
                'Modifier Profil' : EditAccount(),
              },
              icons: [
                Icon(Icons.account_circle, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
                Icon(Icons.edit, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
              ],
            ),
            MenuSection(
              menuData: {
                'Liste des Propositions' : SearchPropositions(),
                'Mes Propositions' : MyPropositions(),
                'Publier une Proposition' : CreateProposition(),
              },
              icons: [
                Icon(Icons.list_alt, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
                Icon(Icons.assignment, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
                Icon(Icons.publish, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
              ],
            ),
            MenuSection(
              menuData: {
                'Vote National' : const NationalVotingList(),
                'Mes Votes' : MyVotes(),
              },
              icons: [
                Icon(Icons.how_to_vote, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
                Icon(Icons.thumbs_up_down, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
              ],
            ),
            MenuSection(
              menuData: {
                'Préferences' : const Preferences(),
                'Administration' : AdminPanel(),
              },
              icons: [
                Icon(Icons.settings, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
                Icon(Icons.admin_panel_settings, size: widget.menuIconSize, color: widget._menuCategoriesColor,),
              ],
            ),
            MenuSection(
              menuData: const {
                'Déconnexion' : null,
              },
              icons: [
                Icon(Icons.logout, size: widget.menuIconSize, color: Colors.red.shade400,),
              ],
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
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text("Error loading the region");
                } else {
                  return Card(
                    elevation: 5,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      child: Text(
                        snapshot.data,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromRGBO(232, 232, 232, 1),
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 40),
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
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color.fromRGBO(232, 232, 232, 1),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          snapshot.data[1],
                          style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(232, 232, 232, 1),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data[2],
                          style: const TextStyle(
                            fontSize: 23,
                            color: Color.fromRGBO(232, 232, 232, 1),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 60),
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
            const SizedBox(height: 20),
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
