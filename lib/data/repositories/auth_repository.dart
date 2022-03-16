import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_menu/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _store = FirebaseFirestore.instance;

  Future<void> signUp(
      {required String email,
      required String password,
      required String nombre,
      required String dir,
      required String telefono,
      required String nombreEmpresa,
      required String imagen}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: email.toString(), password: password.toString())
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        UserModel userModel = UserModel();

        //se busca la imagen guardada y se crea un tipo File necesario para poder subir
        final file = File(imagen.toString());
        //subir archivo a Storage
        TaskSnapshot snapshot = await _storage
            .ref()
            .child(
                "Empresas/${nombreEmpresa.toString()}/menu_${nombreEmpresa.toString()}")
            .putFile(file);
        // si se subio sin problemas , se guarda la url en FireStore
        if (snapshot.state == TaskState.success) {
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          userModel.email = email.toString();
          userModel.direccion = dir.toString();
          userModel.telefono = telefono.toString();
          userModel.name = nombre.toString();
          userModel.nombreEmpresa = nombreEmpresa.toString();
          userModel.image = downloadUrl.toString();
          userModel.uid = user!.uid;
          await _store.collection("users").doc(user.uid).set(userModel.toMap());
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
