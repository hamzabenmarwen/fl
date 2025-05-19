import 'package:flutter/material.dart';

class galleriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallerie'),
      ),
      body: Center(
        child: Text(
          'Page de la Gallerie',
          style: TextStyle(fontSize: 24, color: Colors.blue), // Vous pouvez ajuster le style
        ),
      ),
    );
  }
}
