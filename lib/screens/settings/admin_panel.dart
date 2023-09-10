import 'package:edupulse/screens/settings/create_user.dart';
import 'package:edupulse/screens/settings/planning.dart';
import 'package:flutter/material.dart';
import '../propositions/path_selection.dart';

class AdminPanel extends StatefulWidget {
  String path = "";
  AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("panneau de configuration"),
            bottom: const TabBar(
              labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,letterSpacing: 1),
              tabs: [
                Tab(text: 'Chemin',icon: Icon(Icons.account_tree,size: 30,)),
                Tab(text: 'Plannification',icon: Icon(Icons.schedule,size: 30,),),
                Tab(text: 'Créer utilisateur',icon: Icon(Icons.person_add,size: 30,),),
                Tab(text: 'Modifier utilisateur',icon: Icon(Icons.edit,size: 30,),),
                Tab(text: 'Supprimer utilisateur',icon: Icon(Icons.person_remove,size: 30,),),
              ],
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: [
              PathSelection(isPathSelection: false,),
              Planning(),
              CreateUser(),
              Text("data"),
              Text("data"),
            ],
          ),
        ),
      ),
    );
  }
}
