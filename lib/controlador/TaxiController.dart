import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vacil_app/modelos/taxi.dart';

final CollectionReference coleccionTaxis = Firestore.instance.collection('Taxis');


class TaxiController{
  static final TaxiController _instancia = new TaxiController.internal();
  factory TaxiController() => _instancia;
  TaxiController.internal();  

  Future<Taxi> crearTaxi(Taxi t) async {
    final TransactionHandler crear = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(coleccionTaxis.document());
      final Taxi taxi = new Taxi(ds.documentID, t.getNombreTaxista, t.getApellidosTaxista, t.getTelefono, t.getYear, t.getMarca, t.getModelo, t.getPlaca);
      final Map<String, dynamic> data = taxi.toMap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(crear).then((mapData) {
      return Taxi.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getListaTaxi({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = coleccionTaxis.snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Future<dynamic> actualizarTaxi(Taxi t) async {
    final TransactionHandler actualizar = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(coleccionTaxis.document(t.getIdTaxista));
      await tx.update(ds.reference, t.toMap());
      return {'updated': true};
    };
    return Firestore.instance
        .runTransaction(actualizar)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> borrarTaxi(String idTaxista) async {
    final TransactionHandler borrar = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(coleccionTaxis.document(idTaxista));
      await tx.delete(ds.reference);
      return {'deleted': true};
    };
    return Firestore.instance
        .runTransaction(borrar)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}  