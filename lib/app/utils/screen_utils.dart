import 'package:flutter/cupertino.dart';

class ScreenUtils {
  BuildContext _context;
  late Size screenSize;
  ScreenUtils(BuildContext context) : _context = context;

  void initSize() {
    screenSize = MediaQuery.of(_context).size;
  }

  double getHeight() {
    return screenSize.height;
  }

  double getWidth() {
    return screenSize.width;
  }
}
