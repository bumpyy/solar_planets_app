import 'package:carousel_slider/carousel_slider.dart';
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xff080916),
      body: Stack(children: [
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
                            color: const Color.fromARGB(140, 255, 255, 255),
                            fontSize: MediaQuery.of(context).size.height * .17),
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
                        InfoCard(
                          icon: Icons.monitor_weight_outlined,
                          title: "Your Weight",
                          scaleUnit: "KL",
                          value: "27",
                        ),
                        InfoCard(
                          icon: Icons.cake_outlined,
                          title: "Your Age",
                          scaleUnit: "YRS",
                          value: "82",
                          scaleUnitSub: "OLD",
                        ),
                        InfoCard(
                          icon: Icons.monitor_weight_outlined,
                          title: "Your Weight",
                          scaleUnit: "KL",
                          value: "27",
                        ),
                        InfoCard(
                          icon: Icons.monitor_weight_outlined,
                          title: "Your Weight",
                          scaleUnit: "KL",
                          value: "27",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: "PLANETS STATS"),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                            bottom: 15.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              PlanetStatsItem(
                                title: "DAY",
                                subtitle: "LENGTH",
                                value: "58,6",
                                subText: "TERRESTRIAL DAYS",
                              ),
                              PlanetStatsItem(
                                title: "YEAR",
                                subtitle: "LENGTH",
                                value: "87,87",
                                subText: "TERRESTRIAL DAYS",
                                verticalBorder: true,
                              ),
                              PlanetStatsItem(
                                title: "MOONS",
                                value: "0",
                                subText: "--",
                              ),
                            ],
                          ),
                        ),
                        const SectionTitle(
                          title: "SIZE COMPARATION TO",
                          subTitle: "venus",
                        ),
                        const SectionTitle(
                          title: "FUN FACT",
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                          ),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '0$i',
                                        style: const TextStyle(
                                          fontSize: 200.0,
                                          height: 1.2,
                                          color: Colors.white10,
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "After the Earth, Mercury is the second densest planet. Despite it's small size. Mercury is very dense because its is composed mainly of heavy metals and rock",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          height: 2,
                                          fontSize: 14.0,
                                          fontFamily: 'roboto',
                                          color: Colors.white70,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        // Arrow button
        Positioned(
          top: 50,
          right: 20,
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
                primary: const Color.fromRGBO(0, 0, 0, 0.0), // <-- Button color
                side: const BorderSide(
                  color: Color.fromRGBO(255, 255, 255, .3),
                ),
                onPrimary: Colors.red, // <-- Splash color
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subTitle;
  const SectionTitle({
    Key? key,
    required this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.white10,
            width: 2.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white70,
              ),
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white38,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PlanetStatsItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String value;
  final String? subText;
  final bool verticalBorder;

  const PlanetStatsItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.value,
    this.subText,
    this.verticalBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: verticalBorder
            ? const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.white10,
                    width: 2.0,
                  ),
                ),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$title ',
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white54,
                    ),
                  ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            if (subText != null)
              Text(
                subText!,
                style: const TextStyle(
                  height: .8,
                  fontSize: 20.0,
                  color: Colors.white54,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String value;
  final String scaleUnit;
  final String? scaleUnitSub;

  const InfoCard({
    Key? key,
    this.icon,
    required this.title,
    required this.value,
    required this.scaleUnit,
    this.scaleUnitSub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 36, 36, 47),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          15.0,
          15.0,
          30.0,
          15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
              ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17.0,
                color: Color.fromRGBO(250, 250, 255, .4),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topLeft,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 55.0,
                      height: 1, //SETTING THIS CAN SOLVE YOUR PROBLEM
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scaleUnit,
                      style: const TextStyle(
                        fontSize: 25.0,
                        height: 1, //SETTING THIS CAN SOLVE YOUR PROBLEM
                      ),
                    ),
                    if (scaleUnitSub != null)
                      Text(
                        scaleUnitSub!,
                        style: const TextStyle(
                          fontSize: 17.0,
                          color: Color.fromRGBO(250, 250, 255, .4),
                          height: .8, //SETTING THIS CAN SOLVE YOUR PROBLEM
                        ),
                      ),
                  ],
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
