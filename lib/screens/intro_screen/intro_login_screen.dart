import 'package:digital_menu/animations/delayed_animation.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroLoginScreen extends StatefulWidget {
  const IntroLoginScreen({Key? key}) : super(key: key);

  @override
  _IntroLoginScreenState createState() => _IntroLoginScreenState();
}

class _IntroLoginScreenState extends State<IntroLoginScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tituloStyle = GoogleFonts.comicNeue(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        color: const Color.fromARGB(255, 255, 255, 255));
    const color = Colors.white;
    _scale = 1 - _controller.value;
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 86, 60, 238),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 86, 60, 238),
                  Color.fromARGB(255, 243, 104, 95),
                ],
              )),
              child: Center(
                child: Column(
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 90,
                      duration: const Duration(seconds: 2),
                      glowColor: const Color.fromARGB(59, 255, 255, 255),
                      repeat: true,
                      repeatPauseDuration: const Duration(seconds: 1),
                      startDelay: const Duration(seconds: 1),
                      child: Material(
                          elevation: 8.0,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                image: const DecorationImage(
                                  image: AssetImage('assets/Icons/icono.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            radius: 50.0,
                          )),
                    ),
                    DelayedAnimation(
                      child: Text("Bienvenido/a", style: tituloStyle),
                      delay: delayedAmount + 1000,
                    ),
                    DelayedAnimation(
                      child: Text("Digital Menu", style: tituloStyle),
                      delay: delayedAmount + 2000,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    DelayedAnimation(
                      child: const Text(
                        "Crea un QR",
                        style: TextStyle(fontSize: 20.0, color: color),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    DelayedAnimation(
                      child: const Text(
                        "de tu restaurante",
                        style: TextStyle(fontSize: 20.0, color: color),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    DelayedAnimation(
                      child: GestureDetector(
                        onTapDown: _onTapDown,
                        onTapUp: _onTapUp,
                        child: Transform.scale(
                          scale: _scale,
                          child: _animatedButtonUI,
                        ),
                      ),
                      delay: delayedAmount + 4000,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    DelayedAnimation(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('signup');
                        },
                        child: Text(
                          "No tienes cuenta? Crea una!!!!".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: color),
                        ),
                      ),
                      delay: delayedAmount + 5000,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget get _animatedButtonUI => GestureDetector(
      onTap: () {
        navigationPage();
      },
      child: Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8185E2),
            ),
          ),
        ),
      ));

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('signin');
  }
}
