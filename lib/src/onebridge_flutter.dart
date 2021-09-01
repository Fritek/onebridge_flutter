import 'package:flutter/material.dart';

import 'index.dart';

class OneBridgeFlutter {
  static Future lauchOneBridge(
    BuildContext context,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.width * .73,
            child: OnebridgeWebView(),
          );
        });
  }
}
