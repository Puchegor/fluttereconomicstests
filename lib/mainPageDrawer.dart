
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
        ),
        Divider(height: 10,
          thickness: 2,
          color: Colors.grey,
          indent: 10,
          endIndent: 10,
        ),
        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.font_download),
                title: Text('Размер шрифта'),
                subtitle: Text('Размер шрифта в тестах'),
              ),
              SliderFontSizeWidget()
            ],
          ),
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

class SliderFontSizeWidget extends StatefulWidget{
  @override
  SliderFontSizeWidgetState createState() => SliderFontSizeWidgetState();
}

class SliderFontSizeWidgetState extends State<SliderFontSizeWidget>{
  var _value = Options.getUserFontSize();
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      activeColor: Colors.amber,
      min: 10.0,
      max: 20.0,
      divisions: 10,
      label: '${_value.round()}',
      onChanged: (double value){
        setState(() {
          _value = value;
        });
      },
      onChangeEnd: (double value){
        Options.setUserFontSize(value);
      },
    );
  }
}