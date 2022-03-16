import 'package:digital_menu/data/models/producto_model.dart';
import 'package:digital_menu/screens/generar_menu/seleccionar_plantilla.dart';
import 'package:digital_menu/screens/generar_menu/cargar_producto.dart';
import 'package:flutter/material.dart';

class CargarMenu extends StatefulWidget {
  @override
  _CargarMenuState createState() => _CargarMenuState();
}

class _CargarMenuState extends State<CargarMenu> {
  final _listaCategoria = [
    'Entradas',
    'Hamburguesas',
    'Lomitos',
    'Milanesa',
    'Pizza', /* 
    'Al plato',
    'Tragos',
    'Bebidas',
    'Postres', */
  ];
  final List<Producto> _listaProducto = [
    Producto(
        categoria: "Hamburguesas",
        nombre: "Big cheddar",
        descripcion: "Pan, carne, huevo, cheddar",
        precio: "450.00"),
    Producto(
        categoria: "Hamburguesa",
        nombre: "Verdeo",
        descripcion: "Pan, carne, huevo, verdeo",
        precio: "600.00"),
    Producto(
        categoria: "Lomitos",
        nombre: "Verdeo",
        descripcion: "Pan, carne, huevo, verdeo",
        precio: "600.00"),
    Producto(
        categoria: "Lomitos",
        nombre: "Cheddar",
        descripcion: "Pan, carne, huevo, cheddar",
        precio: "600.00"),
    Producto(
        categoria: "Pizza",
        nombre: "Peperoni",
        descripcion: "Muzza, peperoni, salsa",
        precio: "800.00"),
    Producto(
        categoria: "Pizza",
        nombre: "4 Quesos",
        descripcion:
            "Muzza, roquefort, parmesano, provolone, salsa, aceitunas, oregano, morron ",
        precio: "970.00"),
  ];

  final _categoriaController = TextEditingController();

  @override
  void dispose() {
    _categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Crear menu"),
              SizedBox(height: 10),
              _nuevaCategoria(),
              SizedBox(height: 10),
              _nuevoProducto(),
              SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _listaCategoria.length,
                itemBuilder: (context, index) {
                  final item = _listaCategoria[index];
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.white,
                      ),
                    ),
                    key: Key(item),
                    // También debemos proporcionar una función que diga a nuestra aplicación
                    // qué hacer después de que un elemento ha sido eliminado.
                    onDismissed: (direction) {
                      // Remueve el elemento de nuestro data source.
                      setState(() {
                        _listaCategoria.removeAt(index);
                      });

                      // Luego muestra un snackbar!
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "La categoria: '${item}' ha sido borrada.")));
                    },
                    child: Card(
                      child: ExpansionTile(
                        title: Text(
                          _listaCategoria[index],
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        children: <Widget>[
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, indexProd) {
                                final item = _listaProducto[indexProd];
                                if (_listaProducto[indexProd].categoria ==
                                    _listaCategoria[index]) {
                                  return Dismissible(
                                    background: Container(
                                      color: Colors.red,
                                      child: Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    key: Key(item.nombre!),
                                    // También debemos proporcionar una función que diga a nuestra aplicación
                                    // qué hacer después de que un elemento ha sido eliminado.
                                    onDismissed: (direction) {
                                      // Remueve el elemento de nuestro data source.
                                      setState(() {
                                        _listaProducto.removeAt(indexProd);
                                      });
                                      // Luego muestra un snackbar!
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "El producto: '${item.nombre}' de la categoria: '${item.categoria}' ha sido borrado.")));
                                    },
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                            _listaProducto[indexProd].nombre!),
                                        subtitle: Text(_listaProducto[indexProd]
                                            .descripcion!),
                                        trailing: Text(
                                            _listaProducto[indexProd].precio!),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              },
                              itemCount: _listaProducto.length),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              /* Container(
                    height: 75.0,
                    width: 75.0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: FittedBox(child: Text("Seleccionar plantilla")),
                    ),
                  ), */
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        //ir a plantillas
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeleccionarPlantilla(
                                    listaProducto: _listaProducto,
                                    listaCategoria: _listaCategoria,
                                  )),
                        ) /* .then((_) => setState(() {})) */;
                      },
                      child: FittedBox(child: Text(" Siguiente ")),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      /* floatingActionButton: Container(
          height: 100.0,
          width: 100.0,
          child: FittedBox(
            child: FloatingActionButton(onPressed: () {}),
          ),
        ),
      ), */
    ));
  }

  Widget _nuevaCategoria() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text("NUEVA CATEGORIA"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(width: 200, child: _textFieldCategoria()),
              ElevatedButton(
                child: Icon(Icons.add),
                onPressed: addItemCategoria,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nuevoProducto() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text("NUEVO PRODUCTO"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Agregar producto"),
              ElevatedButton(
                child: Icon(Icons.add),
                onPressed: addItemProducto,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textFieldCategoria() {
    return TextFormField(
        //focusNode: focusCiudad,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        controller: _categoriaController,
        /* onSaved: (newValue) {
          ciudadEditingController.text = newValue!;
        }, */
        validator: (value) {
          if (value!.isEmpty) {
            return "Ingresa una categoria valida.";
          }
          return null;
        },
        decoration: InputDecoration(
          helperText: "Ej. 'Hamburguesas'",
          //labelText: "labelText",
          //labelStyle: const TextStyle(color: Colors.red),
          hintText: "Ingresa categoria",
          hintStyle: TextStyle(color: Colors.grey[400]),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(Icons.abc_rounded),
          suffixIconColor: Colors.amber,
        ));
    /* validator: ,
      
      decoration: InputDecoration(
          hintText: "Ingrese la categoria",
          prefixIcon: Icon(Icons.category_outlined)),
      controller: _categoriaController,
    ); */
  }

  void addItemCategoria() {
    setState(() {
      _listaCategoria.add(_categoriaController.text);
      FocusScope.of(context).requestFocus(FocusNode());
      _categoriaController.clear();
    });
  }

  void addItemProducto() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CargarProducto(
                listaProducto: _listaProducto,
                listaCategoria: _listaCategoria,
              )),
    ).then((_) => setState(() {}));
    /* setState(() {
      _listaProducto.add(Producto(
          categoria: "Hamburguesa",
          nombre: "Verdeo",
          descripcion: "Pan, carne, papas, verdeo",
          precio: "470.00"));
    }); */
  }
}
