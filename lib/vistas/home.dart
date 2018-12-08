import 'package:flutter/material.dart';
import 'package:vacil_app/state_widget.dart';
import 'package:vacil_app/modelos/state.dart';
import 'package:vacil_app/vistas/login.dart';
import 'package:vacil_app/vistas/widgets/botonesFlotantes.dart';
import 'package:vacil_app/vistas/widgets/drawer.dart';
import 'package:vacil_app/vistas/widgets/mapa.dart';

class PantallaHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PantallaHomeState();
}
class PantallaHomeState extends State<PantallaHome>{
  StateModel appState;
  Widget _buildHome({Widget body}){
    return Container(
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text(""),
        ),
        drawer: DrawerApp(),
        body: Mapa(),
        floatingActionButton: BotonesFlotantes(),
      ),
    );
  }

  Widget _buildContent() {
    if (appState.isLoading) {
      return _buildHome(
        body: _buildLoadingIndicator(),
      );
    } else if (!appState.isLoading && appState.usuario == null) {
      return new PantallaLogin();
    } else {
      return _buildHome();
    }
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    return _buildContent();
  }

}
