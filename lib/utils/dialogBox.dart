import 'package:flutter/material.dart';
import 'package:todoapp/utils/Buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onsave;
 final VoidCallback oncancel;
   DialogBox({
    Key? key,
    required this.controller,
    required this.onsave,
    required this.oncancel
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Textfield to enter information
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'add a new Task'
              ),
            ),
            // bottoms save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Buttons(onpressed: onsave, buttonName: 'Save'),
                SizedBox(width: 8,),
                Buttons(onpressed: oncancel, buttonName: 'Cancel')
              ],
            )

          ],
        ),
      )
    );
  }
}
