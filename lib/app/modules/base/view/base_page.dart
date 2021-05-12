import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global_widgets/index.dart';
import '../../home/view/home_page.dart';
import '../../setting/view/setting_page.dart';
import '../../weekly_chart/view/weekly_chart_page.dart';

class BasePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final index = watch(bottomNavigationProvider);
    return Scaffold(
      appBar: CustomAppBar(
        homeIcon: Icon(EvaIcons.menu2Outline),
        menu: index > 0
            ? const SizedBox()
            : CircleIcon(
                onTap: () {},
                icon: Icon(EvaIcons.searchOutline),
              ),
        onTapBack: () {},
        childs: [
          index > 0
              ? const SizedBox()
              : Text(
                  "Weather Forecast",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
        ],
      ),
      bottomSheet: CustomBottomNavigation(),
      body: Container(
        height: size.height,
        width: size.width,
        child: FadeIndexedStack(
          index: index,
          children: [HomePage(), WeeklyChartPage(), SettingPage()],
        ),
      ),
    );
  }
}
