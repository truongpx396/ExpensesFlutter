import 'dart:math';

import 'package:flutter/material.dart';

var _scaleFactor = 0.0;

double scaleFactor(BuildContext context) {
  if (_scaleFactor == 0) {
    if (isTabletDevice(context)) {
      _scaleFactor = MediaQuery.of(context).size.width / 480;
    } else {
      _scaleFactor = 1.0;
    }
  }
  return _scaleFactor;
}

bool isTabletDevice(BuildContext context) {
  var query = MediaQuery.of(context);
  var size = query.size;
  var diagonal = sqrt((size.width * size.width) + (size.height * size.height));

  var isTablet = diagonal > 1100.0;
  return isTablet;
}

Widget space(double size) {
  return SizedBox(
    height: size,
    width: size,
  );
}
