import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/weather_api.dart';
import '../../../models/daily.dart';
import '../../../models/hourly.dart';
import '../../../models/uv.dart';
import '../../../models/weather.dart';

final weatherApiProvider = Provider<WeatherApi>((ref) => WeatherApi());

final responseProvider = FutureProvider<Weather>((ref) async {
  final api = ref.read(weatherApiProvider);
  final position = await determinePosition();
  //if (position == null) return null;
  final res = await api.getWeatherApi(position.latitude, position.longitude);
  return Weather.fromJson(json.decode(res.body));
});

final uvProvider = FutureProvider<UV>((ref) async {
  final api = ref.read(weatherApiProvider);
  final position = await determinePosition();
  //if (position == null) return null;
  final res = await api.getUV(position.latitude, position.longitude);
  return UV.fromJSON(json.decode(res.body));
});

final dailyProvider = FutureProvider<List<Daily>>((ref) async {
  final api = ref.read(weatherApiProvider);
  final position = await determinePosition();
  //if (position == null) return null;
  final res = await api.getDailyForecast(position.latitude, position.longitude);
  return Weekly.fromList(json.decode(res.body)).daily;
});

final hourlyProvider = FutureProvider<List<Hour>>((ref) async {
  final api = ref.read(weatherApiProvider);
  final position = await determinePosition();
  //if (position == null) return null;
  final res = await api.getHourlyForecast(position.latitude, position.longitude);
  return Hourly.fromList(json.decode(res.body)).hourly;
});
