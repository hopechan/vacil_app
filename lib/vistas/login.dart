import 'package:flutter/material.dart';
import 'package:vacil_app/vistas/widgets/botonGoogle.dart';
import 'package:vacil_app/state_widget.dart';

class PantallaLogin extends StatefulWidget {
  @override
  _PantallaLoginState createState() => _PantallaLoginState();
}
class _PantallaLoginState extends State<PantallaLogin> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration _buildBackground() {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/fondo.jpg"),
          fit: BoxFit.cover,
        ),
      );
    }

    Image _buildText() {
      /*
      return Text(
        'Vacilando App',
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      );
      */
      return Image(
        image: AssetImage('images/logo.png'),
        fit: BoxFit.scaleDown,
      );
    }

    return Scaffold(
      body: Container(
        decoration: _buildBackground(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildText(),
              SizedBox(height: 50.0),
              BotonGoogleSignIn(
                // Passing function callback as constructor argument:
                onPressed: () => StateWidget.of(context).signInWithGoogle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}