import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home_provider.dart';

class LocationName extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final response = watch(responseProvider);
    return Container(
      child: response.map(
        data: (data) {
          final name = data.value.name;
          final country = data.value.sys.country;
          return Text("$name, $country");
        },
        loading: (_) => Text("..."),
        error: (_) => Text("NaN"),
      ),
    );
  }
}
