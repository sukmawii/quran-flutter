import 'package:flutter/material.dart';
//import 'package:quran/page/home_stateful.dart';
import 'page/home_page.dart';
//import 'package:quran/model/random.dart';
import 'page/home_baru.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Widget',
    //home: HomeBaru(),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red[800],
      fontFamily: 'Quicksand',
    ),
    darkTheme: ThemeData.dark(), // standard dark theme
    themeMode: ThemeMode.system, // device controls theme
  ));
}
