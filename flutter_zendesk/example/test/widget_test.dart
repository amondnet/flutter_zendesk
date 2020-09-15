// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_zendesk_example/main.dart';

void main() {
  testWidgets('Verify Platform version', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Map<String, String> envVars = Platform.environment;

    print(envVars['appId']);
    print(envVars['clientId']);
    print(envVars['zendeskUrl']);

    await tester.pumpWidget(MyApp(
        appId: envVars['appId'],
        clientId: envVars['clientId'],
        zendeskUrl: envVars['zendeskUrl']));

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is Text && widget.data == 'articles: 0',
      ),
      findsOneWidget,
    );
  });
}
