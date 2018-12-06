import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacil_app/vistas/taxistas.dart';
class DrawerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Drawer(
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
                    onTap: () => print("Holi :3"),
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
                return new Text("Cargando");
              }
            },
          ),
          new ListTile(
            title: new Text("Usar Taxi"),
            trailing: Icon(FontAwesomeIcons.taxi),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new ListViewTaxi()));
            },
          )
        ],
      ),
    );
  }
}