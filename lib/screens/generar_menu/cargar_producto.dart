import 'package:digital_menu/data/models/producto_model.dart';
import 'package:flutter/material.dart';

class CargarProducto extends StatefulWidget {
  final List<Producto>? listaProducto;
  final List<String>? listaCategoria;

  const CargarProducto({Key? key, this.listaProducto, this.listaCategoria})
      : super(key: key);

  @override
  State<CargarProducto> createState() => _CargarProductoState();
}

class _CargarProductoState extends State<CargarProducto> {
  int _currentStep = 0;
  bool isCompleted = false;

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController precioController = TextEditingController();

  late FocusNode focusNombre;
  late FocusNode focusDescripcion;
  late FocusNode focusPrecio;

  String? _dropdownValue;
  @override
  void initState() {
    _dropdownValue = widget.listaCategoria![0];
    focusNombre = FocusNode();
    focusDescripcion = FocusNode();
    focusPrecio = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNombre.dispose();
    focusDescripcion.dispose();
    focusPrecio.dispose();
    nombreController.dispose();
    descripcionController.dispose();
    precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text("DemoStepper"),
      ), */
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Agregar producto",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Text("Segui los pasos para agregar un producto"),
            _stepper(),
          ],
        ),
      ),
    );
  }

  Widget _stepper() {
    if (isCompleted) {
      return Container();
    } else {
      return Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: Colors.blue)),
        child: Stepper(
          //indica cual es el paso actual del stepper
          currentStep: this._currentStep,
          //numero de pasos
          steps: getSteps(),
          type: StepperType.vertical,
          physics: ScrollPhysics(),
          onStepContinue: () {
            final isLastStep = _currentStep == getSteps().length - 1;
            if (isLastStep) {
              setState(() {
                isCompleted = true;
              });
              print('Completed');
              //mandar datos al servidor
              Producto producto = Producto();
              producto.categoria = _dropdownValue;
              producto.nombre = nombreController.text;
              producto.descripcion = descripcionController.text;
              producto.precio = precioController.text;
              widget.listaProducto?.add(producto);
              Navigator.pop(context);
            } else {
              setState(() {
                _currentStep += 1;
              });
            }
          },
          onStepCancel: () {
            if (_currentStep == 0) {
              null;
            } else {
              setState(() {
                _currentStep = _currentStep - 1;
              });
            }
          },
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          controlsBuilder: (context, details) {
            final isLastStep = _currentStep == getSteps().length - 1;
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(isLastStep ? 'CONFIRMAR' : 'SIGUIENTE'),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  if (_currentStep != 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: Text("VOLVER"),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  List<Step> getSteps() {
    return [
      Step(
          title: Text("Ingresa la categoria"),
          subtitle: Text("Paso 1"),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.editing,
          content: _dropdownCategoria()),
      Step(
        title: Text("Ingresa el nombre"),
        subtitle: Text("Paso 2"),
        isActive: _currentStep >= 1,
        state: _currentStep > 1
            ? StepState.complete
            : _currentStep == 1
                ? StepState.editing
                : StepState.indexed,
        content: Container(
          child: _textField(
              hintText: "Ingrese el nombre",
              controller: nombreController,
              focusNode: focusNombre,
              focusNodeSiguiente: focusDescripcion),
        ),
      ),
      Step(
        title: Text("Ingresa una descripción"),
        subtitle: Text("Paso 3"),
        isActive: _currentStep >= 2,
        state: _currentStep > 2
            ? StepState.complete
            : _currentStep == 2
                ? StepState.editing
                : StepState.indexed,
        content: Container(
          child: _textField(
              hintText: "Ingresa una desocripción",
              controller: descripcionController,
              focusNode: focusDescripcion,
              focusNodeSiguiente: focusPrecio),
        ),
      ),
      Step(
        title: Text("Ingresa su precio"),
        subtitle: Text("Paso 4"),
        isActive: _currentStep >= 3,
        state: _currentStep > 3
            ? StepState.complete
            : _currentStep == 3
                ? StepState.editing
                : StepState.indexed,
        content: Container(
          child: _textField(
              hintText: "Ingresa su precio",
              controller: precioController,
              focusNode: focusPrecio,
              textInputType: TextInputType.number,
              focusNodeSiguiente: focusPrecio),
        ),
      ),
      Step(
        title: Text("Confirmar producto"),
        subtitle: Text("Paso 5"),
        isActive: _currentStep >= 4,
        state: _currentStep > 4
            ? StepState.complete
            : _currentStep == 4
                ? StepState.editing
                : StepState.indexed,
        content: Column(
          children: [
            Row(
              children: [
                Text("Categoria:"),
                SizedBox(width: 10),
                Text(_dropdownValue!),
                Text("."),
              ],
            ),
            Row(
              children: [
                Text("Nombre:"),
                SizedBox(width: 10),
                Text(nombreController.text),
                Text("."),
              ],
            ),
            Row(
              children: [
                Text("Descripcion:"),
                SizedBox(width: 10),
                Text(descripcionController.text),
                Text("."),
              ],
            ),
            Row(
              children: [
                Text("Precio:"),
                SizedBox(width: 10),
                Text(precioController.text),
                Text("."),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  Widget _dropdownCategoria() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
      child: DropdownButton<String>(
        value: _dropdownValue,
        isExpanded: true,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
            decoration:
                const BoxDecoration(border: Border(bottom: BorderSide.none))),
        menuMaxHeight: 250,
        borderRadius: BorderRadius.circular(20),
        onChanged: (String? newValue) {
          setState(() {
            _dropdownValue = newValue.toString();
          });
        },
        /* hint: Container(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Selecciona una categoria",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "Muli"),
          ),
        ), */
        items: widget.listaCategoria!
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text("  $value"),
          );
        }).toList(),
      ),
    );
  }

  Widget _textField(
      {required String hintText,
      required TextEditingController controller,
      required FocusNode focusNode,
      required FocusNode focusNodeSiguiente,
      TextInputType textInputType = TextInputType.name}) {
    return TextField(
      autofocus: false,
      focusNode: focusNode,
      controller: controller,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.sentences,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(focusNodeSiguiente),
      decoration:
          InputDecoration(border: OutlineInputBorder(), hintText: hintText),
    );
  }

  /* Widget buildCompleted() {
    return Column(
      children: [
        Icon(
          Icons.check,
          color: Colors.blue,
          size: 250,
        ),
        SizedBox(
          height: 100,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            textStyle: TextStyle(fontSize: 24),
            minimumSize: Size.fromHeight(50),
          ),
          onPressed: () {
            setState(() {
              isCompleted = false;
              _currentStep = 0;

              //aqui limpiar variables creadas en los pasos
            });
          },
          child: Text('RESETEAR'),
        ),
      ],
    );
  } */
}
