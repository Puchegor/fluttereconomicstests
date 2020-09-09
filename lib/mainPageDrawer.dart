
import 'package:economicstests/Options.dart';
import 'package:flutter/material.dart';

class mainPageDrawer extends StatefulWidget{
  @override
  mainPageDrawerState createState() => mainPageDrawerState();
}

class mainPageDrawerState extends State<mainPageDrawer>{
  @override
  Widget build(BuildContext context) {
    return Drawer(child:
    ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Настройки', style: TextStyle(fontSize: 20.0),),
          decoration: BoxDecoration(
              color: Colors.blue
          ),
        ),
        Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text('Вопросов в тесте'),
                  subtitle: Text('Количество вопросов в контрольном тесте'),
                ),
                SliderQuestionsWidget(),
              ],
            )
        ),
        Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('Время решения:'),
                  subtitle: Text('Время для решения контрольных тестов'),
                ),
                SliderTimeWidget(),
              ],
            )
        )
      ],
    )

    );
  }
}

class SliderQuestionsWidget extends StatefulWidget{
  @override
  SliderQuestionsWidgetState createState()=>SliderQuestionsWidgetState();
}

class SliderQuestionsWidgetState extends State<SliderQuestionsWidget>{
  var _value = Options.getUserNumberOfQuestions().roundToDouble();
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      activeColor: Colors.amber,
      min: 0,
      max: 100.0,
      divisions: 20,
      label: '${_value.round()} вопросов',
      onChanged: (double value){
        setState(() {
          _value = value;
        });
      },
      onChangeEnd: (double value){
        Options.setUserNumberOfQuestions(value.round());
      },
    );
  }
}

class SliderTimeWidget extends StatefulWidget{
  @override
  SliderTimeWidgetState createState()=>SliderTimeWidgetState();
}

class SliderTimeWidgetState extends State<SliderTimeWidget>{
  var _value = Options.getUserTimer().roundToDouble();
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      activeColor: Colors.amber,
      min: 0,
      max: 60.0,
      divisions: 12,
      label: '${_value.round()} минут',
      onChanged: (double value){
        setState(() {
          _value = value;
        });
      },
      onChangeEnd: (double value){
        Options.setUserTimer(value.floor());
      },
    );
  }
}