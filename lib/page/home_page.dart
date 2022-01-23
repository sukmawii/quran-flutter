import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quran/page/home_baru.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:quran/page/quran_list_ar.dart';
import 'package:quran/page/berita_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:rounded_design_demo/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  //const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var controller = Get.put(RandomController());

  // Random? random2;
  ArabicNumbers arabicNumber = ArabicNumbers();
  final String quranList =
      "https://api-berita-indonesia.vercel.app/republika/islam";
  Future<List<dynamic>> _fecthDataBerita() async {
    var result = await http.get(Uri.parse(quranList));
    return json.decode(result.body)['data']['posts'];
  }

  Future<Map<String, dynamic>?> getRandom() async {
    Uri url = Uri.parse("https://quran-api-id.vercel.app/random");
    var response1 = await http.get(url);
    if (response1.statusCode != 200) {
      return null;
    } else {
      return jsonDecode(response1.body) as Map<String, dynamic>;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alqur`an'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        //padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              width: double.maxFinite,
              child: FutureBuilder<Map<String, dynamic>?>(
                future: getRandom(),
                builder: (context, snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    //return Text(snapshot1.data!['data']['arab']);
                    return Card(
                      elevation: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 66,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot1.data!['data']['arab'],
                                    style: const TextStyle(
                                        fontFamily: 'PDMSSaleem', fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                    child: Text(snapshot1.data!['data']
                                        ['translation'])),
                                Expanded(child: Text('Surah')),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(10.0),
            //   child: Text("Menu"),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuranList()));
                  },
                  //color: Colors.orange,
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Image.asset(
                        'assets/image/baca.png',
                        width: 50,
                        height: 50,
                      ),
                      const Text("Baca Quran")
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () => {},
                  // color: Colors.orange,
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Image.asset(
                        'assets/image/baca.png',
                        width: 50,
                        height: 50,
                      ),
                      Text("Jadwal Shalat")
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeBaru()),
                    ),
                  },
                  // color: Colors.orange,
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Image.asset(
                        'assets/image/baca.png',
                        width: 50,
                        height: 50,
                      ),
                      Text("Murotal")
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    width: 300,
                    color: Colors.blue[600],
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    width: 300,
                    color: Colors.blue[500],
                    child: const Center(
                        child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    width: 300,
                    color: Colors.blue[400],
                    child: const Center(
                        child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Berita Tentang Islam"),
            ),

            Container(
              child: FutureBuilder<List<dynamic>>(
                future: _fecthDataBerita(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        //padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(
                                '${snapshot.data[index]['thumbnail']}',
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            //horizontalTitleGap: 0.0,
                            title: Text(snapshot.data[index]['title'],
                                style: const TextStyle(
                                  fontSize: 14,
                                )),
                            subtitle: Text(
                              DateFormat('dd-MMM-yyyy').format(DateTime.parse(
                                  snapshot.data[index]['pubDate'].toString())),
                              style: const TextStyle(fontSize: 12),
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BeritaDetail(
                                        url: snapshot.data[index]['link'])),
                              );
                            },
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
