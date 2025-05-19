import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatelessWidget {
  final TextEditingController txt_login = TextEditingController();
  final TextEditingController txt_password = TextEditingController();

  Future<void> onAuthentifier(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLogin = prefs.getString('login');
    String? savedPassword = prefs.getString('password');

    if (txt_login.text == savedLogin && txt_password.text == savedPassword) {
      prefs.setBool("connecte", true);
      Navigator.pushNamed(context, '/home');
    } else {
      const snackBar = SnackBar(content: Text('Identifiant ou mot de passe incorrect'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Authentification')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Utilisateur",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: txt_password,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Mot de passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onAuthentifier(context),
              child: Text('Connexion', style: TextStyle(fontSize: 22)),
            ),
            TextButton(
              child: Text("Nouvel Utilisateur", style: TextStyle(fontSize: 22)),
              onPressed: () {
                Navigator.pushNamed(context, '/inscription');
              },
            ),
          ],
        ),
      ),
    );
  }
}
