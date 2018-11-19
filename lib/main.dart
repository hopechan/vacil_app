import 'package:flutter/material.dart';
import 'package:vacil_app/vistas/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: SignIn(),
      ),
    );
  }
}