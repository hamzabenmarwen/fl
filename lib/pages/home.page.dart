import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/global.params.dart';  // Assurez-vous que cette importation est correcte.
import '../menu/drawer.widget.dart';  // Assurez-vous que ce fichier est bien configuré.

class HomePage extends StatelessWidget {
  // Fonction pour la déconnexion
  Future<void> deconnexion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);
    Navigator.pushNamedAndRemoveUntil(context, '/authentification', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Accueil'),
      ),
      drawer: MyDrawer(deconnexion: deconnexion),  // Passer la fonction de déconnexion à MyDrawer
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: GlobalParams.accueil.map<Widget>((item) {
            return InkWell(
              onTap: () {
                // Redirection dynamique en fonction de la route associée à l'élément
                Navigator.pushNamed(context, item['route']);
              },
              child: Ink.image(
                image: AssetImage(item['image']),  // Affichage de l'image dynamique
                height: 180,
                width: 180,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),  // Convertir la liste en liste de widgets
        ),
      ),
    );
  }
}
