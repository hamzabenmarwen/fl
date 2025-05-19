import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatelessWidget {
    late SharedPreferences prefs;
    final TextEditingController txt_login = TextEditingController();
    final TextEditingController txt_password = TextEditingController();

    Future<void> onInscrire(BuildContext context) async {
        prefs = await SharedPreferences.getInstance();
        if (txt_login.text.isNotEmpty && txt_password.text.isNotEmpty) {
            prefs.setString("login", txt_login.text);
            prefs.setString("password", txt_password.text);
            prefs.setBool("connecte", true);
            Navigator.pushNamed(context, '/home');
        } else {
            const snackBar = SnackBar(content: Text('Identifiant ou mot de passe vides'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('Page Inscription')),
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
                            onPressed: () => onInscrire(context),
                            child: Text('Inscription', style: TextStyle(fontSize: 22)),
                        ),
                        TextButton(
                            child: Text("J'ai déjà un compte", style: TextStyle(fontSize: 22)),
                            onPressed: () {
                                Navigator.pushNamed(context, '/authentification');
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}
