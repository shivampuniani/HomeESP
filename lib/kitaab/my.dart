import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_app/kitaab/list_main.dart';


// ye class sirf login ID print krne ke liye bnai h
class User{

  final String Login_id;
  User({this.Login_id});
}


// is class ka kaam log in krne ke liye firebase ke saath kiya gya h
class Authentication{
  final FirebaseAuth _auth= FirebaseAuth.instance;

  //create user obj based on firebaseuser
  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(Login_id: user.uid): null;
  }

  // my.dart change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
       
  }


  // sign in anonymously
  Future signinano() async{
    try{

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }

  }


  // signout anonymously
  Future signout() async{
    try{

      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;

    }

  }
  // sign in using Email
  Future signinwithmail(String Mail, String Password_key) async{

    try{

      AuthResult result = await _auth.signInWithEmailAndPassword(email: Mail, password: Password_key);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }





  // registr in using Email
  Future registerwithmail(String Mail, String Password_key) async{

    try{

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: Mail, password: Password_key);
      FirebaseUser user = result.user;
      await FirebaseAuth.instance.currentUser().then((user) {

        Firestore.instance.collection("record_collection/${user.uid}/records").add({
          "time":DateTime.now().millisecondsSinceEpoch,
          //hhagaj
          "purpose": "Switch",
          "device": "Fan",
        });
    });

//      await Database(dataid: user.uid).updaterecord('dd/mm/yy', 'Accounts' , '123 456 789', 'computer');

      return _userFromFirebaseUser(user);
}
    catch(e){
      print(e.toString());
          return null;
    }

  }

}


// login krte time jo screen per dikhega wo yaha h
class Login extends StatefulWidget {


  final Function logYaregister;
  Login({this.logYaregister});



  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final Authentication _auth = Authentication();
  final _formkey = GlobalKey<FormState>();

  bool load =false;

  String user_auth_id = '';
  String user_auth_key = '';
  String error ='';



  @override
  Widget build(BuildContext context) {
    return load ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(
            'KAIO Login',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2.0,)),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.account_box,
              color: Colors.red,
              size: 25,
            ),
            label: Text('CreateAccount'),
            onPressed: () {
              widget.logYaregister();
              //Navigator.pushNamed(context, '/regitr');
            },
          )
        ],


      ),
      backgroundColor: Colors.black,
      body:

          SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,

                      children: <Widget>[

                        Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                          size: 30,
                        ),
                        //Text('   '),
                        //SizedBox(width: 10.0,),

                        //SizedBox(width: 10.0,),

                        Expanded(
                          flex: 1,
                          child: TextFormField(

                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Authentication id',
                                  enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                              color: Colors.white, width: 2.0) ),
                        ),

                              validator: (key) => key.length <8 ? 'Password conditions are not satisfied': null,
                               onChanged: (ID){
                                 setState(()=> user_auth_id =ID);
                               },
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan,
                                  letterSpacing: 2.0,)),
                        ),


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(
                          Icons.vpn_key,
                          color: Colors.red,
                          size: 30,
                        ),
                        //SizedBox(width: 10.0,),
                        //SizedBox(width: 10.0,),

                        Expanded(
                          flex: 1,
                          child: TextFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Authentication key',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0) ), // OutlineInputBorder
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink, width: 2.0) , )// OutlineInputBorder
                        ),

                            validator: (key) => key.length <8 ? 'Password conditions are not satisfied': null,
                            obscureText: true,
                           onChanged: (key){
                             setState(()=> user_auth_key =key);
                           },
                              style: TextStyle(
                                color: Colors.cyan,
                                  fontSize: 20,
                                  letterSpacing: 2.0,)),
                        ),

                      ],
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    //padding: EdgeInsets.all(40.0),
                    //margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 140.0),
                    child: FlatButton(
                      onPressed: ()async{
                        //print('on');
                        if (_formkey.currentState.validate()) {
                          setState(() => load = true );
                          dynamic result = await _auth.signinwithmail(user_auth_id, user_auth_key);
                          if(result==null){
                            setState(()=>error = 'if you want to login then enter right credential');
                            load = true;
                          }
                          print(user_auth_key);
                          print(user_auth_id);
                        }
                        //else{}
                        //Navigator.pushNamed(context, '/main_page');
                      },
                      color: Colors.blueAccent,
                      child: Text(
                        'Login : ID / Key',
                        style: TextStyle(
                          fontSize: 22,

                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          //letterSpacing: 1.0,
                        ), ),

                    ),
                  ),


                  Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    //padding: EdgeInsets.all(40.0),
                    //margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 140.0),
                    child: FlatButton(
                      onPressed: ()async{
                          setState(()=>error = 'if you want to login then enter right credential');
                          load = true;

                        dynamic result = await _auth.signinano();
                        if (result==null){
                          print("error logging in");
                        }
                        else{
                          print("logging in");
                          print(result.Login_id);
                        }
                        print(user_auth_key);
                        print(user_auth_id);
                        //Navigator.pushNamed(context, '/main_page');
                      },
                      color: Colors.blueAccent,
                      child: Text(
                        'Login : anonymously',
                        style: TextStyle(
                          fontSize: 22,

                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          //letterSpacing: 1.0,
                         ), ),

                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    //padding: EdgeInsets.all(40.0),
                    //margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 140.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/main_page');
                      },
                      color: Colors.redAccent,
                      child: Text(
                        'forgot',
                        style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.0,), ),

                    ),
                  ),


                  SizedBox(width: 10.0,),
                  Text(error,
                    style: TextStyle(
                      fontSize: 16,

                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      //letterSpacing: 1.0,
                    ), ),


                  Align(
                    alignment: Alignment.center,
                    child:

                    Image.asset('assets/chuwi-herobook-header.jpg'),

                    //Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/HOMEPAGEf.jpg'), fit: BoxFit.cover,)) ),
                  )

                ],
              ),
            ),
          ),

    );
  }
}




class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitChasingDots(
             color: Colors.brown, size: 50.0, ), // SpinKitChasingDots
     ),
       );
    }
  }

