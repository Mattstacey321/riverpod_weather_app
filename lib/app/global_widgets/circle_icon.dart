import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  CircleIcon({required this.onTap, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey[200],
        borderRadius: BorderRadius.circular(1000),
        onTap: onTap,
        child: Container(height: 40, width: 40, child: (icon)),
      ),
    );
  }
}
