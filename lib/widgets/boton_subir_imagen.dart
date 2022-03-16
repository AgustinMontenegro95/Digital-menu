import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_menu/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import 'package:digital_menu/screens/qr_screen.dart';

class BotonSubirImagen extends StatelessWidget {
  final UserModel usuario;
  final String extencion;
  final ScreenshotController screenshotController;
  final storage = FirebaseStorage.instance;
  final store = FirebaseFirestore.instance;

  BotonSubirImagen(
      {Key? key,
      required this.usuario,
      required this.extencion,
      required this.screenshotController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        //permisos de aplicacion
        if (!kIsWeb) {
          if (Platform.isIOS || Platform.isAndroid || Platform.isMacOS) {
            bool status = await Permission.storage.isGranted;

            if (!status) {
              await Permission.storage.request();
            }
          }
        }
        //captura de pantalla
        Uint8List _imagefile = await screenshotController.capture(
            delay: const Duration(milliseconds: 10)) as Uint8List;

        //guardar el archivo en el directorio principal de la aplicacion
        MimeType type = MimeType.PNG;
        String path = await FileSaver.instance.saveFile(
            usuario.nombreEmpresa!, _imagefile, extencion,
            mimeType: type);
        //se busca la imagen guardada y se crea un tipo File necesario para poder subir
        final file = File(path);
        //subir archivo a Storage
        TaskSnapshot snapshot = await storage
            .ref()
            .child(
                "Empresas/${usuario.nombreEmpresa.toString()}/${usuario.nombreEmpresa.toString()}")
            .putFile(file);
        // si se subio sin problemas , se guarda la url en FireStore
        if (snapshot.state == TaskState.success) {
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          await store
              .collection("Empresas")
              .add({"url": downloadUrl, "name": usuario.nombreEmpresa});
          const snackBar = SnackBar(content: Text('QR creado exitosamente!'));
          //notificacin en pantalla
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QrScreen(
                        qrlink: downloadUrl,
                      )));
        } else {
          if (kDebugMode) {
            print('Error from image repo ${snapshot.state.toString()}');
          }
          throw ('This file is not an image');
        }
      },
      label: const Text('Elegir Plantilla'),
      icon: const Icon(Icons.check_circle),
      backgroundColor: Colors.pink,
    );
  }
}
