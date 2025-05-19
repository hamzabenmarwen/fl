import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PrayerDetailsPage extends StatefulWidget {
  final String city;
  final String country;

  const PrayerDetailsPage({
    super.key,
    required this.city,
    required this.country,
  });

  @override
  State<PrayerDetailsPage> createState() => _PrayerDetailsPageState();
}

class _PrayerDetailsPageState extends State<PrayerDetailsPage> {
  Map<String, dynamic>? prayerTimes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    final url =
        'https://api.aladhan.com/v1/timingsByCity?city=${widget.city}&country=${widget.country}&method=2';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        prayerTimes = data['data']['timings'];
        isLoading = false;
      });
    } else {
      setState(() {
        prayerTimes = null;
        isLoading = false;
      });
    }
  }

  // Widget for each prayer row with divider
  Widget buildPrayerRow(String nameFr, String nameAr, String time) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$nameFr - $nameAr", style: const TextStyle(fontSize: 16)),
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }

  // Widget for sun card with divider
  Widget buildSunCard(String titleFr, String titleAr, String iconPath, String time) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Image.asset(iconPath, width: 50, height: 50),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleFr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(titleAr, style: const TextStyle(fontSize: 14, fontFamily: 'Arabic')),
                    const SizedBox(height: 5),
                    Text(time, style: const TextStyle(fontSize: 18)),
                  ],
                )
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prières à ${widget.city}")),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Menu")),
            ListTile(
              title: const Text("Accueil"),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : prayerTimes == null
              ? const Center(child: Text("Erreur lors du chargement"))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // 🕌 Header image
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/ppp.png"), // Your mosque image
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "أوقات الصلاة لليوم",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Arabic',
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🕌 Prayer times
                    buildPrayerRow("Fajr", "الفجر", prayerTimes!['Fajr']),
                    buildPrayerRow("Dhuhr", "الظهر", prayerTimes!['Dhuhr']),
                    buildPrayerRow("Asr", "العصر", prayerTimes!['Asr']),
                    buildPrayerRow("Maghrib", "المغرب", prayerTimes!['Maghrib']),
                    buildPrayerRow("Isha", "العشاء", prayerTimes!['Isha']),

                    const SizedBox(height: 20),

                    // 🌅 Sunrise / Sunset
                    buildSunCard("Levée", "الشروق", "images/ttt.png", prayerTimes!['Sunrise']),
                    buildSunCard("Coucher", "الغروب", "images/rrr.png", prayerTimes!['Sunset']),
                  ],
                ),
    );
  }
}
