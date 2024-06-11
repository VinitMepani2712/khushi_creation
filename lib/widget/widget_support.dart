import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle textStyle() {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Color(0xff704F38),
    );
  }

  static TextStyle lightTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF6C6C6C),
    );
  }

  static TextStyle buttonTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle snackbarTextStyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }


}
