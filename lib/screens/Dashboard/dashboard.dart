import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_menu/bloc/auth/auth_bloc.dart';
import 'package:digital_menu/data/user.dart';
import 'package:digital_menu/screens/signin_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Obtener el usuario de la Instancia FirebaseAuth
  final user = FirebaseAuth.instance.currentUser!;
  UserModel usuario = UserModel();

  Future<void> _recibirDatos() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      usuario = UserModel.fromMap(value.data());
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              // Navegar a la pantalla de inicio de sesión cuando el usuario cierra la sesión
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (route) => false,
              );
            }
          },
          child: FutureBuilder(
              future: _recibirDatos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  // El futuro aún no ha terminado, devuelve un marcador de posición
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  );
                }
                //retorna carga completa
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email: \n ${usuario.email}',
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      usuario.image != null
                          ? SizedBox(
                              height: 100,
                              child: Image.network("${usuario.image}"))
                          : Container(),
                      usuario.name != null
                          ? Text("${usuario.name}")
                          : Container(),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        child: const Text('Sign Out'),
                        onPressed: () {
                          // Cierre de sesión del usuario
                          context.read<AuthBloc>().add(SignOutRequested());
                        },
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
