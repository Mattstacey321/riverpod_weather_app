import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherUtils {
  static Widget getIcon(String icon,{double? size}) {
    bool isNight = icon.contains("n");
    if (isNight) {
      switch (icon) {
        case "01n":
          return BoxedIcon(WeatherIcons.night_clear,size: size,);
        case "02n":
          return BoxedIcon(WeatherIcons.day_cloudy,size: size,);
        case "03n":
          return BoxedIcon(WeatherIcons.night_alt_cloudy,size: size,);
        case "04n":
          return BoxedIcon(WeatherIcons.night_cloudy,size: size,);
        case "09n":
          return BoxedIcon(WeatherIcons.night_rain_mix,size: size,);
        case "10n":
          return BoxedIcon(WeatherIcons.night_rain,size: size,);
        case "11n":
          return BoxedIcon(WeatherIcons.night_storm_showers,size: size,);
        case "13n":
          return BoxedIcon(WeatherIcons.night_snow,size: size,);
        case "50n":
          return BoxedIcon(WeatherIcons.night_hail,size: size,);
        default:
          print(BoxedIcon);
          return BoxedIcon(EvaIcons.close,size: size,);
      }
    } else {
      switch (icon) {
        case "01d":
          return BoxedIcon(WeatherIcons.day_sunny,size: size,);
        case "02d":
          return BoxedIcon(WeatherIcons.day_cloudy,size: size,);
        case "03d":
          return BoxedIcon(WeatherIcons.cloud,size: size,);
        case "04d":
          return BoxedIcon(WeatherIcons.cloudy,size: size,);
        case "09d":
          return BoxedIcon(WeatherIcons.rain_mix,size: size,);
        case "10d":
          return BoxedIcon(WeatherIcons.day_rain,size: size,);
        case "11d":
          return BoxedIcon(WeatherIcons.storm_showers,size: size,);
        case "13d":
          return BoxedIcon(WeatherIcons.snow,size: size,);
        case "50d":
          return BoxedIcon(WeatherIcons.day_haze,size: size,);
        default:
          return BoxedIcon(EvaIcons.close,size: size,);
      }
    }
  }
}
