import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const lightsky = Color(0xFFA6C0FF);
  static const whiteshade = Color(0xFFF8F9FA);
  static const blue = Color.fromARGB(255, 161, 207, 248);
  static const lightblueshade = Color.fromARGB(255, 46, 101, 241);
  static const grayshade = Color(0xFFEBEBEB);
  static const lightblue = Color(0xFF4B68D1);
  static const blackshade = Color(0xFF555555);
  static const hintText = Color(0xFFC7C7CD);

  static Gradient gradient1 = LinearGradient(
    colors: [
      const Color.fromARGB(255, 86, 60, 238).withOpacity(0.8),
      const Color.fromARGB(255, 243, 104, 95).withOpacity(0.8),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Gradient gradient2 = LinearGradient(
    colors: [
      const Color.fromARGB(255, 8, 93, 167).withOpacity(0.8),
      const Color.fromARGB(255, 151, 73, 224).withOpacity(0.8),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Gradient gradient3 = LinearGradient(
    colors: [
      const Color.fromARGB(174, 164, 31, 241).withOpacity(0.8),
      const Color.fromARGB(255, 20, 66, 219).withOpacity(0.8),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
