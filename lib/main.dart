import 'package:another_xlider/another_xlider.dart';
import 'package:bored/cards.dart';
import 'package:bored/http.dart';
import 'package:collapsible/collapsible.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main()async{
  response = await Dio().get(
          "http://www.boredapi.com/api/activity/");
  runApp(const MyApp());
}
var response = Response(
    requestOptions:
        RequestOptions(path: "http://www.boredapi.com/api/activity/"),);
List<TextEditingController> tec =
    List.generate(3, (_) => TextEditingController());
int tecIndex = 0;
//bool _col = false;
double lowerValue = 0.0;
double upperValue = 50.0;
//  late int lowerValue1;
double activity = 0.0;
double screenH = 20.0;
// List<TextField> tf =
//     List.generate(6, (i) => TextField(controller:tec[i]));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bored App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Bored(),
    );
  }
}

class Bored extends StatefulWidget {
   Bored({Key? key}) : super(key: key);

  @override
  _BoredState createState() => _BoredState();
}

RefreshController refreshController = RefreshController(initialRefresh: false);
GlobalKey k = GlobalKey();

class _BoredState extends State<Bored> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getHttp(tecIndex);
  // }

  @override
  Widget build(BuildContext context) {
    screenH = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getHttp(tecIndex),
        builder: (context, snapshot) => (snapshot.hasData)
            ? Scaffold(
                backgroundColor: Color.fromARGB(255, 154, 6, 128),
                drawer: Drawer(
                  backgroundColor: Color(0xFF355898F),
                  child: Container(
                    //width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        TextField(
                          enabled: true,
                          onChanged: (_) => {tecIndex = 0},
                          controller: tec[0],
                          decoration: const InputDecoration(
                            labelText: "Type of Activity",
                          ),
                        ),
                        Text("OR"),
                        TextField(
                          enabled: true,
                          onChanged: (_) => {tecIndex = 1},
                          controller: tec[1],
                          decoration: const InputDecoration(
                            labelText: "No. of Participants",
                          ),
                        ),
                        Text("OR"),
                        TextField(
                          enabled: true,
                          onChanged: (_) => {tecIndex = 2},
                          controller: tec[2],
                          decoration: const InputDecoration(
                            labelText:
                                "% of Wallet Money You Are Ready To Spend",
                          ),
                        ),
                        Text("OR"),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: FlutterSlider(
                            selectByTap: true,
                            tooltip: FlutterSliderTooltip(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                                leftPrefix: Icon(
                                  Icons.attach_money,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                rightPrefix: Icon(
                                  Icons.attach_money,
                                  size: 20,
                                  color: Colors.green,
                                )),
                            step: FlutterSliderStep(step: 1),
                            handler: FlutterSliderHandler(
                                child: const Text("Price Range")),
                            handlerWidth: 50,
                            values: [lowerValue, upperValue],
                            //List.generate(100, (index) => index.toDouble()),
                            max: 100,
                            min: 0,
                            rangeSlider: true,
                            onDragging:
                                (handlerIndex, lowerValueX, upperValueX) {
                              lowerValue = lowerValueX;
                              upperValue = upperValueX;
                              tecIndex = 3;
                              setState(() {});
                            },
                            // onDragCompleted:
                            //     (handlerIndex, lowerValueX, upperValueX) {
                            //   tecIndex = 3;
                            //   lowerValue = lowerValueX;
                            //   upperValue = upperValueX;
                            // },
                          ),
                        ),
                        Text("OR"),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: FlutterSlider(
                            selectByTap: true,
                            tooltip: FlutterSliderTooltip(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                            step: FlutterSliderStep(step: 0.1),
                            handler: FlutterSliderHandler(
                                child: const Text("Activity Intensity")),
                            handlerWidth: 50,
                            values: [activity],
                            max: 1.0,
                            min: 0.0,
                            onDragging:
                                (handlerIndex, lowerValue1, upperValue1) {
                              tecIndex = 4;
                              activity = lowerValue1;
                              setState(() {});
                            },
                          ),
                        ),
                        // Hero(
                        //   tag: "hero1",
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         setState(() {
                        //           _col = !_col;
                        //         });
                        //       },
                        //       child: Icon(Icons.arrow_upward)),
                        // ),
                      ],
                    ),
                  ),
                ),
                appBar: AppBar(
                  title: Text("Bored App Idea Generator"),
                ),
                body: SmartRefresher(
                  controller: refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    key: k,
                    child: Expanded(
                      child: Column(
                        children: [
                          Title(
                              color: Colors.black,
                              child: Text(
                                "Swipe Down To Load Suggestions And Click on Menu Button To Personalize Suggestions",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              )),
                          // (_col)
                          //     ? Center(
                          //         child: Hero(
                          //           tag: "hero1",
                          //           child: ElevatedButton(
                          //               onPressed: () {
                          //                 setState(() {
                          //                   _col = !_col;
                          //                 });
                          //               },
                          //               child: Icon(Icons.arrow_downward)),
                          //         ),
                          //       )
                          //     : Container(),
                          // // (response == null)
                          // //     ? const CircularProgressIndicator()
                          Text("${response.data.toString()}"),
                          (respList.isNotEmpty)
                              ? Container(
                                  child: Cards(),
                                ) //height: MediaQuery.of(context).size.height*0.5, color: Color.fromARGB(255, 252, 153, 24),)
                              : const CircularProgressIndicator(),
                          SizedBox(
                            height: 100,
                          ),
                          (respList.isNotEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xFFF14A16)),
                                      onPressed: () {
                                        tcont.forward();
                                      },
                                      child: Text(
                                        "Next Idea!",
                                        style: TextStyle(fontSize: 34.0),
                                      )),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ))
            : Center(child: Container(child: const CircularProgressIndicator())));
  }

  void _onRefresh() async {
    // monitor network fetch
    // await getHttp(tecIndex);
    await genList(1);
    // if failed,use refreshFailed()
    setState(() {
      refreshController.refreshCompleted();
    });
  }
}
