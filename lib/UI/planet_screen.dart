import 'package:flutter/material.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PlanetScreen extends StatefulWidget {
  final String? planetImage;
  final String planetName;

  const PlanetScreen(
      {Key? key, required this.planetImage, required this.planetName})
      : super(key: key);

  @override
  _PlanetScreenState createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(top: 150),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: const Icon(
      //       Icons.chevron_left,
      //       color: Colors.black,
      //     ),
      //     backgroundColor: const Color.fromRGBO(255, 255, 255, 0.3),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      child: Hero(
                        child: AutoSizeText(
                          widget.planetName,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .17),
                        ),
                        tag: 'planetName',
                      ),
                    ),
                    AlignPositioned(
                      moveByContainerHeight: .05,
                      child: Hero(
                        tag: 'planetImage',
                        child: Image.asset(
                          widget.planetImage!,
                          width: MediaQuery.of(context).size.width * .9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 2000.0,
              )
            ],
          ),
          Positioned(
            top: 25,
            right: 5,
            child: Hero(
              tag: 'arrow',
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_circle_down,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  size: 35,
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(2),
                  primary:
                      const Color.fromRGBO(0, 0, 0, 0.5), // <-- Button color
                  onPrimary: Colors.red, // <-- Splash color
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
