import 'package:flutter/material.dart';

import 'index.dart';

class OneBridgeFlutter {
  static Future lauch(
    BuildContext _,
  ) async {
    showDialog(
        context: _,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width * .75,
            height: MediaQuery.of(context).size.width * .60,
            child: OnebridgeWebView(
              shouldShowLogs: true,
            ),
          );
        });
  }
}
