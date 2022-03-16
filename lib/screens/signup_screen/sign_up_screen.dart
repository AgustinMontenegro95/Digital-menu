import 'dart:io';

import 'package:digital_menu/bloc/auth/auth_bloc.dart';
import 'package:digital_menu/screens/Dashboard/dashboard.dart';
import 'package:digital_menu/styles/app_colors.dart';
import 'package:digital_menu/styles/text_styles.dart';
import 'package:digital_menu/widgets/custom_formfield.dart';
import 'package:digital_menu/widgets/fondo.dart';
import 'package:digital_menu/widgets/gradient_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _password = "";
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _nombreEmpresaController = TextEditingController();
  late FocusNode focusMail,
      focusPassword,
      focusRePassword,
      focusNombre,
      focusDireccion,
      focusTelefono,
      focusNombreEmpresa;
  @override
  void initState() {
    focusMail = FocusNode();
    focusPassword = FocusNode();
    focusRePassword = FocusNode();
    focusNombre = FocusNode();
    focusDireccion = FocusNode();
    focusTelefono = FocusNode();
    focusNombreEmpresa = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _nombreEmpresaController.dispose();

    focusMail.dispose();
    focusDireccion.dispose();
    focusNombre.dispose();
    focusNombreEmpresa.dispose();
    focusPassword.dispose();
    focusRePassword.dispose();
    focusTelefono.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              );
            }
            if (state is AuthError) {
              // Displaying the error message if the user is not authenticated
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              // Displaying the loading indicator while the user is signing up
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UnAuthenticated) {
              // Displaying the sign up form if the user is not authenticated
              // Showing the sign in form if the user is not authenticated
              return Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    crearFondo(context),
                    _signUpForm(context),
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

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
            _emailController.text,
            _passwordController.text,
            _nombreController.text,
            _direccionController.text,
            _telefonoController.text,
            _nombreEmpresaController.text,
            _image!.path),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  Widget _signUpForm(BuildContext context) {
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
                const Text('Registro', style: TextStyle(fontSize: 20.0)),
                const SizedBox(height: 60.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusNombre);
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
                    FocusScope.of(context).requestFocus(focusNombreEmpresa);
                  },
                  focusNode: focusNombre,
                  textCapitalization: TextCapitalization.words,
                  headingText: 'Nombre',
                  hintText: 'Ingresa tu nombre',
                  obsecureText: false,
                  suffixIcon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.amber,
                  ),
                  textInputType: TextInputType.name,
                  controller: _nombreController,
                  funcion: (value) {
                    if (value!.isEmpty) {
                      return "Ingresa tu Nombre";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusDireccion);
                  },
                  focusNode: focusNombreEmpresa,
                  textCapitalization: TextCapitalization.words,
                  headingText: 'Nombre de Empresa',
                  hintText: 'Ingrese su Empresa',
                  obsecureText: false,
                  suffixIcon: const Icon(
                    Icons.restaurant,
                    color: Colors.amber,
                  ),
                  textInputType: TextInputType.text,
                  controller: _nombreEmpresaController,
                  funcion: (value) {
                    if (value!.isEmpty) {
                      return "Ingresa el nombre de tu empresa";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusTelefono);
                  },
                  focusNode: focusDireccion,
                  textCapitalization: TextCapitalization.words,
                  headingText: 'Direccion',
                  hintText: 'Ingresa tu direccion',
                  obsecureText: false,
                  suffixIcon: const Icon(
                    Icons.location_city_rounded,
                    color: Colors.amber,
                  ),
                  textInputType: TextInputType.name,
                  controller: _direccionController,
                  funcion: (value) {
                    if (value!.isEmpty) {
                      return "Ingresa tu Direccion";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusPassword);
                  },
                  focusNode: focusTelefono,
                  textCapitalization: TextCapitalization.none,
                  headingText: 'Telefono',
                  hintText: 'Ingrese su Telefono',
                  obsecureText: false,
                  suffixIcon: const Icon(
                    Icons.phone_android_outlined,
                    color: Colors.amber,
                  ),
                  textInputType: TextInputType.number,
                  controller: _telefonoController,
                  funcion: (value) {
                    if (value!.isEmpty) {
                      return "Ingresa tu Telefono";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusRePassword);
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
                  onchange: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(height: 30.0),
                CustomFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(focusRePassword);
                  },
                  focusNode: focusRePassword,
                  textCapitalization: TextCapitalization.none,
                  headingText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  obsecureText: true,
                  suffixIcon: const Icon(
                    Icons.password,
                    color: Color.fromARGB(216, 238, 120, 24),
                  ),
                  textInputType: TextInputType.text,
                  controller: _rePasswordController,
                  funcion: (value) {
                    if (value!.isEmpty) {
                      return "Vuelve a ingresar la contraseña";
                    } else if (_password != value) {
                      return "Las contraseñas no coinciden";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _catchImage(),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: GradientButton(
                      child: Text(
                        "Sign Up",
                        style: KTextStyle.textosStyle,
                      ),
                      onPressed: () async {
                        //permisos de aplicacion
                        if (!kIsWeb) {
                          if (Platform.isIOS ||
                              Platform.isAndroid ||
                              Platform.isMacOS) {
                            bool status = await Permission.storage.isGranted;

                            if (!status) {
                              await Permission.storage.request();
                            }
                          }
                        }
                        _createAccountWithEmailAndPassword(context);
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

  _catchImage() {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(children: [
        Center(
          child: ElevatedButton(
            child: const Text('Select An Image'),
            onPressed: _openImagePicker,
          ),
        ),
        const SizedBox(height: 35),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 300,
          color: Colors.grey[300],
          child: _image != null
              ? Image.file(_image!, fit: BoxFit.cover)
              : Image(image: AssetImage("assets/images/subirimage.jpg")),
        )
      ]),
    );
  }

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
}
