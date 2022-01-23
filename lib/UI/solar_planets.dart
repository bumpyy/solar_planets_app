import 'package:flutter/material.dart';
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
  _SolarPlanetsState createState() => _SolarPlanetsState();
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
              const PlanetsCarousell(
                updatePlanetIndexFunc: updatePlanetIndex,
              ),
              IgnorePointer(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
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
                  const Positioned(
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
                            child: BottomNavText(
                              text: "at\nDay",
                              value: selectedPlanet.tempDay,
                            ),
                          ),
                          Expanded(
                            child: BottomNavText(
                              text: "at\nnight",
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
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          duration: const Duration(seconds: 1),
                                          reverseDuration:
                                              const Duration(milliseconds: 600),
                                          opaque: true,
                                          child: PlanetScreen(
                                            planetName: selectedPlanet.name,
                                            planetImage: selectedPlanet.image,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromRGBO(255, 255, 255, .5),
                                      size: 35,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(8),
                                      primary: const Color.fromRGBO(
                                          0, 0, 0, 0), // <-- Button color
                                      side: const BorderSide(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(255, 255, 255, .3),
                                      ),
                                      onPrimary: Colors.red, // <-- Splash color
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
                ],
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
  final String value;
  const BottomNavText({Key? key, required this.text, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AutoSizeText(
          text,
          style: TextStyle(
            //                          wordSpacing: 10,
            fontSize: MediaQuery.of(context).size.height * .03,
            height: 1,
            color: Colors.grey,
            fontFamily: 'Teko',
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        AutoSizeText(
          value,
          style: TextStyle(
            //                          wordSpacing: 10,
            fontSize: MediaQuery.of(context).size.height * .03,
            height: 1,
            color: Colors.grey,
            fontFamily: 'Teko',
          ),
        ),
      ],
    );
  }
}

updatePlanetIndex(Planet planet) {
  selectedPlanet = planet;
}
