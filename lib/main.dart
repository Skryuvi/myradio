import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myradio/ui/page_drawer_scaffold.dart';
import 'package:page_transition/page_transition.dart';


import 'models/model_latest.dart';
import 'network/fetcher_previous.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late BorderRadiusTween borderRadius;
  List<LatestModel>? listPrevious = [];
  var isPlaying = false;
  final Duration _duration = Duration(milliseconds: 500);
  late AnimationController _controller;
  double percentage = 1.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            child: const Icon(CupertinoIcons.list_dash),
            onTap: () {
              openDrawerScaffold();
            },
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(32, 37, 50, 1),
            Color.fromRGBO(26, 28, 39, 1)
          ])),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      top: MediaQuery.of(context).size.height * 0.1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(CupertinoIcons.profile_circled),
                      )),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: 0,
                      right: 0,
                      child: Text(
                        'Ранее в эфире',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.normal),
                      )),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.22,
                      bottom: MediaQuery.of(context).size.height * 0.13,
                      left: 0,
                      right: 0,
                      child: FutureBuilder(
                          future: getPrevious(),
                          builder: (context, snapshot) => snapshot.hasData
                              ?
                              //list of previous
                              ListView.builder(
                                  itemCount: listPrevious?.length,
                                  itemBuilder: (context, index) =>
                                      //previous item
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent),
                                          height: 60,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  top: 8,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          listPrevious?[index]
                                                                  .title ??
                                                              '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16)))),
                                              Positioned(
                                                left: 2,
                                                bottom: 2,
                                                top: 2,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: Colors
                                                                .transparent),
                                                        child: Image.network(
                                                            listPrevious?[index]
                                                                    .info
                                                                    ?.images
                                                                    ?.original ??
                                                                ""))),
                                              )
                                            ],
                                          )))
                              : Container())),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: DraggableScrollableSheet(
                        initialChildSize: 1,
                        minChildSize: 0.25,
                        maxChildSize: 1,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return AnimatedBuilder(
                              animation: scrollController,
                              builder: (context, child) {
                                if (scrollController.hasClients) {
                                  percentage = scrollController
                                          .position.viewportDimension /
                                      (MediaQuery.of(context).size.height);
                                  print(percentage / 0.22);
                                }
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                        child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                            Color.fromRGBO(57, 40, 60, 1),
                                            Color.fromRGBO(21, 22, 22, 1)
                                          ])),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              percentage,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(

                                                  top: percentage > 0.27
                                                      ? (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.33 *
                                                          percentage)
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.15 *
                                                          percentage,

                                                  child:Align(
                                                    alignment: Alignment.topCenter,
                                                      child:
                                                  Opacity(
                                                      opacity: percentage > 0.2
                                                          ? percentage
                                                          : percentage / 0.22,
                                                      child: Text('track name',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))))),
                                              Positioned.fill(
                                                top: MediaQuery.of(context).size.height * 0.4,

                                                child:Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Opacity(
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(100),
                                                        child: Container(
                                                            decoration:
                                                            BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100),
                                                              color: Colors.grey
                                                                  .withAlpha(
                                                                  80),
                                                            ),
                                                            height: 100,
                                                            width: 100,
                                                            child: Center(
                                                                child:
                                                                CupertinoButton(

                                                                  onPressed: () {

                                                                  }, child: Icon(
                                                                    Icons
                                                                        .play_arrow_rounded,
                                                                    size: 70, color: Colors.white),
                                                                )))),
                                                    opacity: percentage),)
                                              ),
                                              Positioned(
                                                top: 22 * percentage,

                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9 *
                                                    percentage ,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(
                                                        16),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    16)),
                                                        width: MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                3 *
                                                                percentage +
                                                            30,
                                                        height: MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                3 *
                                                                percentage +
                                                            30,
                                                        child: Image.network(
                                                            'https://picsum.photos/200/300',
                                                            fit: BoxFit.fill))),
                                              ),
                                              Positioned(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      12 *
                                                      percentage,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5 *
                                                      percentage,
                                                  child: Opacity(
                                                      opacity: percentage <= 0.4
                                                          ? 0.22 / percentage
                                                          : 0,
                                                      child: Icon(
                                                        Icons
                                                            .play_arrow_rounded,
                                                        color: Colors.white,
                                                        size: 10 / percentage,
                                                      )))
                                            ],
                                          ),
                                        );
                                      },
                                      controller: scrollController,
                                      scrollDirection: Axis.vertical,
                                    )));
                              });
                        },
                      ))
                ],
              )),
        ));
  }

  @override
  initState() {
    super.initState();
    getPrevious().then((value) => listPrevious = value.model ?? []);

    _controller = AnimationController(vsync: this, duration: _duration);
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(75.0),
      end: BorderRadius.circular(0.0),
    );
  }

  void openDrawerScaffold() {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: DrawerPage()));
  }
}
