
import 'package:economicstests/Topic.dart';
import 'package:economicstests/dataBase.dart';
import 'package:economicstests/testPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'Question.dart';

class topicChoiseWindow extends StatefulWidget{
  List<topic>topics = [];
  topicChoiseWindow({Key key, @required this.topics});
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
          pressNextBtn(context, _selected);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}

void pressNextBtn(BuildContext context, int idTopic){
  createTest(idTopic).then((value) => {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>testPage(test: value)))
  });
}

Future<List<Question>> createTest(int idTopic) async {
  List<Question>test = [];
  List<int> ids = await getQuestionsIDs(idTopic);
  ids.forEach((questionID) {
    getQuestion(questionID).then((question) => {
      test.add(question)
    });
  });
  return test;
}

Future<List<int>>getQuestionsIDs(int idTopic) async{
  List<int>ids;
  List<Map>_resultSet = await dataBase.select('SELECT _id FROM questions WHERE idTopic = $idTopic');
  _resultSet.forEach((element) {
    ids.add(element.values.elementAt(0));
  });
  print('IDs: $ids');
  return ids;
}

Future<List<Answer>>getAnswers(int idQuestion) async {
  List<Answer>answers = [];
  List<Map>_resultSet = await dataBase.select('SELECT * FROM answers WHERE idQuestion = $idQuestion');
  _resultSet.forEach((element) {
    int idAnswer = element.values.elementAt(0);
    String nameAnswer = element.values.elementAt(2);
    bool isTrue = false;
    if (element.values.elementAt(3) != 0)
      isTrue = true;
    Answer answer = new Answer(idAnswer, nameAnswer, isTrue);
    answers.add(answer);
  });
  return answers;
}

Future<Question>getQuestion(int idQuestion) async {
  List<Map>_resultSet = await dataBase.select('SELECT * FROM questions WHERE idQuestion = $idQuestion');
    String nameQuestion = _resultSet.first.values.elementAt(2);
    List<Answer>answers = await getAnswers(idQuestion);
    String correctAnswer = _resultSet.first.values.elementAt(3);
    return new Question(idQuestion, nameQuestion, answers, correctAnswer);
}

