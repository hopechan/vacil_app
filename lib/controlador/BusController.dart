import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vacil_app/modelos/busStop.dart';

final CollectionReference coleccionTaxis = Firestore.instance.collection('BusStops');


class BusController{
  static final BusController _instancia = new BusController.internal();
  factory BusController() => _instancia;
  BusController.internal();  

  Future<BusStop> crearBus(BusStop b) async {
    final TransactionHandler crear = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(coleccionTaxis.document());
      final BusStop busStop = new BusStop(ds.documentID,b.getLongitud, b.getLatitud, b.getRuta, b.getPrecio);
      final Map<String, dynamic> data = busStop.toMap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(crear).then((mapData) {
      return BusStop.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getListaBus({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = coleccionTaxis.snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Future<dynamic> actualizarBus(BusStop b) async {
    final TransactionHandler actualizar = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(coleccionTaxis.document(b.getId));
      await tx.update(ds.reference, b.toMap());
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

  Future<dynamic> borrarBus(String id) async {
    final TransactionHandler borrar = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(coleccionTaxis.document(id));
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