import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './opciones.dart';
import 'package:vacil_app/vistas/mapa.dart';

String dato;
class Home extends StatefulWidget {
  HomeState  createState()=> HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                //se crean pestañas con sus respectivos iconos
                Tab(icon: Icon(FontAwesomeIcons.bus)),
                Tab(icon: Icon(FontAwesomeIcons.taxi)),
                Tab(icon: Icon(FontAwesomeIcons.walking))
              ],//fin pestañas
            ),//fin tabbar
          ),//fin app bar
          body: TabBarView(
            children: <Widget>[
              //Se llama y construye el widget de mapa y solo se muestra en la primera pestaña
              MapaState().build(context), 
              //las otras pestañas solo muestran un icono
              Icon(FontAwesomeIcons.taxi),
              Icon(FontAwesomeIcons.walking)
            ],
          ),
          //menú lateral 
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                //por el momento las imágenes de perfil y portada son puesta de manera Hardcode
                new UserAccountsDrawerHeader(
                  accountName: new Text("usuario"),
                  accountEmail: new Text("usuario@user.com"),
                  currentAccountPicture: new GestureDetector(
                    onTap: () => print("Se ha loggeado como usuario"),
                    child: CircleAvatar(
                      backgroundImage: new NetworkImage("https://img.fireden.net/v/image/1487/68/1487681871114.jpg"),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage("https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                      fit: BoxFit.fill
                    )
                  ),
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
                  trailing: new Icon(FontAwesomeIcons.arrowLeft)
                )
              ],
            )
          ),
        )
      )
    );
  }
}
