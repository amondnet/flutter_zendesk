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
    String platformVersion;
    List articles = [];
    Map requests = {};
    await FlutterZendesk.initialize(
        widget.appId, widget.clientId, widget.zendeskUrl);
    //final resultId = await FlutterZendesk.createRequest();
    //debugPrint('result $resultId');
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      //articles = await FlutterZendesk.getArticlesForSectionId('360004091934');
      print('success');
    } on PlatformException {
      articles = [];
    }

    try {
      //requests = await FlutterZendesk.getAllRequests();
      print('success');
    } on PlatformException {
      requests = {};
    } catch (e) {
      debugPrint('error : $e');
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _articles = [];
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
            )
          ]),
        ),
      ),
    );
  }
}
