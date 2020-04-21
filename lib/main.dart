import 'package:flutter/material.dart';
import 'package:flutter_app/kitaab/my.dart';
//import 'package:flutter_app/kitaab/profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/kitaab/Register.dart';
import 'package:flutter_app/kitaab/list_main.dart';
//import 'package:flutter_app/kitaab/TesList.dart';
//


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Authentication().user,
      child: MaterialApp(

        initialRoute: '/Wrapauthhome',
        routes: {
         '/Wrapauthhome':(context) => Wrapauthhome(),
         'LoginRegister_wrapper':(context) => LoginRegister_wrapper(),
         //'/login':(context) => Login(),
         '/main_page':(context) => Record_INFO_testlist(),
//         '/profile':(context) => Profile(),
         //'/regitr':(context) => registr_user(),
           },

//home: TestList(),
      ),
    );
  }
}


class Wrapauthhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user =  Provider.of<User>(context);
    //print(user);

    if (user == null) {
      return LoginRegister_wrapper();
    }
    else {
      return Record_INFO_testlist();
    }


  }
}


class LoginRegister_wrapper extends StatefulWidget {
  @override
  _LoginRegister_wrapperState createState() => _LoginRegister_wrapperState();
}

class _LoginRegister_wrapperState extends State<LoginRegister_wrapper> {

  bool logyaregiter = true;

  void logYaregister(){
    setState(()=> logyaregiter =!logyaregiter);
  }

  @override
  Widget build(BuildContext context) {
    if (logyaregiter)
    {return Login(logYaregister: logYaregister);}
    else
    {return registr_user(logYaregister: logYaregister);}
  }

}



//Brew==KAIOrecord_class
// brews==KAIOrecord
//BrewList==RecordList
//brew==record