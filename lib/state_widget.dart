import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vacil_app/modelos/state.dart';
import 'package:vacil_app/controlador/googleSignIn.dart';
import 'package:vacil_app/modelos/usuario.dart';

class StateWidget extends StatefulWidget{
  final StateModel state;
  final Widget child;

  StateWidget({
    @required this.child,
    this.state,
  });

  static _StateWidgetState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(_StateDataWidget)
        as _StateDataWidget).data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget>{
  StateModel state;
  GoogleSignInAccount cuentaGoogle;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }

  Future<Null> initUser() async {
    cuentaGoogle = await cuentaExistente(googleSignIn);
    if (cuentaGoogle== null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      await signInWithGoogle();
    }
  }

  Future<Null> signInWithGoogle() async {
    if (cuentaGoogle == null) {
      // Start the sign-in process:
      cuentaGoogle = await googleSignIn.signIn();
      Usuario usuarioApp = new Usuario();
      usuarioApp.snombreUsuario = cuentaGoogle.displayName;
      usuarioApp.sfotoUsuario = cuentaGoogle.photoUrl;
      usuarioApp.semailUsuario = cuentaGoogle.email;
    }
    FirebaseUser firebaseUser = await entrarFirebase(cuentaGoogle);
    setState(() {
      state.isLoading = false;
      state.usuario = firebaseUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}