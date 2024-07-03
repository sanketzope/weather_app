import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);
    var weather = weatherProvider.weather;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              weatherProvider.refreshWeather();
            },
          ),
        ],
      ),
      body: weatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weather == null
          ? const Center(child: Text('No data available'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'City: ${weather.cityName}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.network(
                    'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  buildWeatherCard(
                    context,
                    Icons.thermostat,
                    Colors.red,
                    'Temperature',
                    '${weather.temperature} °C',
                  ),
                  buildWeatherCard(
                    context,
                    Icons.cloud,
                    Colors.blue,
                    'Condition',
                    weather.condition,
                  ),
                  buildWeatherCard(
                    context,
                    Icons.water_drop,
                    Colors.blue,
                    'Humidity',
                    '${weather.humidity}%',
                  ),
                  buildWeatherCard(
                    context,
                    Icons.air,
                    Colors.green,
                    'Wind Speed',
                    '${weather.windSpeed} m/s',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWeatherCard(BuildContext context, IconData iconData,
      Color iconColor, String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(iconData, color: iconColor),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 35),
            Center(child: Text(value, style: const TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
