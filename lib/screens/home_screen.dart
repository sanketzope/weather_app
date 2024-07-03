import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/weather_provider.dart';
import 'weather_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();
  final color = const Color(0xFF676BD0);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Weather App')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 300,
              width: 300,
              child: Image(image: AssetImage('assets/images/homescreen.png')),
            ),
            const Text(
              'Check the Weather',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.location_city),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_cityController.text.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false)
                      .fetchWeather(_cityController.text)
                      .then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WeatherDetailsScreen()),
                    );
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Get Weather',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
