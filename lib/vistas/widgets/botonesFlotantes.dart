import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacil_app/modelos/busStop.dart';
import 'package:vacil_app/vistas/widgets/mapa.dart';

class BotonesFlotantes extends StatefulWidget{
  @override
  BotonesFlotantesState createState() => new BotonesFlotantesState();
}

class BotonesFlotantesState extends State<BotonesFlotantes>{
  BusStop nuevoBus;
  TextEditingController rutaTxt;
  TextEditingController precioTxt;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      rutaTxt = new TextEditingController();
      precioTxt = new TextEditingController();
    }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          //solucion a la pantalla en negro :v
          heroTag: 'btnRuta',
          backgroundColor: Colors.amberAccent,
          child: Icon(FontAwesomeIcons.plus),
          onPressed: (){
            print("Tocaste el boton 1");
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.busAlt),
                            Text(
                              "Agregar Bus",
                              style: TextStyle(fontSize: 24.0),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 4.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: new TextField(
                            controller: rutaTxt,
                            autofocus: true,
                            decoration: new InputDecoration(
                              icon: Icon(FontAwesomeIcons.bus),
                              labelText: 'Ruta',
                              hintText: 'Ruta 8'
                            ),
                          maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: new TextField(
                            controller: precioTxt,
                            autofocus: true,
                            decoration: new InputDecoration(
                            icon: Icon(FontAwesomeIcons.dollarSign),
                            labelText: 'Precio',
                            hintText: '0.20'
                            )
                          )
                        ), 
                        Padding(padding: new EdgeInsets.all(3.0)),
                        InkWell(
                          child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                            ),
                            child: Text(
                              "Guardar Ruta",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: (){
                            MapaState().guardarBus(BusStop.marcador(rutaTxt.text, precioTxt.text));
                            print("Guardaste un bus :v");
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            );
          },
        ),
        Padding(padding: new EdgeInsets.all(5.0)),
        FloatingActionButton(
          heroTag: 'btnLocalizar',
          backgroundColor: Colors.amberAccent,
          child: Icon(FontAwesomeIcons.crosshairs),
          onPressed: (){
            print("Tocaste el boton 2");
          },
        )
      ],
    );
  }
}