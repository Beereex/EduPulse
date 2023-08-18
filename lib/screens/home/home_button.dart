import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color backgroundColor;
  final VoidCallback onTap; // Callback function for tap

  const HomeButton({
    Key? key,
    required this.iconData,
    required this.text,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Attach the onTap callback here
      child: Container(
        width: 120, // Adjust the width as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}