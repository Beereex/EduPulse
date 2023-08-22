import 'package:edupulse/services/app_data.dart';
import 'package:flutter/material.dart';

class CreateProposition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData.instance.userInfos?.printInfos();
    if(AppData.instance.userInfos == null) print("oh shit");
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer Proposition'),
      ),
      body: Center(
        child: Text(
          'Create Proposition Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
