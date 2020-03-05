import 'package:flutter/material.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:transformer_page_view/parallax.dart';
import 'package:align_positioned/align_positioned.dart';

class PlanetScreen extends StatefulWidget {
  final String planetImage;
  final String planetName;

  const PlanetScreen({@required this.planetImage, @required this.planetName});

  @override
  _PlanetScreenState createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          Container(
//            decoration: BoxDecoration(color: Colors.red),
            height: MediaQuery.of(context).size.height * .6,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Parallax.inside(
                  child: Center(
                    child: Hero(
                      child: Text(
                        widget.planetName,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .15),
                      ),
                      tag: 'planetName',
                    ),
                  ),
                  mainAxisExtent: 500.0,
                ),
                AlignPositioned(
                  moveByContainerHeight: .05,
                  child: Hero(
                    tag: 'planetImage',
                    child: Image.asset(
                      widget.planetImage,
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2000.0,
          )
        ],
      ),
    );
  }
}
