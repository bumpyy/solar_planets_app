import 'package:flutter/material.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/scheduler.dart';

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
                              color: Color.fromARGB(140, 255, 255, 255),
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
              Column(
                children: [
                  for (int i = 0; i < 133; i++)
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
                ],
              )
            ],
          ),
          Positioned(
            top: 25,
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
                    width: 1.0,
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
