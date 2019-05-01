import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class FlutterZendesk {
  @visibleForTesting
  static const MethodChannel channel =
      const MethodChannel('net.amond.flutter_zendesk', const JSONMethodCodec());

  static Future<String> get platformVersion async {
    final String version = await channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<String, dynamic>> get getArticlesForSectionId async {
    final Map<String, dynamic> articles =
        await channel.invokeMethod('getArticlesForSectionId');
    return articles;
  }
}
