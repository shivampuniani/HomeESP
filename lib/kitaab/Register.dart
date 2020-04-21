//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/kitaab/my.dart';
import 'package:flutter/material.dart';



class registr_user extends StatefulWidget {

  final Function logYaregister;
  registr_user({this.logYaregister});


  @override
  _registr_userState createState() => _registr_userState();
}

class _registr_userState extends State<registr_user> {


  final Authentication _auth = Authentication();
  final _formkey = GlobalKey<FormState>();

  bool load =false;

  String user_auth_id='' ;
  String user_auth_key='' ;
  String error ='';

  @override
  Widget build(BuildContext context) {
    return load ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(
            'KAIO Register',
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
            label: Text('Log In'),
            onPressed: () {
              widget.logYaregister();
              //Navigator.pushNamed(context, '/regitr');;
            },
          )
        ],


      ),
      backgroundColor: Colors.white,
      body:

      SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Stack(
              children: <Widget> [

                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/HOMEPAGEf.jpg'),
                          fit: BoxFit.cover,)) ),



                Column(
              children: <Widget>[




               Align(
               alignment: Alignment.center,
                 child:
                 Icon(Icons.sd_storage,
                   color: Colors.red,
                   size: 30,)

                 ),


              Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,

                    children: <Widget>[

                      SizedBox(width: 10.0,),

                      Icon(
                        Icons.perm_identity,
                        color: Colors.red,
                        size: 30,
                      ),

                      SizedBox(width: 10.0,),

                      //SizedBox(width: 10.0,),

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Enter Authentication id'
                            ),
                            validator: (ID)=> ID.isEmpty ? '': null,
                            //if( ID.isEmpty)
                            onChanged: (ID){
                              setState(()=> user_auth_id =ID);
                            },
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan,
                              letterSpacing: 2.0,)),
                      ),

                      SizedBox(width: 10.0,),


                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      SizedBox(width: 10.0,),
                      Icon(
                        Icons.vpn_key,
                        color: Colors.red,
                        size: 30,
                      ),


                      SizedBox(width: 10.0,),
                      //SizedBox(width: 10.0,),

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Enter Authentication key'
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

                      SizedBox(width: 10.0,),

                    ],
                  ),
                ),



                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  //padding: EdgeInsets.all(40.0),
                  //margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 140.0),
                  child:FlatButton(
                    onPressed: () async{
                      if (_formkey.currentState.validate()) {
                        dynamic result = await _auth.registerwithmail(user_auth_id, user_auth_key);
                        if(result==null){
                          setState(()=>error = 'if you want to login then enter right credential');
                          load = true;
                        }
                        print(user_auth_key);
                        print(user_auth_id);
                      }
                      else{}

                      //Navigator.pushNamed(context, '/main_page');
                    },
                    color: Colors.blueAccent,
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 22,

                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        //letterSpacing: 1.0,
                      ), ),

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

              ],
            ),
        ]
          ),
        ),
      ),

    );
  }


}
