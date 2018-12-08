import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vacil_app/modelos/taxi.dart';
import 'package:vacil_app/controlador/TaxiController.dart';
import 'package:vacil_app/vistas/addTaxi.dart';


class ListViewTaxi extends StatefulWidget {
  @override
  _ListViewTaxiState createState() => new _ListViewTaxiState();
}

class _ListViewTaxiState extends State<ListViewTaxi> {
  List<Taxi> items;
  TaxiController db = new TaxiController();
  StreamSubscription<QuerySnapshot> taxiSub;

  @override
  void initState() {
    super.initState();
    items = new List();
    taxiSub?.cancel();
    taxiSub = db.getListaTaxi().listen((QuerySnapshot snapshot) {
      final List<Taxi> taxis = snapshot.documents
          .map((documentSnapshot) => Taxi.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.items = taxis;
      });
    });
  }

  @override
  void dispose() {
    taxiSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxistas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Taxistas'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].getNombreTaxista + items[position].getApellidosTaxista}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].getTelefono}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${position + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          /*
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _borrarTaxi(context, items[position], position)),
                          */
                        ],
                      ),
                      onTap: () => _navigateToTaxi(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _nuevoTaxi(context),
        ),
      ),
    );
  }

  void _navigateToTaxi(BuildContext context, Taxi t) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VistaTaxi(t)),
    );
  }

  void _nuevoTaxi(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VistaTaxi(Taxi(null, '', '', '', '','','',''))),
    );
  }
}