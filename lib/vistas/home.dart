
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                Tab(icon: Icon(FontAwesomeIcons.bus)),
                Tab(icon: Icon(FontAwesomeIcons.taxi)),
                Tab(icon: Icon(FontAwesomeIcons.walking))
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Icon(FontAwesomeIcons.bus),
              Icon(FontAwesomeIcons.taxi),
              Icon(FontAwesomeIcons.walking)
            ],
          ),
        )
      )
    );
  }
}