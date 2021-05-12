import 'package:flutter/material.dart';

import '../widgets/addition_info.dart';
import '../widgets/average_temp_chart.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/location_name.dart';
import '../widgets/temperature.dart';
import '../widgets/weather_type.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          WeatherType(),
          const SizedBox(height: 10),
          Temperature(),
          const SizedBox(height: 10),
          LocationName(),
          const SizedBox(height: 10),
          Expanded(flex: 4, child: HourlyForecast()),
          Expanded(flex: 2, child: AdditionInfo()),
          Flexible(flex: 4, child: EverageTempChart())
        ],
      ),
    );
  }
}
