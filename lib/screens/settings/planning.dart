import 'dart:ffi';

import 'package:flutter/material.dart';

class Planning extends StatefulWidget {
  @override
  _PlanningState createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  int numberOfPropositions = 0;
  DateTime phaseStart = DateTime.now();
  DateTime phaseSwitch = DateTime.now();
  DateTime phaseEnd = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sélection',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Nombre de propositions à passer :'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (numberOfPropositions > 0) {
                                numberOfPropositions--;
                              }
                            });
                          },
                        ),
                        Text('$numberOfPropositions'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              numberOfPropositions++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(29.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Définition de Phase',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Début de la phase :'),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: phaseStart,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                phaseStart = date;
                              });
                            }
                          });
                        },
                        child: Text(
                          '${phaseStart.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 21.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Changement de phase :'),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: phaseSwitch,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                phaseSwitch = date;
                              });
                            }
                          });
                        },
                        child: Text(
                          '${phaseSwitch.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 21.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Fin de phase :'),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: phaseEnd,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                phaseEnd = date;
                              });
                            }
                          });
                        },
                        child: Text(
                          '${phaseEnd.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 21.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {

                },
                icon: Icon(Icons.save,size: 30,),
                label: Text('Enregistrer',style: TextStyle(fontSize: 20),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
