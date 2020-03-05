import 'package:flutter/material.dart';
import './UI/home.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(new MyApp());
List<Color> list = [Colors.yellow, Colors.green, Colors.blue];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    ScreenUtil.init(context);
//    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: true);
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        backgroundColor: Colors.black,
        textTheme: TextTheme(
          body1: TextStyle(fontFamily: 'teko', color: Colors.white),
        ),
      ),
      home: SafeArea(child: new SolarPlanets(title: 'Solar Planets Skripsi')),
    );
  }
}
