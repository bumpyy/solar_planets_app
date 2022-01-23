import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './UI/solar_planets.dart';

void main() => runApp(const MyApp());
List<Color> list = [Colors.yellow, Colors.green, Colors.blue];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        backgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontFamily: 'teko', color: Colors.white),
        ),
      ),
      home: const SolarPlanets(),
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
