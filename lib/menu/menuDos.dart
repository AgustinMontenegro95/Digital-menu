import 'package:digital_menu/data/models/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuDos extends StatefulWidget {
  final Color colorPrincipal;
  final Color colorFondo;
  final Image logo;
  final List<String> listaCat;
  final List<Producto> listaProd;
  final String nombreEmpresa;
  final String direccionEmpresa;
  final String telefonoEmpresa;

  const MenuDos(
      {Key? key,
      required this.colorPrincipal,
      required this.colorFondo,
      required this.logo,
      required this.listaCat,
      required this.listaProd,
      required this.nombreEmpresa,
      required this.direccionEmpresa,
      required this.telefonoEmpresa})
      : super(key: key);

  @override
  State<MenuDos> createState() => _MenuDosState();
}

class _MenuDosState extends State<MenuDos> {
  @override
  void initState() {
    _colorFondo();
    super.initState();
  }

  late Color colorSecundario;
  late Color colorFondoUno;
  late Color colorFondoDos;
  _colorFondo() {
    if (widget.colorFondo == Colors.white) {
      colorSecundario = Colors.black;
      colorFondoUno = Colors.white;
      colorFondoDos = Colors.white;
    } else if (widget.colorFondo == Colors.black) {
      colorSecundario = Colors.white;
      colorFondoUno = Colors.black87;
      colorFondoDos = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: media.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menuDos/fondo2.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(height: media.height * 0.07),
                  _desarrollado(media, colorSecundario, widget.colorPrincipal),
                  SizedBox(height: media.height * 0.05),
                  _presentacion(media, widget.nombreEmpresa,
                      widget.direccionEmpresa, widget.telefonoEmpresa),
                  SizedBox(height: media.height * 0.05),
                  ListView.builder(
                    itemCount: widget.listaCat.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, indexCat) {
                      return Column(
                        children: [
                          _categoria(media, widget.listaCat[indexCat],
                              widget.listaProd),
                          SizedBox(
                            height: media.height * 0.07,
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(height: media.height * 0.05),
                  _desarrollado(media, colorSecundario, widget.colorPrincipal),
                  SizedBox(height: media.height * 0.07),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desarrollado(Size media, Color color, Color colorSoluDev) {
    double tam = 12;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: media.width * 0.01),
          Text(
            'Digital Menu',
            style: GoogleFonts.raleway(
              textStyle:
                  TextStyle(color: color, letterSpacing: .5, fontSize: tam),
            ),
          ),
          SizedBox(width: media.width * 0.15),
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

  Widget _presentacion(
      Size media, String nombreRestaurant, String direccion, String telefono) {
    return Column(
      children: [
        SizedBox(
          //height: media.height * 0.7,
          width: media.width * 0.7,
          child: widget.logo,
        ),
        SizedBox(height: media.height * 0.02),
        Text(
          'MENÚ',
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
                color: widget.colorPrincipal, letterSpacing: .5, fontSize: 20),
          ),
        ),
        Text(
          nombreRestaurant,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: colorSecundario,
                fontSize: 22,
                decoration: TextDecoration.underline,
                decorationColor: widget.colorPrincipal,
                decorationThickness: 2),
          ),
        ),
        Text(
          direccion,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
                color: colorSecundario, letterSpacing: .5, fontSize: 13),
          ),
        ),
        Text(
          telefono,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
                color: colorSecundario, letterSpacing: .5, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _categoria(Size media, String categoria, List<Producto> lista) {
    return Stack(
      children: [
        ClipPath(
          clipper: PointsClipper(),
          child: Container(
            color: colorSecundario,
            height: media.height * 0.1,
            width: media.width,
          ),
        ),
        Column(
          children: [
            ClipPath(
              clipper: PointsClipper(),
              child: Container(
                color: widget.colorPrincipal,
                height: media.height * 0.08,
                width: media.width,
                child: Center(
                  child: Text(
                    categoria,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        letterSpacing: .5,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: media.height * 0.02),
            ListView.builder(
                itemCount: lista.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (lista[index].categoria == categoria) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: colorSecundario))),
                      child: ListTile(
                        title: Text(
                          lista[index].nombre!,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                                color: widget.colorPrincipal,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        subtitle: Text(
                          lista[index].descripcion!,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                                color: colorSecundario,
                                letterSpacing: 1,
                                fontSize: 15),
                          ),
                        ),
                        trailing: Text(
                          lista[index].precio!,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                                color: colorSecundario,
                                letterSpacing: 1,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
          ],
        ),
      ],
    );
  }
}
