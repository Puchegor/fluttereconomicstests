
import 'package:flutter/material.dart';
import 'dart:async';

import 'Question.dart';
import 'dataBase.dart';

class testPage extends StatefulWidget{
  int idTopic;
  testPage({Key key, @required this.idTopic});
  @override
  testPageState createState() => testPageState();
}

class testPageState extends State<testPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тест по теме'),
        elevation: 20.0,
      ),
      body: FutureBuilder(
        future: questions(widget.idTopic),
        initialData: List(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else if (snapshot.hasError)
            return Text('ERROR: ${snapshot.error}');
          else
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (buildContext, index){
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data.toString()),
                    ),
                  );
                });
        },
      ),
    );
  }
}

Future<List<int>> questions(int idTopic) async {
  //dataBase.init();
  List<Question>test = [];
  List<int>ids = await getQuestionsIDs(idTopic);
  ids.forEach((idQuestion) {
    getQuestion(idQuestion).then((value) => test.add(value));
  });
  return ids;
}

Future<List<int>>getQuestionsIDs(int idTopic) async{
  print('Вход в getQuestionsIDs');
  List<int>ids = [];
  List<Map>_resultSet = await dataBase.select('SELECT _id FROM questions WHERE idTopic = $idTopic');
  _resultSet.forEach((element) {
    ids.add(element.values.elementAt(0));
  });
  return ids;
}

Future<Question>getQuestion(int idQuestion) async {
  List<Map>_resultSet = await dataBase.select('SELECT * FROM questions WHERE _id = $idQuestion');
  String nameQuestion = _resultSet.first.values.elementAt(2);
  List<Answer>answers = await getAnswers(idQuestion);
  String correctAnswer = _resultSet.first.values.elementAt(3);
  return new Question(idQuestion, nameQuestion, answers, correctAnswer);
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
  print('Answers: ${answers[0]}');
  return answers;
}