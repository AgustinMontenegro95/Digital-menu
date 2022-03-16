import 'package:digital_menu/bloc/auth/auth_bloc.dart';
import 'package:digital_menu/screens/home_screen/home_screen.dart';
import 'package:digital_menu/styles/app_colors.dart';
import 'package:digital_menu/styles/text_styles.dart';
import 'package:digital_menu/widgets/custom_formfield.dart';
import 'package:digital_menu/widgets/fondo.dart';
import 'package:digital_menu/widgets/gradient_button.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late FocusNode focusMail, focusPassword;

  @override
  void initState() {
    focusMail = FocusNode();
    focusPassword = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    focusMail.dispose();
    focusPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text("SignIn"),
      ), */
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    crearFondo(context),
                    _loginForm(context),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  // void _authenticateWithGoogle(context) {
  //  BlocProvider.of<AuthBloc>(context).add(
  //  GoogleSignInRequested(),
  //);
  //}

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                const Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                const SizedBox(height: 60.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusPassword);
                  },
                  focusNode: focusMail,
                  textCapitalization: TextCapitalization.none,
                  headingText: 'Email',
                  hintText: 'Example@exa.com',
                  obsecureText: false,
                  suffixIcon: const Icon(
                    Icons.email,
                    color: Colors.amber,
                  ),
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  funcion: (value) {
                    return value != null && !EmailValidator.validate(value)
                        ? 'Enter a valid email'
                        : null;
                  },
                ),
                const SizedBox(height: 30.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusPassword);
                  },
                  focusNode: focusPassword,
                  textCapitalization: TextCapitalization.none,
                  headingText: 'Password',
                  hintText: 'Password',
                  obsecureText: true,
                  suffixIcon: const Icon(
                    Icons.password,
                    color: Color.fromARGB(216, 238, 120, 24),
                  ),
                  textInputType: TextInputType.text,
                  controller: _passwordController,
                  funcion: (value) {
                    if (value != null && value.length < 6) {
                      return "Enter min. 6 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: GradientButton(
                      child: Text(
                        "Login",
                        style: KTextStyle.textosStyle,
                      ),
                      onPressed: () {
                        _authenticateWithEmailAndPassword(context);
                      },
                      gradient: AppColors.gradient2),
                ),
              ],
            ),
          ),
          TextButton(
            child: const Text('¿Olvido la contraseña?'),
            onPressed: () {},
          ),
          const SizedBox(height: 100.0)
        ],
      ),
    );
  }
}
