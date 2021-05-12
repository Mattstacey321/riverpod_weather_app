import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final List<Widget> childs;
  final double? radius;
  final Color color;
  final VoidCallback? onPress;
  CustomButton(
      {required this.height,
      required this.width,
      required this.color,
      this.radius = 15,
      this.onPress,
      required this.childs});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius!),
        splashColor: color.withOpacity(0.1),
        onTap: onPress != null ? () => onPress!() : null,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius!),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var child in childs)
                        if (child is Text)
                          DefaultTextStyle(
                            style: TextStyle(color: Colors.white),
                            child: child,
                          )
                        else if (child is Icon)
                          IconTheme(
                            data: Theme.of(context)
                                .copyWith(
                                  iconTheme: IconThemeData(
                                    color: Colors.white,
                                  ),
                                )
                                .iconTheme,
                            child: child,
                          )
                        else
                          child
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(radius!),
                    onTap: onPress == null ? () => onPress!() : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
