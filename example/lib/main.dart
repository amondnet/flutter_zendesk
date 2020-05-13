import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_zendesk/flutter_zendesk.dart';

void main(List<String> args) {
  String appId = getEnvironmentValue('APP_ID', defaultValue: args[0]);
  String clientId = getEnvironmentValue('CLIENT_ID', defaultValue: args[1]);
  String zendeskUrl = getEnvironmentValue('ZENDESK_URL', defaultValue: args[2]);
  String jwt =
      getEnvironmentValue('JWT', defaultValue: args[3], required: false);
  ;

  runApp(MyApp(
    appId: appId,
    clientId: clientId,
    zendeskUrl: zendeskUrl,
    jwt: jwt,
  ));
}

class MyApp extends StatefulWidget {
  final String appId;
  final String clientId;
  final String zendeskUrl;
  final String jwt;

  const MyApp(
      {Key key,
      @required this.appId,
      @required this.clientId,
      @required this.zendeskUrl,
      @required this.jwt})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _articles = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List articles = [];
    await FlutterZendesk.initialize(
        widget.appId, widget.clientId, widget.zendeskUrl);
    debugPrint('initialize');
    //debugPrint('result $resultId');
    // Platform messages may fail, so we use a try/catch PlatformException.
    /*
*/

    /*
    await FlutterZendesk.anonymousIdentity(
        name: "test user", email: "test@amond.net");*/

    try {
      final resultId = await FlutterZendesk.createRequest('test');
      print('result: $resultId');

      //articles = await FlutterZendesk.getArticlesForSectionId('360004091934');
      print('success');
    } on PlatformException {
      articles = [];
    }

    try {
      //requests = await FlutterZendesk.getAllRequests();
      print('success');
    } on PlatformException {} catch (e) {
      debugPrint('error : $e');
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _articles = articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: [
            Text(
              'articles: ${_articles.length}',
              key: Key('articles'),
            ),
            FlatButton(
              child: Text('get all requests'),
              onPressed: () {
                final requests = FlutterZendesk.getAllRequests();
                print(requests);
              },
            ),
            FlatButton(
              child: Text('showRequestList'),
              onPressed: () {
                FlutterZendesk.showRequestList();
              },
            ),
            FlatButton(
              child: Text('showRequest'),
              onPressed: () {
                FlutterZendesk.showRequest();
              },
            ),
            FlatButton(
              child: Text('showHelpCenter'),
              onPressed: () {
                FlutterZendesk.showHelpCenter();
              },
            )
          ]),
        ),
      ),
    );
  }
}

String getEnvironmentValue(String key, {required: true, String defaultValue}) {
  final value = Platform.environment[key];
  if (required && value == null && defaultValue == null) {
    print('Set $key before launch the tests');
    exit(-1);
  }
  return value ?? defaultValue;
}
