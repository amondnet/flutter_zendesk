import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zendesk/flutter_zendesk.dart';
import 'package:flutter_zendesk/src/model/attachment.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('net.amond.flutter_zendesk', JSONMethodCodec());

  setUp(() {});

  tearDown(() {});

  test('deserialize', () async {
    final String json =
        "{\r\n  \"id\":           928374,\r\n  \"file_name\":    \"my_funny_profile_pic.png\",\r\n  \"content_url\":  \"https:\/\/company.zendesk.com\/attachments\/my_funny_profile_pic.png\",\r\n  \"content_type\": \"image\/png\",\r\n  \"size\":         166144,\r\n  \"thumbnails\": [\r\n    {\r\n      \"id\":           928375,\r\n      \"file_name\":    \"my_funny_profile_pic_thumb.png\",\r\n      \"content_url\":  \"https:\/\/company.zendesk.com\/attachments\/my_funny_profile_pic_thumb.png\",\r\n      \"content_type\": \"image\/png\",\r\n      \"size\":         58298\r\n    }\r\n  ]\r\n}";

    final attachment = Attachment.fromJson(jsonDecode(json));
    expect(attachment.id, 928374);
    expect(attachment.thumbnails, isNotEmpty);
    expect(attachment.contentType.startsWith('image/'), true);

    expect(attachment.thumbnails.first.runtimeType, Photo);
    expect(attachment.thumbnails.first.thumbnails, isNull);

  });
}
