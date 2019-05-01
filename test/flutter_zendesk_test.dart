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
      } else if (methodCall.method == 'getPlatformVersion') {}
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterZendesk.platformVersion, '42');
  });
}
