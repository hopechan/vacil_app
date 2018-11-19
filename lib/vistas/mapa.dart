import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart'; //>:v
import 'package:flutter/material.dart';

class Mapa extends StatefulWidget{
  MapaState createState()=> MapaState(); 
}

class MapaState extends State<Mapa>{
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        //coordenadas iniciales cuando inicia app
        center: new LatLng(51.5, -0.09),
        zoom: 13.0,
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
              width: 80.0,
              height: 80.0,
              point: new LatLng(51.5, -0.09),
              builder: (ctx) =>
              new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
