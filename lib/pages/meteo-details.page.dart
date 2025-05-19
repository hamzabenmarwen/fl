import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String ville;

  const MeteoDetailsPage(this.ville, {Key? key}) : super(key: key);

  @override
  _MeteoDetailsPageState createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  Map<String, dynamic>? meteoData;
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    print("Météo de la ville de $ville");
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$ville&appid=c1ac64a7c70631280bfe8f0c8d0564ef";

    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        meteoData = json.decode(resp.body);
        isLoading = false;
      });
    }).catchError((err) {
      setState(() {
        errorMessage = "Erreur lors de la récupération des données.";
        isLoading = false;
      });
      print(err);
    });
  }

  String formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String formatTime(int timestamp) {
    var time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Météo à ${widget.ville}')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : meteoData != null
          ? ListView.builder(
        itemCount: meteoData!['list'].length,
        itemBuilder: (context, index) {
          var forecast = meteoData!['list'][index];
          var dateTime = formatDateTime(forecast['dt']);
          var time = formatTime(forecast['dt']);
          var weather = forecast['weather'][0]['main'].toString().toLowerCase();
          var temperature = forecast['main']['temp'] - 273.15;

          String imagePath = "images/${weather[0].toUpperCase() + weather.substring(1)}.png";

          return Card(
            color: Colors.blue.shade100,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(imagePath),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateTime,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "$time | ${forecast['weather'][0]['description']}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${temperature.toStringAsFixed(1)}°C",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(child: Text("Aucune donnée reçue.")),
    );
  }
}