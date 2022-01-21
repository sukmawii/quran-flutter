//import 'dart:ui';
import 'dart:convert';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class QuranBaca extends StatelessWidget {
  var audio = AudioPlayer();
  ArabicNumbers arabicNumber = ArabicNumbers();
  String str = "";
  String nama = "";
  String playname = "Dengarkan";
  // var isPlaying = false;

  QuranBaca({Key? key, required this.str, required this.nama})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> _fecthDataUsers() async {
      var result = await http
          .get(Uri.parse("https://quran-endpoint.vercel.app/quran/" + str));
      return json.decode(result.body)['data']['ayahs'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(nama),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  //padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Theme.of(context).brightness == Brightness.light
                          ? index % 2 == 0
                              ? Colors.grey[200]
                              : Colors.grey[300]
                          : index % 2 == 0
                              ? Colors.grey[800]
                              : Colors.grey[900],
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ExpansionTile(
                          title: Text(
                            snapshot.data[index]['text']['ar'],
                            style: const TextStyle(
                                fontFamily: 'PDMSSaleem', fontSize: 40),
                          ),
                          trailing: Text(
                            arabicNumber.convert(
                                snapshot.data[index]['number']['insurah']),
                            style: const TextStyle(fontSize: 30),
                          ),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Share.share(
                                    //     '${snapshot.data[index]['translation']['id']}');
                                  },
                                  child: const Text("Share"),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      //audio.play(
                                      //     '${snapshot.data[index]['audio']['url']}');
                                      int result = await audio.play(
                                          '${snapshot.data[index]['audio']['url']}');
                                      if (result == 1) {
                                        //isPlaying = true;
                                      }
                                    },
                                    child: Text(playname)),
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            //margin: const EdgeInsets.symmetric(
                                            //    horizontal: 20.0),
                                            margin: const EdgeInsets.all(20.0),
                                            height: 350.0,
                                            color: Colors
                                                .transparent, //could change this to Color(0xFF737373),
                                            //so you don't have to change MaterialApp canvasColor
                                            child: Text("Tafsir Dari " +
                                                nama +
                                                " Ayat Ke-" +
                                                snapshot.data[index]['number']
                                                        ['insurah']
                                                    .toString() +
                                                " Sebagai Berikut:" +
                                                "\n\n" +
                                                snapshot.data[index]['tafsir']
                                                    ['id']),
                                          );
                                        });
                                  },
                                  child: const Text("Tafsir"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            //margin: const EdgeInsets.symmetric(
                                            //    horizontal: 20.0),
                                            margin: const EdgeInsets.all(20.0),
                                            height: 350.0,
                                            color: Colors
                                                .transparent, //could change this to Color(0xFF737373),
                                            //so you don't have to change MaterialApp canvasColor
                                            child: Text("Arti Dari " +
                                                nama +
                                                " Ayat Ke-" +
                                                snapshot.data[index]['number']
                                                        ['insurah']
                                                    .toString() +
                                                "\n\n" +
                                                snapshot.data[index]
                                                    ['translation']['id']),
                                          );
                                        });
                                  },
                                  child: const Text("Arti"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
