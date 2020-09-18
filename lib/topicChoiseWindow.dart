
import 'package:economicstests/Topic.dart';
import 'package:flutter/material.dart';

class topicChoiseWindow extends StatelessWidget{
  List<topic>topics =[];
  topicChoiseWindow({Key key, @required this.topics});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Выберите тему для тестирования'),
        elevation: 10.0,
      ),
      body: topicsList(topics),
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

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class topicsList extends StatefulWidget{
  List<topic>topics;
  topicsList(List<topic> topics){
    this.topics = topics;
  }
  @override
  topicsListState createState()=>topicsListState();
}

class topicsListState extends State<topicsList>{
  int _selected = 1;
  @override
  Widget build(BuildContext context) {
    new ListView.builder(itemCount: widget.topics.length,
    itemBuilder: (bc, index){
      return RadioListTile(
        title: Text('${widget.topics.elementAt(index).getTopicName()}'),
        value: widget.topics.elementAt(index).getIdTopic(),
        groupValue: _selected,
        onChanged: (int value){
          setState(() {
            _selected = value;
          });
        },
      );
    },);
  }
}