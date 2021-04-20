import 'package:flutter/material.dart';

import 'wiki_search_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wiki Search List',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: 1),
          headline6: TextStyle(
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              color: Colors.grey,
              letterSpacing: 1),
        ),
      ),
      home: WikiSearchRoute(),
    );
  }
}
