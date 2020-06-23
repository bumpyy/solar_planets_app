import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solarplanetsapp/UI/planet_screen.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SolarPlanets extends StatefulWidget {
  SolarPlanets({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SolarPlanetsState createState() => _SolarPlanetsState();
}

Map<String, String> images = {
  "MERKURIUS": 'assets/images/mercury-render-small.webp',
  "VENUS": 'assets/images/venus-render-small.webp',
  "BUMI": 'assets/images/earth-render-small.webp',
  "BULAN": 'assets/images/moon-render-small.webp',
  "MARS": 'assets/images/mars-render-small.webp',
  "JUPITER": 'assets/images/jupiter-render-small.webp',
  "NEPTUNUS": 'assets/images/neptune-render-small.webp',
  "SATURNUS": 'assets/images/saturn-render-small.webp',
  "URANUS": 'assets/images/uranus-render-small.webp',
  "PLUTO": 'assets/images/pluto-render-small.webp',
};

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

Map<String, String> planetsNick = {
  "MERKURIUS": 'Swift Planet',
  "VENUS": 'Morning star',
  "BUMI": 'Blue Planet',
  "BULAN": '',
  "MARS": 'Red Planet',
  "JUPITER": 'Giant Planet',
  "NEPTUNUS": 'Big Blue Planet',
  "SATURNUS": 'Ringed Planet',
  "URANUS": 'Ice Giant',
  "PLUTO": 'The forgoten',
};
Map<String, Map<String, String>> planetTemp = {
  "MERKURIUS": {'day': 'Swift Planet', 'night': ''},
  "VENUS": {'day': 'Swift Planet', 'night': ''},
  "BUMI": {'day': 'Swift Planet', 'night': ''},
  "BULAN": {'day': 'Swift Planet', 'night': ''},
  "MARS": {'day': 'Swift Planet', 'night': ''},
  "JUPITER": {'day': 'Swift Planet', 'night': ''},
  "NEPTUNUS": {'day': 'Swift Planet', 'night': ''},
  "SATURNUS": {'day': 'Swift Planet', 'night': ''},
  "URANUS": {'day': 'Swift Planet', 'night': ''},
  "PLUTO": {'day': 'Swift Planet', 'night': ''},
};

int planetIndex = 0;

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
        onPageChanged: (index) {
          planetIndex = index;
        },
        loop: false,
//        viewportFraction: 0.8,
        transformer:
            PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
          return Stack(
            alignment: AlignmentDirectional.center,
//            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height * .1,
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
                        child: Center(
                          child: AutoSizeText(
                            planetsName[info.index],
//                          maxLines: 1,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * .15),
                          ),
                        ),
                        tag: 'planetName',
                      ),
                      position: info.position,
                      translationFactor: 300.0,
                    ),
                  ],
                ),
              ),
              //planet nickname
              Positioned(
                top: MediaQuery.of(context).size.height * .3,
                child: ParallaxContainer(
                  child: AutoSizeText(
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
              ),

              //Planet images
              AlignPositioned(
                moveByContainerHeight: .4,
                child: ParallaxContainer(
                  child: OverflowBox(
                    child: GestureDetector(
                      child: Hero(
                        child: Image.asset(
                          images[planetsName[info.index]],
                          width: MediaQuery.of(context).size.height * .9,
                        ),
                        tag: 'planetImage',
                      ),
                      onTap: () {},
                    ),
                    maxWidth: MediaQuery.of(context).size.width * 1.5,
//                    alignment: Alignment(0, (heightPx >= 760.0) ? 2.3 : 3.3),
                  ),
                  position: info.position,
                  translationFactor: 450.0,
                ),
              ),

              //buttom bar

              //
              //
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
    super.initState();
//    controller = AnimationController(
//      duration: Duration(seconds: 1),
//      vsync: this,
//    );

//    controller.forward();
//
//    controller.addListener(() {
//      print(controller.value);
//    });
//    ScreenUtil.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              pageBuilder: (_, __, ___) => PlanetScreen(
                planetName: planetsName[planetIndex],
                planetImage: images[planetsName[planetIndex]],
              ),
            ),
          );
        },
        child: Icon(Icons.keyboard_arrow_up),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PlanetsCarousell(),
          IgnorePointer(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.center,
                  end: AlignmentDirectional.bottomCenter,
                  colors: <Color>[
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromARGB(50, 0, 0, 0),
                    Color.fromARGB(100, 0, 0, 0),
                    Color.fromARGB(220, 0, 0, 0),
//                    Color.fromARGB(255, 0, 0, 0)
                  ],
//                radius: 5.0,
//                center: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Positioned(
                bottom: 80,
                left: 1,
                right: 1,
                child: Divider(
//              height: 50,
                  thickness: 1, color: Color.fromARGB(120, 255, 255, 255),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: AlignPositioned(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        //At day
                        child: Row(
                          children: <Widget>[
                            AutoSizeText(
                              'at\nDay',
                              style: TextStyle(
//                          wordSpacing: 10,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                height: 1,
                                color: Colors.grey,
                                fontFamily: 'Teko',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            AutoSizeText(
                              'at\nDay',
                              style: TextStyle(
//                          wordSpacing: 10,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                height: 1,
                                color: Colors.grey,
                                fontFamily: 'Teko',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            AutoSizeText(
                              'at\nNight',
                              style: TextStyle(
//                          wordSpacing: 10,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                height: 1,
                                color: Colors.grey,
                                fontFamily: 'Teko',
                              ),
                            ),
                            AutoSizeText(
                              'at\nNight',
                              style: TextStyle(
//                          wordSpacing: 10,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                                height: 1,
                                color: Colors.grey,
                                fontFamily: 'Teko',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
//                  flex: ,
                        child: SizedBox(
                          width: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
