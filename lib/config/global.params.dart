import 'package:flutter/material.dart';

class GlobalParams {
  static List<Map<String, dynamic>> menus = [
    {"title": "Accueil", "icon": Icon(Icons.home, color: Colors.blue), "route": "/home"},
    {"title": "Météo", "icon": Icon(Icons.sunny, color: Colors.blue), "route": "/meteo"},
    {"title": "Gallerie", "icon": Icon(Icons.photo, color: Colors.blue), "route": "/gallerie"},
    {"title": "Pays", "icon": Icon(Icons.location_city, color: Colors.blue), "route": "/pays"},
    {"title": "Contact", "icon": Icon(Icons.contact_page, color: Colors.blue), "route": "/contact"},
    {"title": "Paramètres", "icon": Icon(Icons.settings, color: Colors.blue), "route": "/parametres"},
    {"title": "Déconnexion", "icon": Icon(Icons.logout, color: Colors.blue), "route": "/authentification"},
  ];
  static List<Map<String, dynamic>> accueil = [
    {
      "title": "Météo",
      "image": "images/meteo.png",  // Chaîne représentant le chemin de l'image
      "route": "/meteo"
    },
    {
      "title": "Gallerie",
      "image": "images/gallerie.png", // Chaîne représentant le chemin de l'image
      "route": "/gallerie"
    },
    {
      "title": "Parametres",
      "image": "images/parametres.png",  // Chaîne représentant le chemin de l'image
      "route": "/parametres"
    },
    {
      "title": "Pays",
      "image": "images/pays.png",  // Chaîne représentant le chemin de l'image
      "route": "/pays"
    },
    {
      "title": "Contact",
      "image": "images/contact.png",  // Chaîne représentant le chemin de l'image
      "route": "/contact"
    },
    {
      "title": "Déconnexion",
      "image": "images/deconnexion.png",  // Chaîne représentant le chemin de l'image
      "route": "/authentification"
    },
  ];
}



