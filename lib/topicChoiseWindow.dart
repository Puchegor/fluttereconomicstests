
import 'package:economicstests/Topic.dart';
import 'package:economicstests/testPage.dart';
import 'package:flutter/material.dart';

class topicChoiseWindow extends StatefulWidget{
  List<topic>topics = [];
  bool isControl;
  topicChoiseWindow({Key key, @required this.topics, @required this.isControl});
  @override
  topicChoiseWindowState createState()=>topicChoiseWindowState();
}

class topicChoiseWindowState extends State<topicChoiseWindow>{
  int _selected = 1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Выберите тему для тестирования'),
        elevation: 10.0,
      ),
      body: new ListView.builder(
          itemCount: widget.topics.length,
          itemBuilder: (buildContext, index){
            return RadioListTile(
              title: Text('${index+1} . ${widget.topics.elementAt(index).getTopicName()}'),
              value: widget.topics.elementAt(index).getIdTopic(),
              groupValue: _selected,
              onChanged: (int value){
                setState(() {
                  _selected = value;
                });
              },
            );
          }
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 20.0,
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0,),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        tooltip: 'Продолжить',
        child: Icon(Icons.arrow_forward),
        onPressed: (){
          pressNextBtn(context, _selected, false);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

void pressNextBtn(BuildContext context, int idTopic, bool isControl){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>testPage(idTopic: idTopic, isControl: isControl,)));
}


