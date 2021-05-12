import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'api_key.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      return Future.error('Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}

class WeatherApi {
  final apiKey = ApiKey.key;
  Future<http.Response> getWeatherApi(double lat, double long) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=$apiKey";
    return http.get(Uri.parse(url));
  }

  Future<http.Response> getUV(double lat, double long) async {
    final url =
        "https://api.openweathermap.org/data/2.5/uvi?lat=$lat&lon=$long&appid=$apiKey";
    return http.get(Uri.parse(url));
  }

  Future<http.Response> getDailyForecast(double lat, double long) async {
    final url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&mode=json&units=metric&exclude=current,minutely,alerts&&appid=$apiKey";
    return http.get(Uri.parse(url));
  }

  Future<http.Response> getHourlyForecast(double lat, double long) async {
    final url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&mode=json&units=metric&exclude=current,minutely,alerts,daily&&appid=$apiKey";
    return http.get(Uri.parse(url));
  }
}
