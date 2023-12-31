import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/app_data.dart';
import '../home/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  Future<void> _signIn() async {
    setState(() {
      _isEmailValid = _validateEmail(_emailController.text);
      _isPasswordValid = _validatePassword(_passwordController.text);
    });

    if (!_isEmailValid || !_isPasswordValid) return;

    try {
      String email = _emailController.text;
      String password = _passwordController.text;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await AppData.instance.setCurrentUser(userCredential.user!);

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          setState(() {
            _errorMessage = 'Échec de la connexion. Veuillez vérifier votre courriel et votre mot de passe.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Échec de la connexion. Veuillez vérifier votre courriel et votre mot de passe.';
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage = 'Utilisateur non trouvé. Veuillez vérifier vos informations de connexion.';
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur : $e';
        });
      }
    }
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    final passwordRegex = RegExp(r'^[a-zA-Z0-9_]{6,30}$');
    return passwordRegex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        backgroundColor: Color(0xFF1E1E1E),//Color.fromRGBO(1, 1, 1, 1),
        appBar: AppBar(
          title: Text('Connexion'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.asset(
                    'assets/YasserLogo.png',
                    width: 230,
                    height: 330,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 17, color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Adresse e-mail',
                          labelStyle: TextStyle(color: Colors.white),
                          errorText: _isEmailValid ? null : 'Adresse e-mail non valide',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _isEmailValid ? Colors.white : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(fontSize: 17, color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(color: Colors.white),
                          errorText: _isPasswordValid
                              ? null
                              : 'Mot de passe non valide (6 à 30 caractères, lettres, chiffres et _)',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _isPasswordValid ? Colors.white : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                          textStyle: TextStyle(fontSize: 20),
                          padding: EdgeInsets.all(11),
                        ),
                        child: Text('Connexion'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
