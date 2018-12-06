import 'package:flutter/material.dart';
import 'package:vacil_app/vistas/home.dart';
import 'package:vacil_app/vistas/login.dart';
import 'package:vacil_app/vistas/taxistas.dart';

class VacilApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Vacilando',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => PantallaHome(),
        '/login': (context) => PantallaLogin()
      },
    );
  }
}