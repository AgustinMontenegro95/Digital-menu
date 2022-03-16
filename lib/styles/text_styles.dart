import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class KTextStyle {
  static const headerTextStyle = TextStyle(
      color: AppColors.whiteshade, fontSize: 28, fontWeight: FontWeight.w700);

  static const textFieldHeading =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);

  static const textFieldHintStyle = TextStyle(
      color: AppColors.hintText, fontSize: 14, fontWeight: FontWeight.w500);

  static const authButtonTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.whiteshade);
  static TextStyle tituloStyle = GoogleFonts.comicNeue(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      color: const Color.fromARGB(255, 72, 117, 153));
  static TextStyle descriptionStyle = GoogleFonts.raleway(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      color: const Color.fromARGB(255, 106, 108, 109));

  static TextStyle textosStyle = GoogleFonts.raleway(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      color: const Color.fromARGB(255, 255, 255, 255));
}
