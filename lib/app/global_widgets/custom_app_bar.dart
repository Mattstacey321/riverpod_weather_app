import 'package:flutter/material.dart';

import 'circle_icon.dart';

class CustomAppBar extends PreferredSize {
  final List<Widget> childs;
  final double? height;
  final Widget homeIcon;
  final Widget menu;
  final VoidCallback? onTapBack;
  final Color color;
  final Widget? tabBar;
  CustomAppBar({
    required this.childs,
    this.height = 50,
    this.menu = const SizedBox(),
    this.color = Colors.transparent,
    this.homeIcon: const Icon(Icons.chevron_left, size: 25),
    this.tabBar,
    this.onTapBack,
  }) : super(child: Container(),preferredSize: Size.fromHeight(50));

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, boxShadow: []),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [for (var widget in childs) widget],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  onTapBack == null
                      ? const SizedBox()
                      : CircleIcon(
                          onTap: () {
                            return onTapBack == null ? Navigator.of(context).pop() : onTapBack!();
                          },
                          icon: homeIcon,
                        ),
                ],
              ),
              Positioned(right: 0, child: menu)
            ],
          ),
          tabBar == null
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: tabBar,
                ),
        ],
      ),
    );
  }
}
