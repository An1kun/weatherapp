import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'weather_details_screen.dart';


class HomeScreen extends StatelessWidget {
  final List<String> cities = ['Astana', 'Almaty', 'Yakutsk'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return ListTile(
            title: Text(city),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeatherDetailsScreen(city: city),
                ),
              );
            },
            trailing: FutureBuilder(
              future: Provider.of<WeatherProvider>(context, listen: false)
                  .fetchWeather(city),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error');
                } else {
                  final weather = Provider.of<WeatherProvider>(context).weather;
                  return Text('${weather?.temperature ?? 'N/A'}°C');
                }
              },
            ),
          );
        },
      ),
    );
  }
}
