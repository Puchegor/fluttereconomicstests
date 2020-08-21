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
      body: RadioChoiseGroup(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        elevation: 20.0,
        child: Container(height: 50.0,),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Продолжить',
        child: Icon(Icons.arrow_forward),
        onPressed: (){
          //pressNextBtn(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}

class RadioChoiseGroup extends StatefulWidget{
  @override
  RadioGroupState createState () => RadioGroupState();
}

int _selected = 0;

class RadioGroupState extends State<RadioChoiseGroup>{
  @override
  Widget build(BuildContext context) {
    return Column(
        children:<Widget>[
          RadioListTile(
            value: 0,
            groupValue: _selected,
            title: Text('Обучающий тест по теме...'),
            subtitle: Text('При решении теста появляются подсказки с правильными ответами'),
            onChanged: (int value){
              setState((){
                _selected = value;
              });
            },
          ),
          RadioListTile(
            value: 1,
            groupValue: _selected,
            title: Text('Контрольный тест по теме...'),
            subtitle: Text('Тест только по выбранной теме. Правильные ответы можно будет посмотреть по окончании теста.'),
            onChanged: (int value){
              setState(() {
                _selected = value;
              });
            },
          ),
          RadioListTile(
            value: 2,
            groupValue: _selected,
            title: Text('Конотрольный тест по курсу'),
            subtitle: Text('Вопросы выбираются случайным образом из всех тем курса. Правильные ответы можно посмотреть после окончания теста'),
            onChanged: (int value){
              setState(() {
                _selected = value;
              });
            },
          )
        ]
    );
  }
}