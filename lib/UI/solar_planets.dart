import 'package:flutter/material.dart';
import 'package:odometer/odometer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solarplanetsapp/Const/planets_data.dart';
import 'package:solarplanetsapp/Model/planet.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:solarplanetsapp/UI/planet_screen.dart';
import 'package:solarplanetsapp/Widget/planet_carousel.dart';

class SolarPlanets extends StatefulWidget {
  const SolarPlanets({Key? key}) : super(key: key);

  @override
  State<SolarPlanets> createState() => _SolarPlanetsState();
}

Planet selectedPlanet = planets[0];

class _SolarPlanetsState extends State<SolarPlanets>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updatePlanetIndex(Planet planet) {
      setState(() {
        selectedPlanet = planet;
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_stars.jpg'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: <Widget>[
              PlanetsCarousell(
                updatePlanetIndexFunc: updatePlanetIndex,
              ),
              AlignPositioned(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                        Colors.black,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color.fromARGB(68, 255, 255, 255),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: BottomNavText(
                              text: "AT\nDAY",
                              value: selectedPlanet.tempDay,
                            ),
                          ),
                          Expanded(
                            child: BottomNavText(
                              text: "AT\nNIGHT",
                              value: selectedPlanet.tempDay,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Hero(
                                  tag: "arrow",
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   PageRouteBuilder(
                                      //       pageBuilder: (_, __, ___) =>
                                      //           PlanetScreen(
                                      //             planetName:
                                      //                 selectedPlanet.name,
                                      //             planetImage:
                                      //                 selectedPlanet.image,
                                      //           ),
                                      //       transitionDuration:
                                      //           Duration(seconds: 1),
                                      //       opaque: false),
                                      // );

                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          duration: const Duration(seconds: 1),
                                          reverseDuration:
                                              const Duration(seconds: 1),
                                          opaque: true,
                                          child: PlanetScreen(
                                            planetName: selectedPlanet.name,
                                            planetImage: selectedPlanet.image,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(8),
                                      primary: const Color.fromRGBO(
                                          0, 0, 0, 0), // <-- Button color
                                      side: const BorderSide(
                                        color:
                                            Color.fromRGBO(255, 255, 255, .3),
                                      ),
                                      onPrimary: Colors.red, // <-- Splash color
                                    ),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromRGBO(255, 255, 255, .5),
                                      size: 35,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavText extends StatelessWidget {
  final String text;
  final int value;
  const BottomNavText({Key? key, required this.text, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          text,
          style: const TextStyle(
            fontSize: 20,
            height: 1,
            color: Colors.grey,
            fontFamily: 'Teko',
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        AnimatedSlideOdometerNumber(
          letterWidth: 18,
          curve: Curves.easeInOut,
          numberTextStyle: const TextStyle(
            fontSize: 50,
            height: .5,
            fontFamily: 'Teko',
          ),
          odometerNumber: OdometerNumber(value),
          duration: const Duration(
            seconds: 1,
            milliseconds: 30,
          ),
        )
      ],
    );
  }
}
