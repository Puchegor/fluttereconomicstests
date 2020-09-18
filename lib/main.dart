import 'dart:io';

import 'package:economicstests/Options.dart';
import 'package:economicstests/Topic.dart';
import 'package:economicstests/dataBase.dart';
import 'package:economicstests/mainPageDrawer.dart';
import 'package:economicstests/topicChoiseWindow.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Options.init();
  await dataBase.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          pressNextBtn(context);
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

void pressNextBtn(BuildContext context){
  switch(_selected){
    case 0:
      runTopicChoise(context, false);
      break;
    case 1:
      break;
    case 2:
      break;
  }
}

void runTopicChoise(BuildContext context, bool isControl)async{
  List<Map>_resultSet = await dataBase.select('SELECT * FROM topics');
  List<topic> topics = [];
  _resultSet.forEach((element) {
    topic top = new topic(element.values.elementAt(0),
        element.values.elementAt(2));
    topics.add(top);
  });
  Navigator.push(context, MaterialPageRoute(builder: (context)=>topicChoiseWindow(topics:topics)));
}