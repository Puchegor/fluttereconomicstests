class Result{
  int _idQuestion;
  String _nameQuestion;
  String _usersAnswer;
  String _correctAnswer;

  Result(this._idQuestion, this._nameQuestion, this._usersAnswer, this._correctAnswer);

  int getIDQuestion(){
    return _idQuestion;
  }

  String getNameQuestion(){
    return _nameQuestion;
  }

  String getUsersAnswer(){
    return _usersAnswer;
  }

  String getCorrectAnswer(){
    return _correctAnswer;
  }
}