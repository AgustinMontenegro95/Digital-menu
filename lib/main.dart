import 'package:digital_menu/bloc/auth/auth_bloc.dart';
import 'package:digital_menu/data/repositories/auth_repository.dart';
import 'package:digital_menu/routes/routes.dart';

import 'package:digital_menu/screens/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // Si el snapshot tiene datos del usuario, entonces ya han iniciado la sesión. Por lo tanto, la navegación va hacia el home().
                if (snapshot.hasData) {
                  return ResponsiveWrapper.builder(
                      const SplashScreen(route: 'home'),
                      maxWidth: 1200,
                      minWidth: 480,
                      defaultScale: true,
                      defaultName: MOBILE,
                      breakpoints: [
                        const ResponsiveBreakpoint.resize(360),
                        const ResponsiveBreakpoint.resize(450, name: MOBILE),
                        const ResponsiveBreakpoint.resize(640,
                            name: 'MOBILE_LARGE'),
                        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                        const ResponsiveBreakpoint.autoScale(1000,
                            name: TABLET),
                        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                        const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                      ],
                      background: Container(color: const Color(0xFFF5F5F5)));
                }
                // De lo contrario, no están registrados. Mostrar la página de inicio de sesión.
                return ResponsiveWrapper.builder(
                    const SplashScreen(route: 'intro'),
                    maxWidth: 1200,
                    minWidth: 480,
                    defaultScale: true,
                    defaultName: MOBILE,
                    breakpoints: [
                      const ResponsiveBreakpoint.resize(360),
                      const ResponsiveBreakpoint.resize(450, name: MOBILE),
                      const ResponsiveBreakpoint.resize(640,
                          name: 'MOBILE_LARGE'),
                      const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                      const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                      const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                      const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                    ],
                    background: Container(color: const Color(0xFFF5F5F5)));
              }),
          routes: appRoutes,
        ),
      ),
    );
  }
}
