import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkTheme = true; // Default to dark theme
  String _selectedLanguage = 'English'; // Default language

  // List of supported languages
  List<String> _languages = ['English', 'Français'];

  void _toggleTheme(bool newValue) {
    setState(() {
      _isDarkTheme = newValue;
      // You can save the user's theme preference using shared preferences
    });
  }

  void _changeLanguage(String? newLanguage) {
    if (newLanguage != null) {
      setState(() {
        _selectedLanguage = newLanguage;
        // You can change the app's language using localization
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apparence',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Thème sombre'),
              value: _isDarkTheme,
              onChanged: _toggleTheme,
            ),
            SizedBox(height: 20),
            Text(
              'Langue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: _changeLanguage,
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
