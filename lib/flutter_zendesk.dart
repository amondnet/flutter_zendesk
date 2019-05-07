import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zendesk/article.dart';
import 'package:meta/meta.dart';

class FlutterZendesk {
  static final FlutterZendesk _singleton = new FlutterZendesk._internal();
  FlutterZendesk._internal() {}

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

  static Future<String> createRequest(String subject, String requestDescription,
      {List<String> tags: const []}) async {
    try {
      final List<int> result = await channel.invokeMethod(
          'createRequest', <String, dynamic>{
        'subject': subject,
        'requestDescription': requestDescription,
        'tags': tags
      });
      return String.fromCharCodes(result);
    } catch (e) {
      debugPrint('error : $e');
      throw e;
    }
  }

  static Future<List<Article>> getArticlesForSectionId(String sectionId) async {
    assert(sectionId != null);
    try {
      Map<dynamic, dynamic> articlesJson =
          // TODO(amirh): remove this on when the invokeMethod update makes it to stable Flutter.
          // https://github.com/flutter/flutter/issues/26431
          // ignore: strong_mode_implicit_dynamic_method
          await channel.invokeMethod('getArticlesForSectionId',
              <String, dynamic>{'sectionId': sectionId});
      if (articlesJson.containsKey('articles')) {
        debugPrint('has articles');
        List list = articlesJson["articles"];
        return list.map((article) {
          Map<String, dynamic> myMap = new Map<String, dynamic>.from(article);
          return Article.fromJson(myMap);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('error : $e');
      throw e;
    }
  }

  static Future<Map<dynamic, dynamic>> getAllRequests() async {
    try {
      Map<dynamic, dynamic> requests =
          // TODO(amirh): remove this on when the invokeMethod update makes it to stable Flutter.
          // https://github.com/flutter/flutter/issues/26431
          // ignore: strong_mode_implicit_dynamic_method
          await channel.invokeMethod('getAllRequests');
      debugPrint('good ${requests}');
      return requests;
    } catch (e) {
      debugPrint('error : $e');
      throw e;
    }
  }

  static Future<void> setIdentity(String token) async {
    assert(token != null && token.isNotEmpty);

    try {
      final response = await channel.invokeMethod('setIdentity', {
        'token': token,
      });
      debugPrint('response : $response');
    } catch (e) {
      print('error : $e');
      throw e;
    }
    return;
  }

  static Future<void> showTicketScreen(context) async {
    try {
      await channel.invokeMethod('Show a ticket screen');
      //Navigator.pop(context);
    } catch (e) {
      print('error : $e');
      throw e;
    }
    return;
  }

  static Future<void> showTickets() async {
    try {
      await channel.invokeMethod('showTickets');
      //Navigator.pop(context);
    } catch (e) {
      print('error : $e');
      throw e;
    }
    return;
  }
}
