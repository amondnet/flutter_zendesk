import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zendesk/model.dart';
import 'package:meta/meta.dart';

export 'model.dart';

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
      await channel.invokeMethod('initialize',
          {'appId': appId, 'clientId': clientId, 'zendeskUrl': zendeskUrl});
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

  static Future<ZdkRequest> createRequest(String requestDescription,
      {String subject,
      List<String> tags: const [],
      List<ZdkCustomField> customField: const []}) async {
    try {
      final dynamic result =
          await channel.invokeMethod('createRequest', <String, dynamic>{
        'subject': subject ?? requestDescription,
        'requestDescription': requestDescription,
        'tags': tags,
        'customField': customField?.map((v) => v.toJson())?.toList()
      });

      debugPrint('result : $result');
      if (result is List<int>) {
        final json = jsonDecode(String.fromCharCodes(result));
        debugPrint('json : $json');
        final created = ZdkRequest.fromJson(json["request"]);
        debugPrint('created : ${created.toJson()}');
        return created;
      }
      return null;
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
        // debugPrint('has articles');
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

  static Future<ZdkRequestsWithCommentingAgents> getAllRequests() async {
    try {
      Map<dynamic, dynamic> requests =
          // TODO(amirh): remove this on when the invokeMethod update makes it to stable Flutter.
          // https://github.com/flutter/flutter/issues/26431
          // ignore: strong_mode_implicit_dynamic_method
          await channel.invokeMethod('getAllRequests');
      Map<String, dynamic> myMap = new Map<String, dynamic>.from(requests);
      // debugPrint('requests ${myMap}');
      return ZdkRequestsWithCommentingAgents.fromJson(myMap);
    } catch (e) {
      debugPrint('error : $e');
      throw e;
    }
    return ZdkRequestsWithCommentingAgents();
  }

  static Future<ZdkRequest> getRequestById(String requestId) async {
    try {
      Map<dynamic, dynamic> request =
          // TODO(amirh): remove this on when the invokeMethod update makes it to stable Flutter.
          // https://github.com/flutter/flutter/issues/26431
          // ignore: strong_mode_implicit_dynamic_method
          await channel
              .invokeMethod('getRequestById', {"requestId": requestId});
      //debugPrint('getRequestById ${request}');
      //Map<String, dynamic> myMap = new Map<String, dynamic>.from(requests);
      Map<String, dynamic> myMap = new Map<String, dynamic>.from(request);

      return ZdkRequest.fromJson(myMap);
    } catch (e) {
      debugPrint('error : $e');
      throw e;
    }
  }

  static Future<ZdkComment> addComment(String comment, String requestId) async {
    try {
      Map<dynamic, dynamic> payload =
          // TODO(amirh): remove this on when the invokeMethod update makes it to stable Flutter.
          // https://github.com/flutter/flutter/issues/26431
          // ignore: strong_mode_implicit_dynamic_method
          await channel.invokeMethod(
              'addComment', {"requestId": requestId, "comment": comment});

      Map<String, dynamic> myMap = new Map<String, dynamic>.from(payload);
      return ZdkComment.fromJson(myMap);

      //debugPrint('requests ${myMap}');
    } catch (e) {
      debugPrint('getCommentsByRequestId Error : $e');
      throw e;
    }
  }

  static Future<List<CommentWithUser>> getCommentsByRequestId(
      String requestId) async {
    try {
      List requests =
          // TODO(amirh): remove this on when the invokㅇㅇㄴddeMethod update makes it to stable Flutter.
          // https://github.com/flutter/flutter/issues/26431
          // ignore: strong_mode_implicit_dynamic_method
          await channel
              .invokeMethod('getCommentsByRequestId', {"requestId": requestId});
      //Map<String, dynamic> myMap = new Map<String, dynamic>.from(requests);

      return requests.map((map) {
        Map<String, dynamic> myMap =
            new Map<String, dynamic>.from(map as Map<dynamic, dynamic>);
        return CommentWithUser.fromJson(myMap);
      }).toList();
      //debugPrint('requests ${myMap}');
    } catch (e) {
      debugPrint('getCommentsByRequestId Eㅊㄱㄷrror : $e');
      throw e;
    }
  }

  static Future<void> setIdentity(String token) async {
    assert(token != null && token.isNotEmpty);

    try {
      await channel.invokeMethod('setIdentity', {
        'token': token,
      });
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

  static void showArticle() async {
    try {
      await channel.invokeMethod('showArticle');
      //Navigator.pop(context);
    } catch (e) {
      print('error : $e');
      throw e;
    }
    return;
  }
}
