import 'package:align_positioned/align_positioned.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:solarplanetsapp/Const/planets_data.dart';
import 'package:solarplanetsapp/Model/planet.dart';

Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    softWrap: false,
    style: DefaultTextStyle.of(fromHeroContext).style,
    child: toHeroContext.widget,
  );
}

Planet selectedPlanet = planets[0];

class PlanetsCarousell extends StatelessWidget {
  final Function updatePlanetIndexFunc;

  const PlanetsCarousell({Key? key, required this.updatePlanetIndexFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransformerPageView(
      onPageChanged: (index) {
        selectedPlanet = planets[index ?? 0];
        updatePlanetIndexFunc(selectedPlanet);
      },
      loop: false,
      // viewportFraction: .2,
      itemCount: planets.length,
      viewportFraction: .6,
      transformer:
          PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * .1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ParallaxContainer(
                    child: Lottie.asset(
                      'assets/lottie/planets.json',
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                    position: info.position!,
                    translationFactor: 300.0,
                  ),
                  //
                  //planet name
                  ParallaxContainer(
                    child: Hero(
                      flightShuttleBuilder: _flightShuttleBuilder,
                      child: Center(
                        child: AutoSizeText(
                          planets[info.index!].name,
//                          maxLines: 1,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .15),
                        ),
                      ),
                      tag: 'planetName',
                    ),
                    position: info.position!,
                    translationFactor: 100.0,
                  ),
                ],
              ),
            ),
            //planet nickname
            Positioned(
              top: MediaQuery.of(context).size.height * .3,
              child: ParallaxContainer(
                child: AutoSizeText(
                  planets[info.index!].nick,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * .03,
                    color: Colors.grey,
                    fontFamily: 'Teko',
                  ),
                ),
                position: info.position!,
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
                        planets[info.index!].image,
                        width: MediaQuery.of(context).size.height * .9,
                      ),
                      tag: 'planetImage',
                    ),
                    onTap: () {},
                  ),
                  maxWidth: MediaQuery.of(context).size.width * 1.5,
//                    alignment: Alignment(0, (heightPx >= 760.0) ? 2.3 : 3.3),
                ),
                position: info.position!,
                translationFactor: 600.0,
              ),
            ),
          ],
        );
      }),
    );
  }
}
