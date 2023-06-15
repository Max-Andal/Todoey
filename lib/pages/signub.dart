import 'package:flutter/material.dart';
import 'package:todoapp/backend/Auth_Methods.dart';
import 'package:todoapp/pages/Login.dart';
import 'package:todoapp/pages/homePage.dart';
import 'package:todoapp/utils/utils.dart';

import '../utils/Buttons.dart';
import '../utils/text_field.dart';

class Signub_Screen extends StatefulWidget {
  const Signub_Screen({Key? key}) : super(key: key);

  @override
  State<Signub_Screen> createState() => _Signub_ScreenState();
}

class _Signub_ScreenState extends State<Signub_Screen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _username = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _username.dispose();
    super.dispose();
  }

  void signup () async {
    String res = await AuthMethods().SignupUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _username.text
    );
    if(res != 'success') {
      showSnackBar('Something went wrong', context);
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      showSnackBar('succeeded to signup', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.handshake_sharp,
                size: 100,
              ),
              SizedBox(height: 75,),
              // welcome-back text
              Text(
                'Hey, Hustler!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'i dare you to complete your todos!',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              SizedBox(height: 20,),
              // Name
              Textfield(hintText: 'Name', obscure: false, controller: _username,),
              SizedBox(height: 10,),
              //Email Text-Field
              Textfield(hintText: 'person@example.com', obscure: false, controller: _emailController,),
              SizedBox(height: 10,),
              //Password Text-Field
              Textfield(hintText: 'Password', obscure: true, controller: _passwordController,),
              SizedBox(height: 10,),
              //Button
              Buttons(onpressed: signup, buttonName: 'Signup'),
              SizedBox(height: 25,),
              //not a member Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account! ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login_screen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight:FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
