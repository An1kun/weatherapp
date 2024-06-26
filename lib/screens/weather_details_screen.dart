import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final String city;

  WeatherDetailsScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$city Weather'),
      ),
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeather(city),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading weather data'));
          } else {
            final weather = Provider.of<WeatherProvider>(context).weather;
            final forecast = Provider.of<WeatherProvider>(context).forecast;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('${weather?.cityName}', style: TextStyle(fontSize: 24)),
                  Text('${weather?.temperature}°C',
                      style: TextStyle(fontSize: 48)),
                  Text('${weather?.condition}'),
                  Text('Wind Speed: ${weather?.windSpeed} kph'),
                  Text('Humidity: ${weather?.humidity}%'),
                  SizedBox(height: 20),
                  Text('3-Day Forecast', style: TextStyle(fontSize: 24)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: forecast?.forecast.length ?? 0,
                      itemBuilder: (context, index) {
                        final dayWeather = forecast!.forecast[index];
                        return ListTile(
                          title: Text('${dayWeather.cityName}'),
                          subtitle: Text('${dayWeather.condition}'),
                          trailing: Text('${dayWeather.temperature}°C'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
