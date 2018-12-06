import 'package:flutter/material.dart';
import 'package:vacil_app/modelos/taxi.dart';
import 'package:vacil_app/controlador/TaxiController.dart';

class VistaTaxi extends StatefulWidget{
  final Taxi taxi;
  VistaTaxi(this.taxi);
  @override
  State<StatefulWidget> createState() => new VistaTaxiState();
}

class VistaTaxiState extends State<VistaTaxi>{
  TaxiController db = new TaxiController();
  TextEditingController nombreTxt;
  TextEditingController apellidosTxt;
  TextEditingController telefonoTxt;
  TextEditingController yearTxt;
  TextEditingController marcaTxt;
  TextEditingController modeloTxt;
  TextEditingController placaTxt;

  @override
  void initState() {
    super.initState();
    nombreTxt = new TextEditingController(text: widget.taxi.nombreTaxista);
    apellidosTxt = new TextEditingController(text: widget.taxi.apellidosTaxista);
    telefonoTxt = new TextEditingController(text: widget.taxi.telefono);
    yearTxt = new TextEditingController(text: widget.taxi.year);
    marcaTxt = new TextEditingController(text: widget.taxi.marca);
    modeloTxt = new TextEditingController(text: widget.taxi.modelo);
    placaTxt = new TextEditingController(text: widget.taxi.placa);
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: new Text("Nuevo Taxi")),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: nombreTxt,
              decoration: InputDecoration(labelText: "Nombre Taxista"),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: apellidosTxt,
              decoration: InputDecoration(labelText: "Apellidos Taxista"),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: telefonoTxt,
              decoration: InputDecoration(labelText: "Telefono"),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: yearTxt,
              decoration: InputDecoration(labelText: "Año auto"),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: marcaTxt,
              decoration: InputDecoration(labelText: "Marca Auto"),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: modeloTxt,
              decoration: InputDecoration(labelText: "Modelo Auto"),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: placaTxt,
              decoration: InputDecoration(labelText: "Placa Auto"),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.taxi.idTaxista != null) ? Text('Actualizar Taxi') : Text('Nuevo Taxi'),
              onPressed: (){
                if(widget.taxi.idTaxista != null){
                  db.actualizarTaxi(Taxi(
                    widget.taxi.getIdTaxista, 
                    widget.taxi.getNombreTaxista, 
                    widget.taxi.getApellidosTaxista, 
                    widget.taxi.getTelefono, 
                    widget.taxi.getYear, 
                    widget.taxi.getMarca, 
                    widget.taxi.getModelo, 
                    widget.taxi.getPlaca))
                    .then((_){
                    Navigator.pop(context);
                  });
                }else{
                  db.crearTaxi(Taxi.crear(
                    nombreTxt.text,
                    apellidosTxt.text,
                    telefonoTxt.text,
                    yearTxt.text,
                    marcaTxt.text,
                    modeloTxt.text,
                    placaTxt.text
                    ))
                    .then((_){
                    Navigator.pop(context);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}