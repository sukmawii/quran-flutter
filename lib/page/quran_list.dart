import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quran/page/quran_baca.dart';

class QuranListLama extends StatelessWidget {
  var audio = AudioPlayer();
  //AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  String str = "";
  String nama = "";
  final String quranList = "https://quran-api-id.vercel.app/surahs";

  QuranListLama({Key? key}) : super(key: key);
  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(quranList));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alqur`an'),
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
                      title: Text(snapshot.data[index]['name'] +
                          " - " +
                          snapshot.data[index]['revelation']),
                      subtitle: Text(snapshot.data[index]['translation']),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () {
                          audio.play('${snapshot.data[index]['audio']}');
                        },
                      ),
                      onTap: () {
                        //  MaterialPageRoute(builder: (context) => (str: "Dark Knight"))
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuranBaca(
                                    str: snapshot.data[index]['number']
                                        .toString(),
                                    nama: snapshot.data[index]['name'])));
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
