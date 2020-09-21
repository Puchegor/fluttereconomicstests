import 'dart:collection';

class Question{
  String _nameQuestion;
  int _idQuestion;
  List<Answer> _answers;
  String _correctAnswer;

  Question(this._idQuestion, this._nameQuestion, this._answers, this._correctAnswer);

  String getNameQuestion(){
    return _nameQuestion;
  }

  int getIdQuestion(){
    return _idQuestion;
  }

  List<Answer>getAnswers(){
    return _answers;
  }

  String getCorrectAnswer(){
    return _correctAnswer;
  }
}

class Answer{
  String _nameAnswer;
  int _idAnswer;
  bool _isTrue;

  Answer(this._idAnswer, this._nameAnswer, this._isTrue);

  int getIdAnswer(){
    return _idAnswer;
  }

  String getNameAnswer(){
    return _nameAnswer;
  }

  bool getIsTrue(){
    return _isTrue;
  }
}