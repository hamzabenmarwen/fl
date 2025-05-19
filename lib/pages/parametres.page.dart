import 'package:flutter/material.dart';

class ParametresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: Center(
        child: Text(
          'Page Paramètres',
          style: TextStyle(fontSize: 24, color: Colors.blue), // Vous pouvez ajuster le style
        ),
      ),
    );
  }
}
