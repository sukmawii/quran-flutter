import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BeritaDetail extends StatefulWidget {
  final String url;

  const BeritaDetail({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _BeritaState createState() => _BeritaState();
}

class _BeritaState extends State<BeritaDetail> {
  late WebViewController _myController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: const Text(""),
          ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller.complete(controller);
          _myController = controller;
        },
        // onPageFinished: (url) {
        //   // print('Página terminou de carregar: $url');
        //   _myController.runJavascriptReturningResult(
        //       "document.getElementsByClassName('cb-header header1')[0].style.display='none';");
        // },
      ),
    );
  }
}
