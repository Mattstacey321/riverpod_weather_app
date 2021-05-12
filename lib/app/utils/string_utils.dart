import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StringUtils {
  static Widget getVisibility(int miles, {String? unit, Color? color = Colors.black45}) {
    num result = miles < 1000 ? miles : miles / 1000;
    String unit = miles < 1000 ? "m" : "km";
    return RichText(
      text: TextSpan(
        text: "$result ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
        children: [
          TextSpan(text: "$unit", style: TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  static Widget getHumidity(int percent, {String unit = "%", Color? color = Colors.black45}) {
    return RichText(
      text: TextSpan(
        text: "$percent ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
        children: [
          TextSpan(text: unit, style: TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  static Widget getWind(double speed, {String? unit = "m/s", Color? color = Colors.black45}) {
    return RichText(
      text: TextSpan(
        text: "$speed ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
        children: [
          TextSpan(text: unit, style: TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  static Widget getUV(double uv) {
    return Text(uv.toString());
  }

  static String getWeatherIconUrl(String type) {
    return "https://openweathermap.org/img/w/$type.png";
  }

  static String getTemp(double temp, {String unit = "°", int precision = 2}) {
    return "${temp.toStringAsPrecision(precision)}$unit";
  }
}
