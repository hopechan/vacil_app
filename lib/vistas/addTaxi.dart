import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacil_app/modelos/taxi.dart';
import 'package:vacil_app/controlador/TaxiController.dart';

class VistaTaxi extends StatefulWidget{
  final Taxi taxi;
  VistaTaxi(this.taxi);
  @override
  State<StatefulWidget> createState() => new VistaTaxiState();
}

class VistaTaxiState extends State<VistaTaxi>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TaxiController db = new TaxiController();
  Taxi t;
  TextEditingController nombreTxt;
  TextEditingController apellidosTxt;
  TextEditingController telefonoTxt;
  TextEditingController yearTxt;
  TextEditingController marcaTxt;
  TextEditingController modeloTxt;
  TextEditingController placaTxt;
  bool formValidado = false;
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
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: new Text("Nuevo Taxi"), backgroundColor: Colors.amberAccent),
      body: Container(
        padding: new EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: new Form(  
          autovalidate: formValidado,
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                controller: nombreTxt,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Juan',
                  labelText: 'Nombre',
                  icon: Icon(FontAwesomeIcons.userCircle),
                  fillColor: Colors.amberAccent
                ),
                onSaved: (String valor){
                  this.t.nombreTaxista = valor;
                },
              ),
              new TextFormField(
                controller: apellidosTxt,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Perez',
                  labelText: 'Apellidos',
                  icon: Icon(FontAwesomeIcons.userCircle),
                  fillColor: Colors.amberAccent
                ),
                onSaved: (String valor){
                  this.t.apellidosTaxista = valor;
                },
              ),
              new TextFormField(
                controller: telefonoTxt,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  hintText: '61425210',
                  labelText: 'Telefono',
                  icon: Icon(FontAwesomeIcons.mobileAlt),
                  fillColor: Colors.amberAccent
                ),
                onSaved: (String valor){
                  this.t.telefono = valor;
                },
              ),
              new TextFormField(
                controller: yearTxt,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  hintText: '2018',
                  labelText: 'Año Vehiculo',
                  icon: Icon(FontAwesomeIcons.calendarAlt),
                  fillColor: Colors.amberAccent
                ),
                onSaved: (String valor){
                  this.t.year = valor;
                },
              ),
              new TextFormField(
                controller: marcaTxt,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Nissan',
                  labelText: 'Marca Auto',
                  icon: Icon(FontAwesomeIcons.carAlt),
                  fillColor: Colors.amberAccent
                ),
                onSaved: (String valor){
                  this.t.marca = valor;
                },
              ),
              new TextFormField(
                controller: modeloTxt,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Rogue',
                  labelText: 'Modelo Auto',
                  icon: Icon(FontAwesomeIcons.carAlt),
                  fillColor: Colors.amberAccent
                ),
                onSaved: (String valor){
                  this.t.modelo = valor;
                },
              ),
              new TextFormField(
                controller: placaTxt,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: new InputDecoration(
                  hintText: 'P123-456',
                  labelText: 'Placa Auto',
                  icon: Icon(FontAwesomeIcons.userCircle),
                  fillColor: Colors.amberAccent
                ),
                onSaved: (String valor){
                  this.t.placa = valor;
                },
              ),
              new Container(
                color: Colors.white10,
                width: screenSize.width,
                margin: new EdgeInsets.only(top: 20.0),
                child: new RaisedButton.icon(
                  label: (widget.taxi.idTaxista != null) 
                  ? Text('Actualizar Taxi', style: new TextStyle(color: Colors.black),) 
                  : Text('Nuevo Taxi', style: new TextStyle(color: Colors.black),),
                  icon: Icon(FontAwesomeIcons.save),
                  onPressed: (){
                    if (widget.taxi.idTaxista != null) {
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
                    } else {
                      db.crearTaxi(Taxi.crear(
                        nombreTxt.text,
                        apellidosTxt.text,
                        telefonoTxt.text,
                        yearTxt.text,
                        marcaTxt.text,
                        modeloTxt.text,
                        placaTxt.text
                        )).then((_){
                        Navigator.pop(context);
                      });
                    }
                  },
                  color: Colors.amberAccent,
                ),
              )
            ],
          )
        )
      ),
    );
  }
}