import 'package:flutter/material.dart';

class PlanetScreen extends StatefulWidget {
  final String planetImage;
  final String planetName;

  const PlanetScreen({@required this.planetImage, @required this.planetName});

  @override
  _PlanetScreenState createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * .2,
          child: Hero(
            tag: 'planet',
            child: Image.asset(
              widget.planetImage,
              width: MediaQuery.of(context).size.width * .8,
            ),
          ),
        ),
      ]),
    );
  }
}
