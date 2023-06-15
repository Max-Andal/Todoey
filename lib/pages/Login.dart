import 'package:flutter/material.dart';
import 'package:todoapp/backend/Auth_Methods.dart';
import 'package:todoapp/pages/homePage.dart';
import 'package:todoapp/pages/signub.dart';
import 'package:todoapp/utils/Buttons.dart';
import 'package:todoapp/utils/text_field.dart';
import 'package:todoapp/utils/utils.dart';


class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void Login () async{

    String res = await AuthMethods().LoginUser(
        email: _emailController.text,
        password: _passwordController.text,
    );

    if(res != 'success'){
      showSnackBar('Something went wrong', context);
    } else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
      showSnackBar('Succeeded to Login', context);
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
                'You have to make it done!',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20,),
              //Email Text-Field
              Textfield(hintText: 'person@example.com', obscure: false, controller: _emailController,),
              SizedBox(height: 10,),
              //Password Text-Field
              Textfield(hintText: 'Password', obscure: true, controller: _passwordController,),
              SizedBox(height: 10,),
              //Button
              Buttons(onpressed: Login, buttonName: 'Login'),
              SizedBox(height: 25,),
              //not a member Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member! ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Signub_Screen()));
                    },
                    child: Text(
                      'Resgister Now',
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
