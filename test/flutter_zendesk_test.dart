import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zendesk/flutter_zendesk.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('net.amond.flutter_zendesk', JSONMethodCodec());

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getPlatformVersion') {
        return '42';
      } else if (methodCall.method == 'getArticlesForSectionId') {
        return {
          "articles": [
            {
              "id": 35467,
              "author_id": 888887,
              "draft": true,
            },
          ]
        };
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterZendesk.platformVersion, '42');
  });

  test('getArticlesForSectionId', () async {
    expect(await FlutterZendesk.getArticlesForSectionId, {
      "articles": [
        {
          "id": 35467,
          "author_id": 888887,
          "draft": true,
        },
      ]
    });
  });
}
