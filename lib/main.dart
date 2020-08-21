import 'dart:io';

import 'package:economicstests/mainPageDrawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тесты по эконмической теории',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тесты по экономической теории'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: (){
              exit(0);
            },
          )
        ],
      ),
      drawer: mainPageDrawer(),
    );
  }
}
