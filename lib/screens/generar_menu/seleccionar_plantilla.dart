import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_menu/data/models/producto_model.dart';
import 'package:digital_menu/data/models/user_model.dart';
import 'package:digital_menu/menu/menuUno.dart';
import 'package:digital_menu/widgets/boton_subir_imagen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screenshot/screenshot.dart';

class SeleccionarPlantilla extends StatefulWidget {
  final List<Producto>? listaProducto;
  final List<String>? listaCategoria;

  const SeleccionarPlantilla(
      {Key? key, this.listaProducto, this.listaCategoria})
      : super(key: key);

  @override
  State<SeleccionarPlantilla> createState() => _SeleccionarPlantillaState();
}

class _SeleccionarPlantillaState extends State<SeleccionarPlantilla> {
  Color colorFondo = Colors.white;
  Color pickerColorPrincipal = Colors.blue;
  Color currentColorPrincipal = Colors.blue;
  Color pickerColorFondo = Colors.white;
  Color currentColorFondo = Colors.white;

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

  void _onScroll() {}

  late PageController _pageController;

  @override
  void initState() {
    print(usuario.direccion);
    print(usuario.name);
    _pageController = PageController(
      initialPage: 0,
    )..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
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
              return _body();
            }));
  }

  Widget _body() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Text("PLANTILLAS"),
          Text("Elegí la plantilla que mas te guste."),
          SizedBox(height: 10),
          Container(
            color: Colors.red,
            width: double.maxFinite,
            height: 400,
            child: _pageView(
              colorPrincipal: currentColorPrincipal,
              colorFondo: currentColorFondo,
              listaCat: widget.listaCategoria,
              listaProd: widget.listaProducto,
              usuario: usuario,
            ),
          ),
          SizedBox(height: 10),
          Text("Ajustes"),
          _botonCambiarColorPrincipal(),
        ],
      ),
    ));
  }

  Widget _botonCambiarColorPrincipal() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: pickerColorPrincipal, //default color
                    onColorChanged: changeColorPrincipal,
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('DONE'),
                    onPressed: () {
                      setState(
                          () => currentColorPrincipal = pickerColorPrincipal);
                      Navigator.of(context).pop(); //dismiss the color picker
                    },
                  ),
                ],
              );
            });
      },
      child: Text("Color principal"),
    );
  }

  void changeColorPrincipal(Color color) {
    setState(() => pickerColorPrincipal = color);
  }

  Widget _pageView(
      {Color? colorPrincipal,
      Color? colorFondo,
      List<String>? listaCat,
      List<Producto>? listaProd,
      UserModel? usuario}) {
    List<Widget> menus = [
      MenuUno(
          colorPrincipal: colorPrincipal!,
          colorFondo: Colors.white,
          logo: usuario!.image.toString(),
          listaCat: listaCat!,
          listaProd: listaProd!,
          nombreEmpresa: usuario.nombreEmpresa.toString(),
          direccionEmpresa: usuario.direccion.toString(),
          telefonoEmpresa: usuario.telefono.toString()),
      MenuUno(
          colorPrincipal: colorPrincipal,
          colorFondo: Colors.black,
          logo: usuario.image.toString(),
          listaCat: listaCat,
          listaProd: listaProd,
          nombreEmpresa: usuario.nombreEmpresa.toString(),
          direccionEmpresa: usuario.direccion.toString(),
          telefonoEmpresa: usuario.telefono.toString())
    ];
    return PageView.builder(
      itemCount: menus.length,
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemBuilder: (context, index) {
        final ScreenshotController screenshotController =
            ScreenshotController();
        return SingleChildScrollView(
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: menus[index],
              ),
              BotonSubirImagen(
                  usuario: usuario,
                  extencion: "png",
                  screenshotController: screenshotController),
            ],
          ),
        );
      },
    );
  }
}
