import 'package:flutter/material.dart';


class Buttons extends StatelessWidget {
  final String buttonName;
  final VoidCallback onpressed;
   Buttons({required this.onpressed, required this.buttonName});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,
      child: Text(buttonName, style: TextStyle(color: Colors.white),),
      color: Colors.deepPurple,
    );
  }
}
