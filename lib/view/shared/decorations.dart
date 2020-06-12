import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration getCardShadowDecoration() {
  return BoxDecoration(boxShadow: [
    BoxShadow(
        blurRadius: 6.0, offset: Offset(0.0, 4.0), color: Color(0x29000000))
  ], color: Colors.white, borderRadius: BorderRadius.circular(8));
}
