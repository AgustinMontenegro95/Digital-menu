import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesarrolladoWidget extends StatelessWidget {
  final Size media;
  final Color color;
  final Color colorSoluDev;

  const DesarrolladoWidget(
      {required this.media, required this.color, required this.colorSoluDev});

  @override
  Widget build(BuildContext context) {
    double tam = 12;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            'Digital Menu',
            style: GoogleFonts.raleway(
              textStyle:
                  TextStyle(color: color, letterSpacing: .5, fontSize: tam),
            ),
          ),
          SizedBox(width: media.width * 0.3),
          Icon(
            Icons.developer_mode_outlined,
            color: color,
            size: tam,
          ),
          SizedBox(width: media.width * 0.01),
          Text(
            'Desarrolado por: ',
            style: GoogleFonts.raleway(
              textStyle:
                  TextStyle(color: color, letterSpacing: .5, fontSize: tam),
            ),
          ),
          Text(
            'SoluDev',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                  color: colorSoluDev, letterSpacing: .5, fontSize: tam),
            ),
          ),
        ],
      ),
    );
  }
}
