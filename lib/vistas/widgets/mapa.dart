import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
/*Cosas por hacer:
 * 1.-Montar el mapa => listo \ :v /
 * 2.-Conseguir posicion actual 
 * 3.-Unir todo :'v
 * -89.573,13.971
 */
class Mapa extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new MapaState();
}

class MapaState extends State<Mapa>{
  Map<String, double> _posicionInicial;
  Map<String, double> _posicionActual;
  StreamSubscription<Map<String, double>> _posicionSub;
  Location posicion = new Location();
  bool permiso = false;
  String error;

  void initState(){
    super.initState();
    initPlatformState();
    _posicionSub = posicion.onLocationChanged().listen((Map<String,double> resultado){
      setState(() {
        _posicionActual = resultado;      
        });
    });
  }

  initPlatformState() async {
    Map<String, double> pos;
    try{
      permiso = await posicion.hasPermission();
      pos = await posicion.getLocation();
      error = null;
    }on PlatformException catch (e){
      if(e.code == 'PERMISSION_DENIED'){
        error = 'Permiso denegado';
      }else if(e.code == 'PERMISSION_DENIED_NEVER_ASK'){
        error = 'Permiso denagado. Por favor habilita el gps de tu movil';
      } 
      pos = null;
    }

    setState(() {
      _posicionInicial = pos;
    });
  }

  Widget build(BuildContext context){
    return new FlutterMap(
      options: new MapOptions(
        //coordenadas iniciales cuando inicia app
        center: new LatLng(_posicionActual["latitude"], _posicionActual["longitude"]),
        zoom: 15.0,
      ),
      layers: [
        new TileLayerOptions(
          //URL de mapbox con la llave 
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1Ijoib211bmUiLCJhIjoiY2pvbmRsMDJmMHR2djNscm93dWRqbGZyaCJ9._vn3SVRbXIoRz6wvpbdCAA',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 45.0,
              height: 45.0,
              point: new LatLng(_posicionActual["latitude"], _posicionActual["longitude"]),
              builder: (context) =>
              new Container(
                child: new IconButton(
                  icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                  color: Colors.redAccent,
                  iconSize: 45.0,
                  onPressed: () {
                    print("Tocaste un marcador");
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

