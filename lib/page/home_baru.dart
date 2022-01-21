import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quran/page/quran_baca.dart';

class HomeBaru extends StatelessWidget {
  HomeBaru({Key? key}) : super(key: key);
  var audio = AudioPlayer();
  //AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;

  final String quranList =
      "https://api-berita-indonesia.vercel.app/republika/islam";
  Future<List> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(quranList));
    return json.decode(result.body)['data']['posts'];
  }

  final String randomurl = "https://quran-api-id.vercel.app/random";
  Future<List<dynamic>> _randomData() async {
    var result = await http.get(Uri.parse(randomurl));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alqur`an'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: FutureBuilder<List<dynamic>>(
              future: _fecthDataUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Text("test"),
                          title: Text(snapshot.data[index]['title']),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Container(
            child: FutureBuilder<List>(
              future: _randomData(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: snap.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          leading: const Text("test"),
                          title: Text(snap.data[i]['arab']),
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
    );
  }
}
