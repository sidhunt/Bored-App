import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import './http.dart';
import './main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:tcard/tcard.dart';

class Cards extends StatefulWidget {
  Cards({Key? key}) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

List<Widget> respList = List.empty(growable: true);
TCardController tcont = TCardController();
// Map<String, PreviewData> datas = {};
// List<String> urls = [];

// List<Widget> cards = List.generate(
//   5,
//   (index) => Container(
//     color: Colors.blue,
//     child: Center(
//       child: Text(
//         '$index',
//         style: TextStyle(fontSize: 60, color: Colors.white),
//       ),
//     ),
//   ),
// );

class _CardsState extends State<Cards> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    respList.clear();
    // urls.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TCard(
      cards: respList,
      controller: tcont,
      onForward: (index, info) async {
        if (index >= respList.length - 2) {
          setState(() {
            respList.clear();
          });

          // await getHttp(tecIndex);
          await compute(genList, 1);
          tcont.reset(cards: respList);
          // .then((value) => value.forEach((element) {
          //       respList.add(element);
          //     }));
          setState(() {});
        }
      },
      onBack: (index, info) async {
        if (index >= respList.length - 2) {
          setState(() {
            respList.clear();
          });

          //  await getHttp(tecIndex);
          await compute(genList, 1);
          tcont.reset(cards: respList);
          // .then((value) => value.forEach((element) {
          //       respList.add(element);
          //     }));
          setState(() {});
        }
      },
      onEnd: () async {
        setState(() {
          respList.clear();
        });

        // await getHttp(tecIndex);
        await compute(genList, 1);

        // .then((value) => value.forEach((element) {
        //       respList.add(element);
        //     }));
        setState(() {
          tcont.reset(cards: respList);
        });
      },
    );
  }
}
// class Link extends StatefulWidget {
//   Link({Key? key}) : super(key: key);

//   @override
//   _LinkState createState() => _LinkState();
// }
// class _LinkState extends State<Link> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SimpleUrlPreview(url: ,)
//     );
//   }
// }

genList(int ind) async {
  //  late List<Widget> l1 = List.empty();
  print(response);
  for (var i = 0; i < 10; i++) {
    //  urls.add(response.data["link"]);
    
    respList.add(Column(
      children: [
        // (response.data["link"] == null)
        //     ? Container()
        //     : Container(
        //       padding: EdgeInsets.zero,
        //         child: SimpleUrlPreview(url: response.data["link"],imageLoaderColor: Color.fromARGB(255, 252, 153, 24),)
        //       ),
        Container(
          height: screenH * 0.3,
          child: Column(children: [
            Text(
              response.data["activity"],
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: response.data["link"],
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await canLaunch(response.data["link"]);
                        await launch(response.data["link"]);
                      })
              ]),
            )
          ]),
          color: Color.fromARGB(255, 252, 153, 24),
        ),
      ],
    ));
    await getHttp(tecIndex);
    //urls.clear();
  }
  //  return l1;
}
