import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solarplanetsapp/UI/planet_screen.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:align_positioned/align_positioned.dart';

class SolarPlanets extends StatefulWidget {
  SolarPlanets({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SolarPlanetsState createState() => _SolarPlanetsState();
}

List<String> images = [
  "assets/images/earth-render-small.webp",
  "assets/images/jupiter-render-small.webp",
  "assets/images/mars-render-small.webp"
];

List<String> text0 = ["BUMI", "Jupiter", "Mars"];
List<Map<String, String>> textMap = [
  {"BUMI": "Planet Biru"},
  {
    "Jupiter": "entah apa",
  },
  {"Mars": "planet Merah"},
];
List<String> text1 = [
  "Planet Biru",
  "Entah, ntar lah cari tahu",
  "Planet merah"
];

class PlanetsCarousell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransformerPageView(
        loop: false,
//        viewportFraction: 0.8,
        transformer:
            PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
          return Stack(
            alignment: AlignmentDirectional.center,
//            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height * .2,
                child: Column(
//                mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ParallaxContainer(
                      child: Icon(
                        Icons.ac_unit,
                        color: Colors.white,
                      ),
                      position: info.position,
                      translationFactor: 300.0,
                    ),
                    //planet name
                    ParallaxContainer(
                      child: Text(
                        text0[info.index],
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .13),
                      ),
                      position: info.position,
                      translationFactor: 300.0,
                    ),
                    //planet nickname
                    ParallaxContainer(
                      child: Text(
                        text1[info.index],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .03,
                          color: Colors.grey,
                          fontFamily: 'Teko',
                        ),
                      ),
                      position: info.position,
                      translationFactor: 400.0,
                    ),
                  ],
                ),
              ),

              //Planet images
              AlignPositioned(
                moveByContainerHeight: .5,
                child: ParallaxContainer(
                  child: OverflowBox(
                    child: GestureDetector(
                      child: Hero(
                        child: Image.asset(
                          images[info.index],
                          width: MediaQuery.of(context).size.height * .8,
                        ),
                        tag: 'planet',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) => PlanetScreen(
                              planetName: text0[info.index],
                              planetImage: images[info.index],
                            ),
                          ),
                        );
                      },
                    ),
                    maxWidth: MediaQuery.of(context).size.width * 1.3,
//                    alignment: Alignment(0, (heightPx >= 760.0) ? 2.3 : 3.3),
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

class _SolarPlanetsState extends State<SolarPlanets>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    controller.forward();

    controller.addListener(() {
      print(controller.value);
    });
//    ScreenUtil.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PlanetsCarousell(),
    );
  }
}
