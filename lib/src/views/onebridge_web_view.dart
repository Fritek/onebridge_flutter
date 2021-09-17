import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../index.dart';

class OnebridgeWebView extends StatefulWidget {
  /// Authentication Success callback
  final Function(String code)? onAuthenticationSuccess;

  /// Show OneBridge Logs
  final bool shouldShowLogs;

  const OnebridgeWebView({
    Key? key,
    this.onAuthenticationSuccess,
    required this.shouldShowLogs,
  }) : super(key: key);

  @override
  _OnebridgeWebViewState createState() => _OnebridgeWebViewState();
}

class _OnebridgeWebViewState extends State<OnebridgeWebView> {
  @override
  void initState() {
    _handleInit();
    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadUrl(),
        // initialData: "",
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
                    javascriptChannels: {_oneBridgeJavascriptChannel()},
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

  void _handleInit() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  /// javascript channel for events sent by mono
  JavascriptChannel _oneBridgeJavascriptChannel() {
    return JavascriptChannel(
        name: 'OnebridgeClientInterface',
        onMessageReceived: (JavascriptMessage message) {
          if (widget.shouldShowLogs == true)
            print('OnebridgeClientInterface, ${message.message}');
          Map<String, dynamic> res = json.decode(message.message);
          print(res);
        });
  }
}
