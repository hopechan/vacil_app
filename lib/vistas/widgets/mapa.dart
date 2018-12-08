import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:vacil_app/modelos/busStop.dart';
import 'package:vacil_app/controlador/BusController.dart';

class Mapa extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new MapaState();
}

class MapaState extends State<Mapa>{
  List<BusStop> items;
  StreamSubscription<QuerySnapshot> busSub;
  Map<String, double> _posicionInicial;
  Map<String, double> _posicionActual;
  Map<String, double> _posicionNuevoBus;
  StreamSubscription<Map<String, double>> _posicionSub;
  Location posicion = new Location();
  bool permiso = false;
  String error;
  BusController db = new BusController();

  Future<Null> guardarBus(BusStop b) async{
    Map<String, double> posicionBus;
    try {
      posicionBus = await posicion.getLocation();
      print(b.getRuta);
      print(b.getPrecio);
      print(posicionBus['latitude']);
      print(posicionBus['longitude']);
      db.crearBus(
        BusStop.crear(
          posicionBus['longitude'], 
          posicionBus['latitude'], 
          b.getRuta, 
          b.getPrecio
        )
      );
    } catch (e) {
      print(e);
    }
  }

  void initState(){
    super.initState();
    //obtener elementos desde la db
    items = new List();
    busSub?.cancel();
    busSub = db.getListaBus().listen((QuerySnapshot snapshot){
      final List<BusStop> buses = snapshot.documents
        .map((documentoSnapshot) => BusStop.fromMap(documentoSnapshot.data))
        .toList();
      setState(() {
        this.items = buses;
      });  
    });
    //cosos para longitud y latitud
    initPlatformState();
    _posicionSub = posicion.onLocationChanged().listen((Map<String,double> resultado){
      setState(() {
        _posicionNuevoBus = resultado;
        print(_posicionNuevoBus['latitude']);
        _posicionActual = resultado;      
        });
    });
  }

  @override
  void dispose() {
    busSub?.cancel();
    super.dispose();
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
        print(error);
      }else if(e.code == 'PERMISSION_DENIED_NEVER_ASK'){
        error = 'Permiso denagado. Por favor habilita el gps de tu movil';
        print(error);
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

