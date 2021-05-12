import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "../../../utils/string_utils.dart";
import '../providers/home_provider.dart';

class AdditionInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final uvResponse = watch(uvProvider);
    final weatherResponse = watch(responseProvider);
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Addition Info",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    WeatherInfoItem(
                      title: "Wind",
                      value: weatherResponse.map(
                        data: (data) => StringUtils.getWind(data.value.wind.speed),
                        loading: (_) => const Text("..."),
                        error: (_) => const Text("NaN"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    WeatherInfoItem(
                      title: "Visibility",
                      value: weatherResponse.map(
                        data: (data) {
                          final visibility = StringUtils.getVisibility(data.value.visibility);
                          return visibility;
                        },
                        loading: (_) => const Text("..."),
                        error: (_) => const Text("NaN"),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    WeatherInfoItem(
                      title: "Humidty",
                      value: weatherResponse.map(
                        data: (data) => StringUtils.getHumidity(data.value.main.humidity),
                        loading: (_) => const Text("..."),
                        error: (_) => const Text("NaN"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    WeatherInfoItem(
                      title: "UV",
                      value: uvResponse.map(
                        data: (data) {
                          return StringUtils.getUV(data.value.value);
                        },
                        loading: (_) => const Text("..."),
                        error: (_) => const Text("NaN"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherInfoItem extends StatelessWidget {
  final String title;
  final Widget value;
  WeatherInfoItem({required this.value, required this.title});
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontWeight: FontWeight.bold);
    final valueStyle = TextStyle(color: Colors.black45, fontWeight: FontWeight.bold);
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Text(title, style: titleStyle),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: DefaultTextStyle(
              style: valueStyle,
              child: value,
            ),
          )
        ],
      ),
    );
  }
}
