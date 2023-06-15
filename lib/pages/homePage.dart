import 'package:flutter/material.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/pages/Login.dart';
import 'package:todoapp/utils/dialogBox.dart';
import 'package:todoapp/utils/todoTile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// reference the hive
  final _mybox = Hive.box('mybox');


  final TextEditingController _controller = TextEditingController();

  database db = database();

  @override
  void initState() {
    // checking if it's the first time to use the app
    if(_mybox.get('TODOLIST')== null){
      db.createData();
    } else{
      // then this means they've already used the app and have some data
      db.loadData();
    }

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  // Static list



  // checkbox tapped
  void checkboxChanged (bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();


  }
  //save new task
  void saveNewTask () {

    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();

    });
    db.updateData();
    Navigator.of(context).pop();
  }
  // create new Task
  void createNewTask () {
    showDialog(context: context, builder: (context){
     return DialogBox(
       controller: _controller,
       onsave: saveNewTask,
       oncancel: () => Navigator.of(context).pop(),
     );
    });
  }
  // delete Task

  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  void signOut ()async{
    await FirebaseAuth.instance.signOut();
    setState(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_screen()));
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Todoey', style: TextStyle(
          color: Colors.white
        ),),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),


      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder:(context, index) {
            return todoTile(
                taskName: db.todoList[index][0],
                isDone: db.todoList[index][1],
                onchanged: (value) => checkboxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
            );
          },
      ),
    );
  }
}
