import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/daily.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/time_utils.dart';
import '../../../utils/weather_utils.dart';
import '../../home/providers/home_provider.dart';
import '../../home/widgets/addition_info.dart';
import "package:collection/collection.dart";

final selectedDayProvider = StateNotifierProvider<DayNotifier, int>((ref) => DayNotifier());

class DayNotifier extends StateNotifier<int> {
  DayNotifier() : super(DateTime.now().millisecondsSinceEpoch);

  void setDay(int unix) {
    state = unix;
  }
}

class WeeklyChartPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final response = watch(dailyProvider);
    final unixTime = watch(selectedDayProvider);

    return Container(
      width: size.width,
      child: Center(
        child: response.map(
          data: (data) {
            final result = data.data!.value;
            final currentIndex = result.indexWhere((element) => element.dt == unixTime) == -1
                ? 0
                : result.indexWhere((element) => element.dt == unixTime);
            final daily = result[currentIndex];
            final sortedWeatherType = result
                .groupListsBy((element) => element.weather.first.description)
                .map((key, value) => MapEntry(key, value.length))
                .entries
                .toList();
            final averageTemp = result
                .groupListsBy((element) => element.weather.first.description)
                .map((key, total) => MapEntry(
                    key,
                    total.fold<double>(
                        total.first.temp.day,
                        (previousValue, element) =>
                            (previousValue + element.temp.day) / total.length)));
            double getAverageTemp(String key) =>
                averageTemp.entries.toList().firstWhere((element) => element.key == key).value;
            return Column(
              children: <Widget>[
                //title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Weekly Chart",
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 40),
                      _buildWeatherInfo(daily),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                //
                Flexible(
                    child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(height: 20),
                          itemCount: sortedWeatherType.length,
                          itemBuilder: (context, index) {
                            final weatherType = sortedWeatherType[index];
                            return Row(
                              children: <Widget>[
                                Text(
                                  "${weatherType.value}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  "${weatherType.key}",
                                  style: TextStyle(fontSize: 22),
                                ),
                                const Spacer(),
                                Text(
                                  StringUtils.getTemp(getAverageTemp(weatherType.key)),
                                  style: TextStyle(fontSize: 22),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        child: _buildWeekdayWeather(size, result, unixTime),
                      )
                    ],
                  ),
                ))
              ],
            );
          },
          loading: (_) => const Text("..."),
          error: (_) => Text("Error"),
        ),
      ),
    );
  }

  Container _buildWeekdayWeather(Size size, List<Daily> result, int unixTime) {
    return Container(
      height: 100,
      width: size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final weekday = result[index];
          final dt = weekday.dt;
          final weekdayShortName = TimeUtils.unixToWeekdayShortName(dt)[0];
          final itemColor = dt == unixTime ? Colors.black : Colors.grey;
          final weatherIcon = WeatherUtils.getIcon(weekday.weather.first.icon);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              context.read(selectedDayProvider.notifier).setDay(dt);
            },
            child: Container(
              height: 80,
              width: 56,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: itemColor,
                    ),
                    child: weatherIcon,
                  ),
                  Text(
                    weekdayShortName,
                    style: TextStyle(color: itemColor),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 20),
        itemCount: result.length,
      ),
    );
  }

  Widget _buildWeatherInfo(Daily daily) {
    final weatherIcon = WeatherUtils.getIcon(daily.weather.first.icon);
    final weekdayName = TimeUtils.unixToFullDay(daily.dt);
    final tempMax = StringUtils.getTemp(daily.temp.max);
    final tempMin = StringUtils.getTemp(daily.temp.min);
    final windSpeed = StringUtils.getWind(daily.windSpeed);
    final pop = daily.pop.toString();
    final humidty = StringUtils.getHumidity(daily.humidity);
    final uv = daily.uvi.toString();
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            weatherIcon,
            const SizedBox(width: 10),
            // current weekday
            Expanded(
              child: Text(
                weekdayName,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  tempMax,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  tempMin,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                )
              ],
            )),
          ],
        ),
        const SizedBox(height: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      WeatherInfoItem(
                        title: "Wind",
                        value: windSpeed,
                      ),
                      const SizedBox(height: 20),
                      WeatherInfoItem(
                        title: "Pop",
                        value: Text(pop),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      WeatherInfoItem(
                        title: "Humidty",
                        value: humidty,
                      ),
                      const SizedBox(height: 20),
                      WeatherInfoItem(
                        title: "UV",
                        value: Text(uv),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
