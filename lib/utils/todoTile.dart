import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class todoTile extends StatelessWidget {
  todoTile({
    required this.taskName,
    required this.isDone,
    required this.onchanged,
    required this.deleteFunction
});
  final String taskName;
  final bool isDone;
  final Function(bool?)? onchanged;
  final Function (BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Row(
            children: [
              Checkbox(value: isDone, onChanged: onchanged, activeColor: Colors.black,),
              Text(
                taskName,
                style: TextStyle(decoration: isDone?TextDecoration.lineThrough: TextDecoration.none, color: Colors.white),
              ),
            ],),
          decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    );
  }
}
