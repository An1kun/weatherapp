class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final double windSpeed;
  final int humidity;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.windSpeed,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      windSpeed: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
    );
  }
}

class Forecast {
  final List<Weather> forecast;

  Forecast({required this.forecast});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var list = json['forecast']['forecastday'] as List;
    List<Weather> forecastList = list.map((i) {
      var day = i['day'];
      return Weather(
        cityName: json['location']['name'],
        temperature: day['avgtemp_c'],
        condition: day['condition']['text'],
        windSpeed: day['maxwind_kph'],
        humidity: day['avghumidity'],
      );
    }).toList();
    return Forecast(forecast: forecastList);
  }
}
