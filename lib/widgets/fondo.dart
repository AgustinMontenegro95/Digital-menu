import 'package:digital_menu/styles/app_colors.dart';
import 'package:flutter/material.dart';

Widget crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;

  final fondoModaro = Container(
    height: size.height * 0.4,
    width: double.infinity,
    decoration: BoxDecoration(gradient: AppColors.gradient3),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.05)),
  );

  return Stack(
    children: <Widget>[
      fondoModaro,
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(bottom: 120.0, right: 20.0, child: circulo),
      Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const Image(
                image: AssetImage('assets/Icons/icono.png'),
                width: 110.0,
                height: 110.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10.0, width: double.infinity),
            const Text('Digital Menu',
                style: TextStyle(color: Colors.white, fontSize: 25.0))
          ],
        ),
      )
    ],
  );
}
