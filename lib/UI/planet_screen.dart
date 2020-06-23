import 'package:flutter/material.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
    final TextStyle style = Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 50,
          fontWeight: FontWeight.normal,
        );
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
                      child: AutoSizeText(
                        widget.planetName,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .17),
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
                      width: MediaQuery.of(context).size.width * .9,
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
