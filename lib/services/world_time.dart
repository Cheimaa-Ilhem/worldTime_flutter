import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  String? time; // the time in that location (nullable)
  String flag; // url to an asset flag icon
  String url; // location url (e.g., "Europe/London")
  late bool isDaytime; //initialized later, but not immediately

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    const apiKey = '60W9VKPK495U';
    final apiUrl =
        'http://api.timezonedb.com/v2.1/get-time-zone?key=$apiKey&format=json&by=zone&zone=$url';

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));
      Map data = jsonDecode(response.body); // from string to json

      if (data['status'] != 'OK') {
        throw Exception(data['message']);
      }

      String formatted = data['formatted']; // Example: "2025-04-17 19:08:25"
      DateTime now = DateTime.parse(formatted); // from string to datetime

      isDaytime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now); // 07:08 PM
    } catch (e) {
      print('Error: $e');
      time = 'could not get time';
      isDaytime = true;
    }
  }
}
