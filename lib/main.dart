import 'package:flutter/material.dart';
import 'package:todoapp/pages/Login.dart';
import 'package:todoapp/pages/signub.dart';
import 'pages/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  //initialize some stuff
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            return HomePage();
          }else if(snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'),);
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator(color: Colors.red,);
          }

          return Login_screen();
        },
      ),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
    );
  }
}


