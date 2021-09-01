import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../index.dart';

class OnebridgeWebView extends StatefulWidget {
  const OnebridgeWebView({Key? key}) : super(key: key);

  @override
  _OnebridgeWebViewState createState() => _OnebridgeWebViewState();
}

class _OnebridgeWebViewState extends State<OnebridgeWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadUrl(),
        initialData: "",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<WebViewController>(
              future: _controller.future,
              builder: (BuildContext context,
                  AsyncSnapshot<WebViewController> controller) {
                return snapshot.data.fold(
                  (failureMessage) => const SizedBox.shrink(),
                  (data) => WebView(
                    initialUrl: data,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (String url) {
                      // setState(() {
                      //   isLoading = true;
                      // });
                    },
                    onPageFinished: (String url) {
                      // setState(() {
                      //   isLoading = false;
                      // });
                    },
                  ),
                );
              },
            );
          }

          return Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
