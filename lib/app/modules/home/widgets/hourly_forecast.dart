import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/hourly.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/time_utils.dart';
import '../../../utils/weather_utils.dart';
import '../providers/home_provider.dart';
import '../providers/hourly_provider.dart';

final list = [
  {"title": "Today", "value": DateTime.now()},
  {
    "title": DateFormat('EEEE').format(DateTime.now().add(Duration(days: 1))),
    "value": DateTime.now().add(Duration(days: 1))
  },
  {
    "title": DateFormat('EEEE').format(DateTime.now().add(Duration(days: 2))),
    "value": DateTime.now().add(Duration(days: 2))
  },
];

class HourlyForecast extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final response = watch(hourlyProvider);
    return Container(
      height: 100,
      width: size.width,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var item in list)
                Row(
                  children: [
                    BuildHourlyDay(
                      data: item,
                      onTap: () {
                        context
                            .read(selectedDateProvider.notifier)
                            .setSelectedDate(item["value"] as DateTime);
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
            ],
          ),
          // build basic weather info
          Flexible(
            child: Center(
              child: response.map(
                data: (data) {
                  List<Hour> hours = data.data!.value;
                  return ListView.separated(
                    cacheExtent: 10,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: hours.length,
                    itemBuilder: (context, index) {
                      return HourItem(
                        hour: hours[index],
                        onTap: () {},
                      );
                    },
                  );
                },
                loading: (_) => const Text("..."),
                error: (_) => Icon(EvaIcons.close),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HourItem extends StatelessWidget {
  final Hour hour;
  final VoidCallback onTap;
  HourItem({required this.hour, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hhmm = TimeUtils.unixToHHmm(hour.dt);
    final weatherIcon = WeatherUtils.getIcon(hour.weather.first.icon, size: 35);
    final temp = StringUtils.getTemp(hour.temp);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width / 4,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 0.2, offset: Offset(0, 1))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              hhmm,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            weatherIcon,
            Text(temp, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
          ],
        ),
      ),
    );
  }
}

class BuildHourlyDay extends ConsumerWidget {
  final Map data;
  final bool selected;
  final VoidCallback onTap;
  BuildHourlyDay({required this.data, this.selected = false, required this.onTap});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final selectedDate = watch(selectedDateProvider);
    bool isSelected = DateUtils.isSameDay(data["value"] as DateTime, selectedDate);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        data["title"],
        style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.grey),
      ),
    );
  }
}
