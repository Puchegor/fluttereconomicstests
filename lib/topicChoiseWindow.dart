import 'package:flutter/material.dart';

class topicChoiseWindow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Выберите тему для тестирования'),
        elevation: 10.0,
      ),
    );
  }
}