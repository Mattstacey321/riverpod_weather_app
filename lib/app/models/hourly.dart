import 'daily.dart';

class Hour {
  Hour({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
    required this.pop,
  });

  int dt;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  num dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  List<WeatherSimple> weather;
  num pop;

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        dt: json["dt"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"],
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        weather: List<WeatherSimple>.from(json["weather"].map((x) => WeatherSimple.fromJson(x))),
        pop: json["pop"],
      );
}

class Hourly {
  List<Hour> hourly;
  Hourly({required this.hourly});
  factory Hourly.fromList(Map json) {
    var hourly = <Hour>[];
    for (var item in json["hourly"]) {
      hourly.add(Hour.fromJson(item));
    }
    return Hourly(hourly: hourly);
  }
}
