import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_zendesk/flutter_zendesk.dart';

void main(List<String> args) {
  String appId = '';
  String clientId = '';
  String zendeskUrl = '';
  if (args != null && args.isNotEmpty) {
    appId = args[0];
    clientId = args[1];
    zendeskUrl = args[2];
  }

  runApp(MyApp(
    appId: appId,
    clientId: clientId,
    zendeskUrl: zendeskUrl,
  ));
}

class MyApp extends StatefulWidget {
  final String appId;
  final String clientId;
  final String zendeskUrl;

  const MyApp(
      {Key key,
      @required this.appId,
      @required this.clientId,
      @required this.zendeskUrl})
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
    await FlutterZendesk.setIdentity(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NTcyOTA5MDUuODk1LCJqdGkiOiIwOTUzMTIwYS05N2UxLTQzZjYtYWJjMS0yZjllZmI2NjAxMjgiLCJuYW1lIjoibWlybGltX2FkbWluIiwiZW1haWwiOiJtaXJsaW1wZkBnbWFpbC5jb20iLCJleHRlcm5hbF9pZCI6MX0.eHHot84tf42RE42ystPm3vUe-27Hu2CRwASWCrR4nbw');
*/

    await FlutterZendesk.setIdentity(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NTcyOTA5MDUuODk1LCJqdGkiOiIwOTUzMTIwYS05N2UxLTQzZjYtYWJjMS0yZjllZmI2NjAxMjgiLCJuYW1lIjoibWlybGltX2FkbWluIiwiZW1haWwiOiJtaXJsaW1wZkBnbWFpbC5jb20iLCJleHRlcm5hbF9pZCI6M30.sEmUv0261BSZTnw2RH1HJhjy9tvWp9U6wPdNasucb6I');

    try {
      final resultId = await FlutterZendesk.createRequest('test');
      print('result: $resultId');
      final test = await FlutterZendesk.getAllRequests();
      final test1 = await FlutterZendesk.getRequestById('3');
      final test2 = await FlutterZendesk.getCommentsByRequestId('3');

      print('requests : ${test.toJson()}');
      print('getRequestById : ${test1.toJson()}');
      test2.forEach((c) {
        print('c : ${c.toJson()}');
      });

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
              child: Text('ShowTicket'),
              onPressed: () {
                FlutterZendesk.showTicketScreen(context);
              },
            ),
            FlatButton(
              child: Text('ShowTickets'),
              onPressed: () {
                FlutterZendesk.showTickets();
              },
            ),
            FlatButton(
              child: Text('shot article'),
              onPressed: () {
                FlutterZendesk.showArticle();
              },
            )
          ]),
        ),
      ),
    );
  }
}
