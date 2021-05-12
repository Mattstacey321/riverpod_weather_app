import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationProvider, int>((ref) => BottomNavigationProvider());

class BottomNavigationProvider extends StateNotifier<int> {
  BottomNavigationProvider() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

class CustomBottomNavigation extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final index = watch(bottomNavigationProvider);
    return Container(
      height: 60,
      width: size.width,
      child: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            context.read(bottomNavigationProvider.notifier).setIndex(value);
          },
          currentIndex: index,
          fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(label: "Home", icon: Icon(EvaIcons.homeOutline)),
            BottomNavigationBarItem(label: "Weekly Chart", icon: Icon(EvaIcons.pieChartOutline)),
            BottomNavigationBarItem(label: "Setting", icon: Icon(EvaIcons.settings2Outline))
          ],
        ),
      ),
    );
  }
}
