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
  List<BusStop> itemsdb;
  List<Marker> marcadores = [];
  List<Marker> sameBusStop = [];
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
    itemsdb = new List();
    //se usa ?. para evitar que el operador de la izquierda lanze excepcion cuando sea null :v
    busSub?.cancel();
    busSub = db.getListaBus().listen((QuerySnapshot snapshot){
      final List<BusStop> buses = snapshot.documents
        .map((documentoSnapshot) => BusStop.fromMap(documentoSnapshot.data))
        .toList();
      setState(() {
        this.itemsdb = buses;
      });  
    });
    //cosos para longitud y latitud
    initPlatformState();
    _posicionSub = posicion.onLocationChanged().listen((Map<String,double> resultado){
      setState(() {
        _posicionNuevoBus = resultado;
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
    return StreamBuilder(
      stream: Firestore.instance.collection('BusStops').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return Text("Cargado mapa.. Espera");
        marcadores.add(new Marker(
          width: 30.0,
          height: 30.0,
          point: new LatLng(_posicionActual['latitude'], _posicionActual['longitude']),
          builder: (context) =>
            new Container(
              child: new IconButton(
                icon: Icon(FontAwesomeIcons.mapMarker),
                color: Colors.redAccent,
                iconSize: 30.0,
                onPressed: (){
                  
                },
              ),
            )
        ));
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          marcadores.add(new Marker(
              width: 25.0,
              height: 25.0,
              point: new LatLng(snapshot.data.documents[i]['Latitud'], snapshot.data.documents[i]['Longitud']),
              builder: (context) => new Container(
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.busAlt),
                  color: Colors.indigoAccent,
                  iconSize: 25.0,
                  onPressed: (){
                    print(snapshot.data.documents[i]['Ruta']);
                    showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),  
                          ),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          content: Container(
                            width: 300.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.bus),
                                    Text('Buses'),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Divider(color: Colors.grey,height: 4.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: new Column(
                                    children: <Widget>[
                                      Text('Ruta: ' + snapshot.data.documents[i]['Ruta']),
                                      Text('Precio: ' + snapshot.data.documents[i]['Precio'].toString())
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  },
                ),
              )
            )
          );
        }
        return new FlutterMap(
          options: new MapOptions(
          //coordenadas iniciales cuando inicia app
            center: new LatLng(_posicionActual['latitude'], _posicionActual['longitude']),
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
              markers: marcadores
            ),
          ],
        );
      },
    );
  }
}

