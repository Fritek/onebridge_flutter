import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onebridge_flutter/src/utils/constants.dart';

import 'index.dart';

Future<Either<String, String>> loadUrl(String token) async {
  try {
    final result = await InternetAddress.lookup(Constants.googleAddres);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return right("https://sleepy-lamarr-2c78c5.netlify.app?auth=$token");
    } else {
      return left(Constants.defaultErrorMessage);
    }
  } catch (_) {
    return left(Constants.defaultErrorMessage);
  }
}
