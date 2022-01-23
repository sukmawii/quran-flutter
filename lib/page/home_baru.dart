import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quran/page/quran_list_ar.dart';
import 'package:http/http.dart' as http;

class HomeBaru extends StatelessWidget {
  const HomeBaru({Key? key}) : super(key: key);

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
        title: const Text('Home Baru'),
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
              child: Card(
                elevation: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 66,
                      child: Column(
                        children: const [
                          Expanded(
                            flex: 50,
                            child: Text("controller.random"),
                          ),
                          Expanded(flex: 25, child: Text('def')),
                          Expanded(flex: 25, child: Text('ghi')),
                        ],
                      ),
                    )
                  ],
                ),
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
                    children: const <Widget>[
                      Icon(
                        Icons.people,
                        size: 40,
                      ),
                      Text("Baca Quran")
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () => {},
                  // color: Colors.orange,
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: const <Widget>[
                      Icon(
                        Icons.surfing,
                        size: 40,
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
                    children: const <Widget>[
                      Icon(
                        Icons.audiotrack,
                        size: 40,
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
              child: FutureBuilder<Map<String, dynamic>?>(
                future: getRandom(),
                builder: (context, snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Text(snapshot1.data!['data']['arab']);
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
