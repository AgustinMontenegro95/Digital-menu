import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  final String route;

  const SplashScreen({Key? key, required this.route}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  final double _bigFontSize = kIsWeb ? 234 : 178;
  //transicion letras
  final transitionDuration = const Duration(seconds: 1);

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      //
      duration: const Duration(seconds: 1),
    );

    //transicion S
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => expanded = true))
        //transicion
        .then((value) => const Duration(seconds: 1))
        .then(
          //transicion gif -> homepage
          (value) => Future.delayed(const Duration(seconds: 2)).then(
            (value) => _lottieAnimation.forward().then((value) {
              if (widget.route == 'intro') {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('intro', (route) => false);
              } else {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('home', (route) => false);
              }
            }),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                LottieBuilder.asset(
                  'assets/splash/splash_json.json',
                  onLoaded: (composition) {
                    //son dos..
                    _lottieAnimation.duration = composition.duration;
                  },
                  frameRate: FrameRate.max,
                  repeat: false,
                  animate: false,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  controller: _lottieAnimation,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: transitionDuration,
                      curve: Curves.fastOutSlowIn,
                      style: TextStyle(
                        color: const Color.fromRGBO(37, 49, 56, 1.0),
                        fontSize: !expanded ? _bigFontSize : 40,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                      child: const Center(
                        child: Text(
                          "D",
                        ),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstCurve: Curves.fastOutSlowIn,
                      crossFadeState: !expanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: transitionDuration,
                      firstChild: const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                      secondChild: _logoRemainder(),
                      alignment: Alignment.centerLeft,
                      sizeCurve: Curves.easeInOut,
                    ),
                  ],
                ),
                Expanded(child: Container()),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Image.asset("assets/splash/SoluDev_transp.png")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoRemainder() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "IGITAL ",
          style: TextStyle(
            color: Color.fromRGBO(37, 49, 56, 1.0),
            fontSize: 40,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        Text(
          "MENU",
          style: TextStyle(
            color: Color.fromRGBO(141, 184, 235, 1.0),
            fontSize: 40,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
