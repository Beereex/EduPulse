import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(
            fontFamily: "tahoma",
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Container(
          child: Text(
              "Hola",
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
