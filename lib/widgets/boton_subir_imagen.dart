import 'package:cloud_firestore/cloud_firestore.dart';
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
  const BotonSubirImagen(
      {Key? key,
      required this.storage,
      required this.firestore,
      required this.nombreImagen,
      required this.extencion,
      required this.screenshotController})
      : super(key: key);
  final String nombreImagen;
  final String extencion;

  final FirebaseStorage storage;
  final FirebaseFirestore firestore;
  final ScreenshotController screenshotController;

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
        String path = await FileSaver.instance
            .saveFile(nombreImagen, _imagefile, extencion, mimeType: type);
        log(path);
        // concateno el nombre con la ext para poder subir a fireStorage
        String imageName = nombreImagen + '.' + extencion;
        //se busca la imagen guardada y se crea un tipo File necesario para poder subir
        final file = File(path);
        //subir archivo a Storage
        TaskSnapshot snapshot =
            await storage.ref().child("images/$imageName").putFile(file);
        // si se subio sin problemas , se guarda la url en FireStore
        if (snapshot.state == TaskState.success) {
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          await firestore
              .collection("images")
              .add({"url": downloadUrl, "name": imageName});
          const snackBar = SnackBar(content: Text('Yay! Success'));
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
