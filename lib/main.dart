import 'package:flutter/material.dart';
import './UI/home.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(new MyApp());
List<Color> list = [Colors.yellow, Colors.green, Colors.blue];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light()
          .copyWith(primaryColor: Colors.blue, backgroundColor: Colors.black),
      home: SafeArea(child: new SolarPlanets(title: 'Solar Planets Skripsi')),
    );
  }
}
