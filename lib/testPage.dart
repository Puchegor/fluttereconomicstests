
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
  bool _answer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тест по теме'),
        elevation: 20.0,
      ),
      body: FutureBuilder(
        future: getQuestionsIDs(widget.idTopic),
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
                    elevation: 20.0,
                    color: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: FutureBuilder(
                      future: getQuestion(snapshot.data[index]),
                      builder: (context, snapQuestion){
                        if(snapQuestion.connectionState == ConnectionState.waiting)
                          return Center(child: CircularProgressIndicator(),);
                        else if (snapQuestion.hasError)
                          return Text('ERROR: ${snapQuestion.error}');
                        else
                          return Column(
                            children: <Widget>[
                              Text(snapQuestion.data.getNameQuestion(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,),
                              Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapQuestion.data.getAnswers().length,
                                      itemBuilder: (bc, ind){
                                        return RadioListTile(
                                          title: Text(snapQuestion.data.getAnswers()[ind].getNameAnswer(),
                                            style: TextStyle(color: Colors.black),),
                                          value: snapQuestion.data.getAnswers()[ind].getIsTrue(),
                                          groupValue: _answer,
                                        );
                                      })
                              ),
                              IconButton(icon: Icon(Icons.assignment_turned_in),
                              color: Colors.teal,
                              //onPressed: {},)
                            ],
                          );
                      },
                    )
                  );
                });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 20.0,
        child: Container(
          height: 50.0,
        ),
      ),
    );
  }
}

Future<List<int>>getQuestionsIDs(int idTopic) async{
  print('Вход в getQuestionsIDs');
  List<int>ids = [];
  List<Map>_resultSet = await dataBase.select('SELECT _id FROM questions WHERE idTopic = $idTopic');
  _resultSet.forEach((element) {
    ids.add(element.values.elementAt(0));
  });
  ids.shuffle();
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
  answers.shuffle();
  return answers;
}