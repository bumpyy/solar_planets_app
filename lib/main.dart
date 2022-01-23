import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './UI/solar_planets.dart';

void main() => runApp(new MyApp());
List<Color> list = [Colors.yellow, Colors.green, Colors.blue];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    ScreenUtil.init(context);
//    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: true);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        backgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontFamily: 'teko', color: Colors.white),
        ),
      ),
      home: SafeArea(child: new SolarPlanets(title: 'Solar Planets Skripsi')),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
