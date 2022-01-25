import 'package:flutter/material.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/scheduler.dart';

class PlanetScreen extends StatefulWidget {
  final String planetImage;
  final String planetName;

  const PlanetScreen(
      {Key? key, required this.planetImage, required this.planetName})
      : super(key: key);

  @override
  _PlanetScreenState createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  Future<void> _scrollToTopAndPop() async {
    bool scrollLocationAtBegining = _scrollController.position.atEdge &&
        !(_scrollController.position.pixels >
            _scrollController.position.minScrollExtent);

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
    });
    await Future.delayed(
            Duration(milliseconds: scrollLocationAtBegining ? 0 : 810))
        .then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
            ),
            child: ListView(
              controller: _scrollController,
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
                                color: const Color.fromARGB(140, 255, 255, 255),
                                fontSize:
                                    MediaQuery.of(context).size.height * .17),
                          ),
                          tag: 'planetName',
                        ),
                      ),
                      AlignPositioned(
                        moveByContainerHeight: .12,
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
                ScrollConfiguration(
                  behavior: RemoveScrollGlow(),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 10.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            InfoCard(),
                            InfoCard(),
                            InfoCard(),
                            InfoCard(),
                            InfoCard(),
                            InfoCard(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // Arrow button
          Positioned(
            top: 20,
            right: 15,
            child: Hero(
              tag: 'arrow',
              child: ElevatedButton(
                onPressed: _scrollToTopAndPop,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  size: 35,
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                  primary:
                      const Color.fromRGBO(0, 0, 0, 0.0), // <-- Button color
                  side: const BorderSide(
                    color: Color.fromRGBO(255, 255, 255, .3),
                  ),
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

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 36, 36, 47),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          15.0,
          15.0,
          25.0,
          15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.monitor_weight_outlined,
              color: Colors.white,
            ),
            const Text(
              "Your Weight",
              style: TextStyle(
                fontSize: 15.0,
                color: Color.fromRGBO(250, 250, 255, .4),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "27",
                  style: TextStyle(
                    fontSize: 55.0,
                    color: Color.fromRGBO(250, 250, 255, .4),
                  ),
                ),
                Text(
                  "KL",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color.fromRGBO(250, 250, 255, .4),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
