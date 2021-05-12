import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/hourly.dart';

final dateProvider = FutureProvider<List<Hour>>((ref) async {
  final res = ref.watch(dateProvider);
  return res.data == null ? [] : res.data!.value;
});

final selectedDateProvider = StateNotifierProvider<HourlyNotifier, DateTime>((ref) => HourlyNotifier());

class HourlyNotifier extends StateNotifier<DateTime> {
  HourlyNotifier() : super(DateTime.now());

  void setSelectedDate(DateTime time) {
    state = time;
  }
}