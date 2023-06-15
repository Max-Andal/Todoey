import 'package:hive_flutter/hive_flutter.dart';


class database {

  List todoList = [];
  final _mybox = Hive.box('mybox');


  //first time opening the app
  void createData() {
    todoList = [

    ];

  }

  //loading the data
  void loadData() {
    todoList = _mybox.get('TODOLIST');
  }
  //update the data

void updateData (){
    _mybox.put('TODOLIST', todoList);
}
}
