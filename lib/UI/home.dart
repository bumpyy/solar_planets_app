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

Map<String, String> images = {
  "BUMI": 'assets/images/earth-render-small.webp',
  "JUPITER": 'assets/images/jupiter-render-small.webp',
  "MARS": 'assets/images/mars-render-small.webp',
  "MERKURIUS": 'assets/images/mercury-render-small.webp',
  "BULAN": 'assets/images/moon-render-small.webp',
  "NEPTUNUS": 'assets/images/neptune-render-small.webp',
  "PLUTO": 'assets/images/pluto-render-small.webp',
  "SATURNUS": 'assets/images/saturn-render-small.webp',
  "URANUS": 'assets/images/uranus-render-small.webp',
  "VENUS": 'assets/images/venus-render-small.webp',
};

//List<String> text0 = ["BUMI", "Jupiter", "Mars"];
List<String> planetsName = [
  "MERKURIUS",
  "VENUS",
  "BUMI",
  "BULAN",
  "MARS",
  "JUPITER",
  "NEPTUNUS",
  "SATURNUS",
  "URANUS",
  "PLUTO",
];
//
//List<String> planetsNick = [
//  "assets/images/earth-render-small.webp",
//  "assets/images/jupiter-render-small.webp",
//  "assets/images/mars-render-small.webp",
//  "assets/images/mercury-render-small.webp",
//  "assets/images/moon-render-small.webp",
//  "assets/images/neptune-render-small.webp",
//  "assets/images/pluto-render-small.webp",
//  "assets/images/saturn-render-small.webp",
//  "assets/images/uranus-render-small.webp",
//  "assets/images/venus-render-small.webp",
//];

Map<String, String> planetsNick = {
  "BUMI": 'Blue Planet',
  "JUPITER": 'Giant Planet',
  "MARS": 'Red Planet',
  "MERKURIUS": 'Swift Planet',
  "BULAN": '',
  "NEPTUNUS": 'Big Blue Planet',
  "PLUTO": 'The forgoten',
  "SATURNUS": 'Ringed Planet',
  "URANUS": 'Ice Giant',
  "VENUS": 'Morning star',
};

//List<String> text1 = [
//  "Planet Biru",
//  "Entah, ntar lah cari tahu",
//  "Planet merah"
//];

Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    softWrap: false,
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}

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
                    //
                    //planet name
                    ParallaxContainer(
                      child: Hero(
                        flightShuttleBuilder: _flightShuttleBuilder,
                        child: Text(
                          planetsName[info.index],
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .13),
                        ),
                        tag: 'planetName',
                      ),
                      position: info.position,
                      translationFactor: 300.0,
                    ),
                    //planet nickname
                    ParallaxContainer(
                      child: Text(
                        planetsNick[planetsName[info.index]],
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
                          images[planetsName[info.index]],
                          width: MediaQuery.of(context).size.height * .8,
                        ),
                        tag: 'planetImage',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (_, __, ___) => PlanetScreen(
                              planetName: planetsName[info.index],
                              planetImage: images[planetsName[info.index]],
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
        itemCount: images.length);
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
