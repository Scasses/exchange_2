import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../resources/styling.dart';

class ArticleView extends StatefulWidget {
  static const String id = 'article_view';

  final String? newsUrl;
  ArticleView({required this.newsUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  // final Completer<WebViewController> _completer =
  //     Completer<WebViewController>();
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.newsUrl!),
      );
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: const Row(
          children: <Widget>[
            Text(
              'Exchange',
              style: kAppTitleNameStyleAppBar,
            ),
            Text(
              'Headlines',
              style: kAppTitleNameStyleAppBar,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: WebViewWidget(controller: controller),
        // child: WebViewWidget(controller: controller),
        // child: WebView(
        //   initialUrl: widget.newsUrl,
        //   onWebViewCreated: ((WebViewController webViewController){
        //     _completer.complete(webViewController);
        //   }),
        // ),
      ),
    );
  }
}