import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacil_app/modelos/taxi.dart';

class DetalleTaxi extends StatefulWidget{
  final Taxi taxi;
  DetalleTaxi(this.taxi);
  @override
  State<StatefulWidget> createState() => new DetalleTaxiState();
}

class DetalleTaxiState extends State<DetalleTaxi>{
  Future<void> _launched;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context){
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(title: new Text("Detalle Taxista"), backgroundColor: Colors.amberAccent),
      body: Container(
        child: new Stack(
          children: <Widget>[
            //_getFoto(),
            _getGradiente(),
            _getDatos()
          ],
        ),
      ),
    );
  }

  Container _getFoto(){
    return new Container( 
      child: Image.asset('images/silueta.jpg', fit: BoxFit.cover, height: 200.0),
      constraints: new BoxConstraints.loose(Size(200.0, 200.0)),
    );
  }

  Container _getGradiente(){
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(0xFB7BA2),
            new Color(0xFCE043)
          ],
        stops: [0.0, 0.9],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getDatos(){
    return new Column(
      //padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 310.0),
      children: <Widget>[
        new Container(
          //padding: new EdgeInsets.symmetric(vertical: 310.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text('Datos Personales', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.indigoAccent), textAlign: TextAlign.center,),
              new ListTile(
                title: new Text(widget.taxi.getNombreTaxista + ' ' + widget.taxi.getApellidosTaxista, 
                  style: TextStyle(fontSize: 25.0)),
                trailing: new Icon(FontAwesomeIcons.userAlt, color: Colors.indigoAccent),
              ),
              new ListTile(
                title: new Text('Telefono: ' + widget.taxi.getTelefono,
                style: TextStyle(fontSize: 25.0)),
                trailing: new Icon(FontAwesomeIcons.phone, color: Colors.indigoAccent),
                onTap: ()=>setState((){
                  _launched = _makePhoneCall('tel:$widget.taxi.getTelefono');
                })
              ),
              Divider(),
              new Text('Datos Automovil', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.indigoAccent), textAlign: TextAlign.center,),
              new ListTile(
                title: new Text(widget.taxi.getMarca, 
                  style: TextStyle(fontSize: 25.0)),
                trailing: new Icon(FontAwesomeIcons.carAlt, color: Colors.indigoAccent),
              ),
              new ListTile(
                title: new Text(widget.taxi.getModelo, 
                  style: TextStyle(fontSize: 25.0)),
                trailing: new Icon(FontAwesomeIcons.carAlt, color: Colors.indigoAccent),
              ),
              new ListTile(
                title: new Text(widget.taxi.getYear, 
                  style: TextStyle(fontSize: 25.0)),
                trailing: new Icon(FontAwesomeIcons.calendarCheck, color: Colors.indigoAccent),
              ),
            ],
          ),
        )
      ],
    );
  }
}