import 'package:flutter/material.dart';
import 'meteo-details.page.dart'; // Import the details page

class MeteoPage extends StatefulWidget {
  @override
  _MeteoPageState createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  final TextEditingController txt_ville = TextEditingController();

  void _onGetMeteoDetails(BuildContext context) {
    String v = txt_ville.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeteoDetailsPage(v),
      ),
    );
    txt_ville.text = ""; // Clear the text field after navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meteo")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: txt_ville,
              decoration: InputDecoration(
                labelText: "Enter city name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onGetMeteoDetails(context),
              child: Text("Chercher"),
            ),
          ],
        ),
      ),
    );
  }
}