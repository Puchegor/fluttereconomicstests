
import 'package:flutter/material.dart';
import 'dart:async';

import 'Question.dart';
import 'dataBase.dart';
import 'Result.dart';

int numberOfQuestions;
int indicator = 0;

class testPage extends StatefulWidget{
  int idTopic;
  bool isControl;
  testPage({Key key, @required this.idTopic, @required this.isControl});
  @override
  testPageState createState() => testPageState();
}

class testPageState extends State<testPage>{
  Answer _usersAnswer;
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
          else {
            numberOfQuestions = snapshot.data.length;
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (buildContext, index) {
                  return Card(
                      elevation: 20.0,
                      color: Colors.white,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: FutureBuilder(
                        future: getQuestion(snapshot.data[index]),
                        builder: (context, snapQuestion) {
                          if (snapQuestion.connectionState ==
                              ConnectionState.waiting)
                            return Center(child: CircularProgressIndicator(),);
                          else if (snapQuestion.hasError)
                            return Text('ERROR: ${snapQuestion.error}');
                          else
                            return TestWidget(question: snapQuestion.data,
                              isControl: widget.isControl,);
                        },
                      )
                  );
                });
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 20.0,
        child: Container(
          height: 50.0,
          child: Center(
            child: Indicator(),
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatefulWidget{
  IndicatorState createState() => IndicatorState();
}

class IndicatorState extends State<Indicator>{
  @override
  Widget build(BuildContext context) {
    return Text('$indicator / $numberOfQuestions',
      style: TextStyle(fontSize: 24.0,
          color: Colors.white70),
    );
  }
}

Future<List<int>>getQuestionsIDs(int idTopic) async{
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

class TestWidget extends StatefulWidget{
  Question question;
  bool isControl;
  TestWidget({Key key, @required this.question, @required this.isControl});
  @override
  TestWidgetState createState() => TestWidgetState();
}

class TestWidgetState extends State<TestWidget>{
  Answer _selectedAnswer;
  List<Result>results = [];
  bool buttonIsEnable = false;
  bool isContainerVisible = true;

  @override
  Widget build(BuildContext context) {
    if (isContainerVisible)
    return Column(
      children: <Widget>[
        Text(widget.question.getNameQuestion(),
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
          textAlign: TextAlign.left,),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.question.getAnswers().length,
            itemBuilder: (bc, index){
              return RadioListTile(
                title: Text(widget.question.getAnswers()[index].getNameAnswer()),
                value: widget.question.getAnswers()[index],
                groupValue: _selectedAnswer,
                onChanged: (Answer value){
                  setState(() {
                    _selectedAnswer = value;
                    buttonIsEnable = true;
                  });
                },
              );
            },
          ),
        ),
        RaisedButton(
          child: Icon(Icons.check),
          color: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          onPressed: buttonIsEnable ? (){
            bool isUserRight;
            _selectedAnswer.getIsTrue() ? isUserRight = true : isUserRight = false;
            Result result = new Result(widget.question.getIdQuestion(),
                widget.question.getNameQuestion(), _selectedAnswer.getNameAnswer(),
                widget.question.getCorrectAnswer(), isUserRight);
            results.add(result);
            if(!widget.isControl){
              resultDialog(context, result);
            }
            setState(() {
              isContainerVisible = false;
              indicator++;
            });
            //Добавить условие из типа теста!
          } : null,
        )
      ],
    ); else
      return Column();
  }
}

void resultDialog(BuildContext context, Result result){
  showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: result.getIsUserRight() ? Colors.greenAccent : Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(result.getIsUserRight() ? 'Отлично!' : 'Вы не правы'),
          content: Column(
            children: <Widget>[
              Text('Вопрос: ${result.getNameQuestion()}'),
              Text(''),
              Text('Ответ: ${(result.getCorrectAnswer())!=null ? result.getCorrectAnswer() : 'Правильного ответа у нас нет, но обязательно будет!'}'),
            ],
          ),
          actions: <Widget>[
            Center(child:
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            )
          ],
        );
      }
  );
}