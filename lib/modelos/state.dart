import 'package:firebase_auth/firebase_auth.dart';

class StateModel {
  bool isLoading;
  FirebaseUser usuario;

  StateModel({
    this.isLoading = false,
    this.usuario,
  });
}