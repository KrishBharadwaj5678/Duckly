import 'package:flutter/material.dart';

class HomeConstant {
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    // backgroundColor: const Color.fromRGBO(3, 58, 222, 1),
    backgroundColor: Color(0xFF1E88E5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 21,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
}
