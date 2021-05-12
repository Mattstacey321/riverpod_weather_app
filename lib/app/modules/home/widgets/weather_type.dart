import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/weather_utils.dart';
import '../providers/home_provider.dart';

class WeatherType extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final response = watch(responseProvider);
    double iconSize = 40;
    return Container(
      child: response.map(
        data: (data) {
          final icon = data.value.weather.first.icon;
          return WeatherUtils.getIcon(icon, size: iconSize);
        },
        loading: (_) => Text("..."),
        error: (_) => Text("Error"),
      ),
    );
  }
}
