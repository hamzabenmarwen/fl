import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/gallerie.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/meteo-details.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/priere.page.dart';
import 'package:voyage/pages/priere_details.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/meteo': (context) => MeteoPage(),
    '/gallerie': (context) => galleriePage(),
    '/contact': (context) => ContactPage(),
    '/parametres': (context) => ParametresPage(),
    '/priere': (context) => const PrierePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      onGenerateRoute: (settings) {
        if (settings.name == '/meteo-details') {
          final city = settings.arguments as String? ?? '';
          return MaterialPageRoute(
            builder: (context) => MeteoDetailsPage(city),
          );
        }
        if (settings.name == '/priere-details') {
          final args = settings.arguments as Map<String, String>?;
          return MaterialPageRoute(
            builder: (context) => PrayerDetailsPage(
              city: args?['city'] ?? '',
              country: args?['country'] ?? '',
            ),
          );
        }
        return null; // fallback
      },
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bool isConnected = snapshot.data?.getBool('connecte') ?? false;
            return isConnected ? HomePage() : AuthentificationPage();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
