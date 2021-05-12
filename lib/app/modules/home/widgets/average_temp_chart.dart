import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home_provider.dart';

class EverageTempChart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final weatherProvider = watch(responseProvider);
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        width: size.width,
        child: weatherProvider.map(
          data: (res) {
            //final weather = res.value;
            return LineChart(
              LineChartData(
                  lineTouchData: LineTouchData(enabled: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                  axisTitleData: FlAxisTitleData(show: false),
                  gridData: FlGridData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 2.5),
                        FlSpot(2.5, 4),
                        FlSpot(4, 5.0),
                      ],
                      isCurved: true,
                      curveSmoothness: 0,
                      colors: const [Colors.black],
                      colorStops: [0.1, 0.4, 0.9],
                      barWidth: 2,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 6,
                          strokeColor: Colors.purple,
                        ),
                      ),
                      isStrokeCapRound: true,
                    ),
                  ]),
            );
          },
          loading: (value) => Center(child: const Text("...")),
          error: (value) => Text("Error"),
        ),
      ),
    );
  }
}
