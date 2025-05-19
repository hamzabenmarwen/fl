import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  final Future<void> Function(BuildContext) deconnexion;  // Ajouter ce paramètre

  // Ajouter un constructeur pour accepter ce paramètre
  MyDrawer({required this.deconnexion});  // Le constructeur prend la fonction 'deconnexion'

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/messi.jpg"),
                radius: 80,
              ),
            ),
          ),
          ...(GlobalParams.menus).map((item) {
            return ListTile(
              title: Text('${item['title']}', style: TextStyle(fontSize: 22)),
              leading: item['icon'],
              trailing: Icon(Icons.arrow_right, color: Colors.blue),
              onTap: () async {
                if (item['title'] != "Déconnexion") {
                  Navigator.pop(context);  // Ferme le Drawer
                  Navigator.pushNamed(context, item['route']);  // Navigation vers la page de l'élément
                } else {
                  deconnexion(context);  // Appel de la fonction de déconnexion
                }
              },
            );
          }).toList(),
          Divider(height: 4, color: Colors.blue),
        ],
      ),
    );
  }
}
