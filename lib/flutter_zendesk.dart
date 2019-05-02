import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class FlutterZendesk {
  @visibleForTesting
  static const MethodChannel channel =
      const MethodChannel('net.amond.flutter_zendesk');

  static Future<void> initialize(
      String appId, String clientId, String zendeskUrl) async {
    assert(appId != null && appId.isNotEmpty);
    assert(clientId != null && appId.isNotEmpty);
    assert(zendeskUrl != null && appId.isNotEmpty);

    try {
      final response = await channel.invokeMethod('initialize',
          {'appId': appId, 'clientId': clientId, 'zendeskUrl': zendeskUrl});
      debugPrint('response : $response');
    } catch (e) {
      print('error : $e');
      throw e;
    }
    return;
  }

  static Future<String> get platformVersion async {
    final String version = await channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> createRequest() async {
    try {
      final List<int> result = await channel.invokeMethod('createRequest');
      return String.fromCharCodes(result);
    } catch (e) {
      debugPrint('error : $e');
      throw e;
    }
  }

  static Future<Map<dynamic, dynamic>> getArticlesForSectionId(
      String sectionId) async {
    assert(sectionId != null);
    try {
      Map<dynamic, dynamic> articles =
          // TODO(amirh): remove this on when the invokeMethod update makes it to stable Flutter.
          // https://github.com/flutter/flutter/issues/26431
          // ignore: strong_mode_implicit_dynamic_method
          await channel.invokeMethod('getArticlesForSectionId',
              <String, dynamic>{'sectionId': sectionId});
      debugPrint('good ${articles['articles']}');
      return articles;
    } catch (e) {
      debugPrint('error : $e');
      throw e;
    }
  }
}
