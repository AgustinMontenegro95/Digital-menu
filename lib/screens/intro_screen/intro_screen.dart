import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../../styles/text_styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int totalPage = 4;
  //
  late AnimationController _lottieAnimation;
  var expanded = false;
  final transitionDuration = const Duration(seconds: 1);

  void _onScroll() {}

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
    );

    _pageController = PageController(
      initialPage: 0,
    )..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _lottieAnimation.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: <Widget>[
            makePage(
                page: 1,
                image: 'assets/intropage/carga_productos.json',
                title: 'Tus productos al alcanze del mundo',
                description:
                    'Carga tus productos y sus precios de una forma muy rapida y simple '),
            makePage(
                page: 2,
                image: 'assets/intropage/selecciona_plantilla.json',
                title: 'Variedad a la mano',
                description:
                    'Selecciona entre diversos diseños el menu que mas te guste y que se amolde a tu negocio'),
            makePage(
                page: 3,
                image: 'assets/intropage/genera_qr.json',
                title: 'El futuro es hoy',
                description:
                    "Una vez seleccionada la plantilla, se te entregara un QR que se sube de forma automatica a la red de forma gratuita"),
            makePage(
                page: 4,
                image: 'assets/intropage/imprime_qr3.json',
                title: 'Actualiza tu negocio',
                description:
                    "Guarda tu QR en tu celular para poder imprimirlo y entregarselo a los clientes"),
          ],
        ),
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('introLogin');
  }

  Widget makePage({image, title, description, page}) {
    Widget _imagenArriba() {
      return Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(child: Container()),
                GestureDetector(
                    child: const Text("Omitir",
                        style: TextStyle(
                            color: Color.fromARGB(255, 134, 95, 197))),
                    onTap: () {
                      navigationPage();
                    }),
              ],
            ),
          ),
          Center(
            child: LottieBuilder.asset(
              image,
              onLoaded: (composition) {
                _lottieAnimation
                  ..duration = composition.duration
                  ..forward();
                _lottieAnimation.repeat();
              },
              frameRate: FrameRate.max,
              repeat: false,
              animate: false,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
              controller: _lottieAnimation,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: FittedBox(
              child: Text(
                title,
                style: KTextStyle.tituloStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              description,
              style: KTextStyle.descriptionStyle,
            ),
          ),
        ],
      );
    }

    Widget _imagenAbajo() {
      return Column(children: [
        const SizedBox(height: 10),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(child: Container()),
              GestureDetector(
                  child: const Text("Omitir",
                      style:
                          TextStyle(color: Color.fromARGB(255, 134, 95, 197))),
                  onTap: () {
                    navigationPage();
                  }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            title,
            style: KTextStyle.tituloStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            description,
            style: KTextStyle.descriptionStyle,
          ),
        ),
        Center(
          child: LottieBuilder.asset(
            image,
            onLoaded: (composition) {
              _lottieAnimation
                ..duration = composition.duration
                ..forward();
              _lottieAnimation.repeat();
            },
            frameRate: FrameRate.max,
            repeat: false,
            animate: false,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 1,
            controller: _lottieAnimation,
            fit: BoxFit.cover,
          ),
        ),
      ]);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (page % 2) == 0 ? _imagenArriba() : _imagenAbajo(),
        if (page == 4)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    elevation: 0,
                    backgroundColor: const Color.fromRGBO(141, 184, 235, 1),
                    onPressed: () {
                      navigationPage();
                    },
                    child: Text(
                      "Iniciar",
                      style: KTextStyle.textosStyle,
                    )),
              ],
            ),
          ),
      ],
    );
  }
}
