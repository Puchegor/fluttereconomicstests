import 'package:shared_preferences/shared_preferences.dart';

abstract class Options{
  static const int _defaultNumberOfQuestions = 20;
  static const int _defaultTime = 30;

  static int _userTimer;
  static int _userNumberOfQuestions;

  static SharedPreferences _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
    _userTimer = _preferences.getInt('userTimer');
    if (_userTimer == null){
      setUserTimer(_defaultTime);
    }
    _userNumberOfQuestions = _preferences.getInt('userNumberOfQuestions');
    if (_userNumberOfQuestions == null){
      setUserNumberOfQuestions(_defaultNumberOfQuestions);
    }
  }

  static void setUserTimer(int timer){
    _userTimer = timer;
    _preferences.setInt('userTimer', timer);
  }

  static void setUserNumberOfQuestions(int number){
    _userNumberOfQuestions = number;
    _preferences.setInt('userNumberOfQuestions', number);
  }

  static int getUserTimer(){
    return _userTimer;
  }

  static int getUserNumberOfQuestions(){
    return _userNumberOfQuestions;
  }
}