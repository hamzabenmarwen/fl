import 'package:flutter/material.dart';
import 'priere_details.page.dart';

class PrierePage extends StatefulWidget {
  const PrierePage({super.key});

  @override
  State<PrierePage> createState() => _PrierePageState();
}

class _PrierePageState extends State<PrierePage> {
  final cityController = TextEditingController();
  final countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service Prière")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: "Ville"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: countryController,
              decoration: const InputDecoration(labelText: "Pays"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(
      context,
      '/priere-details',
      arguments: {
        'city': cityController.text,
        'country': countryController.text,
      },
    );
  },
  child: const Text("Afficher les horaires"),
)

          ],
        ),
      ),
    );
  }
}
