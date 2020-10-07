import 'package:shared_preferences/shared_preferences.dart';

abstract class Options{
  static const int _defaultNumberOfQuestions = 20;
  static const int _defaultTime = 30;
  static const double _defaultFontSize = 14;

  static int _userTimer;
  static int _userNumberOfQuestions;
  static double _userFontSize;

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
    _userFontSize = _preferences.getDouble('userFontSize');
    if (_userFontSize == null){
      setUserFontSize(_defaultFontSize);
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

  static void setUserFontSize(double number){
    _userFontSize = number;
    _preferences.setDouble('userFontSize', number);
  }

  static int getUserTimer(){
    return _userTimer;
  }

  static int getUserNumberOfQuestions(){
    return _userNumberOfQuestions;
  }

  static double getUserFontSize(){
    return _userFontSize;
  }
}