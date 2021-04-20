import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'api_request.dart';

class WikiWebRoute extends StatelessWidget {
  final title;

  WikiWebRoute({this.title});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
      ),
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                )),
            Container(
              child: WebView(
                initialUrl:
                '${ApiHelper.wikiUrl}/$title',
                //gestureNavigationEnabled: true,
              ),
            ),
          ],
        );
      }),
      // floatingActionButton: favoriteButton(),
    );
  }
}

