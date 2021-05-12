import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/string_utils.dart';
import '../providers/home_provider.dart';

class Temperature extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final response = watch(responseProvider);
    final style = TextStyle(fontWeight: FontWeight.bold, fontSize: 35);
    return Container(
      alignment: Alignment.center,
      child: response.map(
        data: (data) {
          final temp = data.value.main.temp;
          return Text(
            StringUtils.getTemp(temp),
            style: style,
          );
        },
        loading: (_) => Text("...", style: style),
        error: (_) => Text("NaN", style: style),
      ),
    );
  }
}
