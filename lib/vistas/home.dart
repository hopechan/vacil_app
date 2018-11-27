import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './opciones.dart';
//import 'package:vacil_app/vistas/mapa.dart';
import 'package:vacil_app/vistas/login.dart';
import 'package:vacil_app/modelos/state.dart';
import 'package:vacil_app/state_widget.dart';
import 'package:vacil_app/vistas/widgets/mapa.dart';
import 'package:vacil_app/modelos/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PantallaHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PantallaHomeState();
}
class PantallaHomeState extends State<PantallaHome> {
  StateModel appState;
  Usuario usuarioApp;
  //Widget para tabs 
  DefaultTabController _buildTabView({Widget body}) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(FontAwesomeIcons.bus)),
              Tab(icon: Icon(FontAwesomeIcons.taxi)),
              Tab(icon: Icon(FontAwesomeIcons.walking))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //carga el mapa 
            Mapa(),
            Icon(FontAwesomeIcons.taxi),
            Icon(FontAwesomeIcons.walking)
          ],
        ),
        drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new FutureBuilder<FirebaseUser>(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      return new UserAccountsDrawerHeader(
                        accountName: new Text(snapshot.data.displayName),
                        accountEmail: new Text(snapshot.data.email),
                        currentAccountPicture: new GestureDetector(
                          onTap: () => print("Se ha loggeado como usuario"),
                          child: CircleAvatar(
                            backgroundImage: new NetworkImage(snapshot.data.photoUrl),
                          ),
                        ),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                          image: new NetworkImage("https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                          fit: BoxFit.fill
                        )
                      ),
                    );
                    
                    }else{
                      return new Text("Cargando...");
                    }
                  },
                ),
                //opciones del menú 
                new ListTile(
                  title: new Text("mis rutas"),
                  trailing: new Icon(FontAwesomeIcons.mapMarkerAlt),
                ),
                new ListTile(
                  title: new Text("opciones"),
                  trailing: new Icon(FontAwesomeIcons.cog),
                  //este menú cuando regresó a la pantalla principal me muestra un fondo negro
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext contex) => new Opciones()));
                  } 
                ),
                new ListTile(
                  title: new Text("cerrar"),
                  trailing: new Icon(FontAwesomeIcons.times),
                  onTap: () => Navigator.of(context).pop(),
                ),
                new Divider(),
                new ListTile(
                  title: new Text("Logout"),
                  trailing: new Icon(FontAwesomeIcons.arrowLeft),
                )
              ],
            )
          ),
      ),
    );
  }

  Widget _buildContent() {
    if (appState.isLoading) {
      return _buildTabView(
        body: _buildLoadingIndicator(),
      );
    } else if (!appState.isLoading && appState.usuario == null) {
      return new PantallaLogin();
    } else {
      return _buildTabView();
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