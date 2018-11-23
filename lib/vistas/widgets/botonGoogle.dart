
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonGoogleSignIn extends StatelessWidget {
  BotonGoogleSignIn({this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            alignment: new Alignment(0.0 ,0.0),
            child: RaisedButton.icon(
              onPressed: this.onPressed,
              textColor: Colors.black,
              color: Colors.white,
              icon: new Icon(FontAwesomeIcons.google, color: Colors.redAccent),
              label: new Text(
                " Entrar con Google",
                style: new TextStyle(
                color: Colors.black
                )
              ),
            ),
          ),
        ],
      );
  }
}