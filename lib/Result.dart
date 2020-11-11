class Result{
  int _idQuestion;
  String _nameQuestion;
  String _usersAnswer;
  String _correctAnswer;
  bool _isUserRight;

  Result(this._idQuestion, this._nameQuestion, this._usersAnswer, this._correctAnswer, this._isUserRight);

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

  bool getIsUserRight(){
    return _isUserRight;
  }
}