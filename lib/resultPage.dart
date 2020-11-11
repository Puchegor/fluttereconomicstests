import 'package:flutter/material.dart';

import 'Result.dart';

class ResultPage extends StatelessWidget{
  List<Result>results;
  ResultPage({Key key, @required this.results});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты теста'),
        elevation: 10.0,
      ),
      body: ListView.builder(itemCount: results.length,
          itemBuilder: (buildContext, index){
            return Card(
              elevation: 20.0,
              color: results.elementAt(index).getIsUserRight() ? Colors.green : Colors.red,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
            );
          }),
    );
  }  
}