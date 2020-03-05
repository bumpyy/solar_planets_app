import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class SolarPlanets extends StatefulWidget {
  SolarPlanets({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SolarPlanetsState createState() => new _SolarPlanetsState();
}

List<String> images = [
  "assets/images/earth-render-small.png",
  "assets/images/jupiter-render-small.png",
  "assets/images/mars-render-small.png"
];

List<String> text0 = ["Bumi", "Jupiter", "Mars"];
List<String> text1 = [
  "Planet hijau",
  "Entah, ntar lah cari tahu",
  "Planet merah"
];

class PlanetsCarousell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TransformerPageView(
        loop: false,
//        viewportFraction: 0.8,
        transformer: new PageTransformerBuilder(
            builder: (Widget child, TransformInfo info) {
          return new Stack(
//            fit: StackFit.expand,
            children: <Widget>[
              new Column(
//                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ParallaxContainer(
                    child: new Text(
                      text0[info.index],
                      style: new TextStyle(fontSize: 15.0),
                    ),
                    position: info.position,
                    translationFactor: 300.0,
                  ),
                  new SizedBox(
                    height: 8.0,
                  ),
                  new ParallaxContainer(
                    child: new Text(text1[info.index],
                        style: new TextStyle(fontSize: 18.0)),
                    position: info.position,
                    translationFactor: 200.0,
                  ),
                ],
              ),
              Positioned(
                child: ParallaxContainer(
                  child: OverflowBox(
                    child: Image.asset(
                      images[info.index],
                      width: MediaQuery.of(context).size.height * .8,
                    ),
                    maxWidth: MediaQuery.of(context).size.height * .6,
                    alignment: Alignment(0, 2.5),
                  ),
                  position: info.position,
                  translationFactor: 450.0,
                ),
              ),
            ],
          );
        }),
        itemCount: 3);
  }
}

class _SolarPlanetsState extends State<SolarPlanets> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PlanetsCarousell(),
    );
  }
}
