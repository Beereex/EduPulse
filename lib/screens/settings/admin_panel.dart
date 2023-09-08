import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../propositions/path_selection.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Paneau d'administration"),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Comptes',icon: Icon(Icons.account_circle)),
                Tab(text: 'Management',icon: Icon(Icons.schedule),),
                Tab(text: 'Salade de fruit',icon: Icon(Icons.assessment),),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PathSelection(showTitle: false,),
              Center(child: Text('Tab 2 Content')),
              Center(child: Text('Tab 3 Content')),
            ],
          ),
        ),
      ),
    );
  }
}
