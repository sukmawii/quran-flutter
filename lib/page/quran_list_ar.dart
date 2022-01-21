import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quran/page/quran_baca.dart';

class QuranList extends StatelessWidget {
  var audio = AudioPlayer();
  //AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  String str = "";
  String nama = "";
  final String quranList = "https://quran-endpoint.vercel.app/quran";

  QuranList({Key? key}) : super(key: key);
  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(quranList));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(snapshot.data[index]['number'].toString()),
                      subtitle: Text(snapshot.data[index]['type']['id'] +
                          " | " +
                          snapshot.data[index]['ayahCount'].toString() +
                          " Ayat"),
                      title: Text(snapshot.data[index]['asma']['id']['short']),
                      trailing: Text(
                        snapshot.data[index]['asma']['ar']['short'],
                        style: const TextStyle(
                            fontFamily: 'PDMSSaleem', fontSize: 25),
                      ),
                      onTap: () {
                        //  MaterialPageRoute(builder: (context) => (str: "Dark Knight"))
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuranBaca(
                                    str: snapshot.data[index]['number']
                                        .toString(),
                                    nama: snapshot.data[index]['asma']['id']
                                        ['long'])));
                      },
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
