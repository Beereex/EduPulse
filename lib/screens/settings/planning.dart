import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/success_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  _PlanningState createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  int _numberOfPropositions = 0;
  DateTime? _phaseStart;
  DateTime? _phaseSwitch;
  DateTime? _phaseEnd;

  bool _phaseStartExpanded = true;
  bool _phaseSwitchExpanded = false;
  bool _phaseEndExpanded = false;
  bool _datesValid = true;

  void _closeTabs(){
    _phaseStartExpanded = false;
    _phaseSwitchExpanded = false;
    _phaseEndExpanded = false;
  }

  final Color _actionColorBack = const Color.fromRGBO(111, 97, 211, 1);


  Future<void> _fetchData() async {
    final settingsDoc = await FirebaseFirestore.instance
        .collection("settings")
        .doc("tqu1LE7CZEmDBgaJzhiI")
        .get();

    if (settingsDoc.exists) {
      setState(() {
        _numberOfPropositions = settingsDoc.data()!['nat_vote_qte'];
        _phaseStart = (settingsDoc.data()!['phase_start'] as Timestamp).toDate();
        _phaseSwitch =
            (settingsDoc.data()!['phase_switch'] as Timestamp).toDate();
        _phaseEnd = (settingsDoc.data()!['phase_end'] as Timestamp).toDate();
      });
    } else {
      print("Settings doc not found!!!");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future _saveSettings() async{
    if(_phaseStart!.isBefore(_phaseSwitch!) && _phaseSwitch!.isBefore(_phaseEnd!)){
      _datesValid = true;
      try{
        await FirebaseFirestore.instance.collection("settings")
            .doc("tqu1LE7CZEmDBgaJzhiI").update({
          "nat_vote_qte" : _numberOfPropositions,
          "phase_start" : _phaseStart,
          "phase_switch" : _phaseSwitch,
          "phase_end" : _phaseEnd,
        });
      }
      catch(e){
        print("Error saving settings: $e");
      }
    }
     else{
       _datesValid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nombre de propositions à passer vers le vote national',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(232, 232, 232, 1),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 40,
                            color: _actionColorBack,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_numberOfPropositions > 0) {
                                _numberOfPropositions--;
                              }
                            });
                          },
                        ),
                        const Spacer(),
                        Text(
                          '$_numberOfPropositions',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(232, 232, 232, 1),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: _actionColorBack,
                            size: 40,
                          ),
                          onPressed: () {
                            setState(() {
                              _numberOfPropositions++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: const EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    if(!_phaseStartExpanded){
                      _closeTabs();
                    }
                    _phaseStartExpanded = !_phaseStartExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title: Text(
                          'Date de début de phase',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(232, 232, 232, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    body: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: Scaffold(
                          body: _phaseStart != null
                          ? CupertinoDatePicker(
                            onDateTimeChanged: (DateTime value) {
                              _phaseStart = value;
                            },
                            initialDateTime: _phaseStart,
                            mode: CupertinoDatePickerMode.date,
                          )
                          : const CircularProgressIndicator(),
                        )
                    ),
                    isExpanded: _phaseStartExpanded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: const EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    if(!_phaseSwitchExpanded){
                      _closeTabs();
                    }
                    _phaseSwitchExpanded = !_phaseSwitchExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title: Text(
                          'Date de changement de phase',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(232, 232, 232, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    body: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: Scaffold(
                          body: _phaseSwitch != null
                          ? CupertinoDatePicker(
                            onDateTimeChanged: (DateTime value) {
                              _phaseSwitch = value;
                            },
                            initialDateTime: _phaseSwitch,
                            mode: CupertinoDatePickerMode.date,
                          )
                          : const CircularProgressIndicator(),
                        )
                    ),
                    isExpanded: _phaseSwitchExpanded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: const EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    if(!_phaseEndExpanded){
                      _closeTabs();
                    }
                    _phaseEndExpanded = !_phaseEndExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title: Text(
                          'Date de fin de phase',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(232, 232, 232, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    body: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: Scaffold(
                          body: _phaseEnd != null
                          ? CupertinoDatePicker(
                            onDateTimeChanged: (DateTime value) {
                              _phaseEnd = value;
                            },
                            initialDateTime: _phaseEnd,
                            mode: CupertinoDatePickerMode.date,
                          )
                          : const CircularProgressIndicator(),
                        )
                    ),
                    isExpanded: _phaseEndExpanded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _saveSettings().then((value){
                      if(_datesValid){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){

                              return SuccessDialog(message: "les nouveaux paramètres ont été enregistrer avec success",);
                            }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return const AlertDialog(title: Text("date Error"),content: Text("This is bad"),);
                            }
                        );
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.save,
                    size: 30,
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                  label: const Text(
                    'Enregistrer',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(232, 232, 232, 1),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _actionColorBack,
                    padding: const EdgeInsets.all(7),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
