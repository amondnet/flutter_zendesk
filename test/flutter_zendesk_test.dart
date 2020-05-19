import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zendesk/flutter_zendesk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('net.amond.flutter_zendesk');

  setUp(() {
    // ignore: missing_return
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getArticlesForSectionId') {
        return {
          "articles": [
            {
              "identifier": 35467,
              "author_id": 888887,
              "draft": true,
            },
          ]
        };
      } else if (methodCall.method == 'initialize') {
        return true;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getArticlesForSectionId', () async {
    expect(await FlutterZendesk.getArticlesForSectionId('test'),
        [Article(identifier: 35467, authorId: 888887)]);
  });

  test('initialize', () async {
    await FlutterZendesk.initialize('a', 'b', 'c');
  });
}
