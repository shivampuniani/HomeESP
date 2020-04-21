import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/kitaab/my.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:provider/provider.dart';

bool themetilecard = true;

class Record_INFO_testlist extends StatefulWidget {
  @override
  _Record_INFO_testlistState createState() => _Record_INFO_testlistState();
}

class _Record_INFO_testlistState extends State<Record_INFO_testlist> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    void _show_menu(){
      final Authentication _auth = Authentication();

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          child: Column(
            children: <Widget>[
              Text('KAIO Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    letterSpacing: 1.0,)),

              FlatButton.icon(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.red,
                    size: 25,
                  ),
                  label: Text('Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.0,)),
                  color: Colors.blueAccent,
                  onPressed: () =>  Navigator.pushNamed(context, '/profile')

              ),


              FlatButton.icon(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.red,
                    size: 25,
                  ),
                  label: Text('Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.0,)),
                  color: Colors.blueAccent,

                  //Navigator.pushNamed(context, '/profile');

                  onPressed: () {
                          FirebaseAuth.instance.currentUser().then((user){
                            Firestore.instance.collection("record_collection/${user.uid}/records").add({
                              "time":DateTime.now().millisecondsSinceEpoch,
                              "purpose":"Fan and Light",
                              "device":"ESP 8266",

                          });
                        },
                    );
                  }
              ),


              FlatButton.icon(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.red,
                  size: 25,
                ),
                label: Text('Log Out',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.0,)),
                color: Colors.blueAccent,
                onPressed: () async{
                  await _auth.signout();
                },
              ),
            ],
          ),
        );
      });
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.access_time,
                color: Colors.red,
                size: 25,
              ),
//                text: "Alarm",
              ),
              Tab(icon: Icon(Icons.usb,
                color: Colors.red,
                size: 25,
              ),
//                text:"Record" ,
              ),
              Tab(icon: Icon(Icons.work,
                color: Colors.red,
                size: 25,
              ),
//                  text:"Timer"
              ),
            ],
          ),
          title: Text('KAIO Records',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
                letterSpacing: 1.0,
              )),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.red,
                size: 25,
              ),
              label: Text(''),
              onPressed: () => _show_menu(),
            )
          ],
        ),
        backgroundColor: Colors.black,
        body:
        TabBarView(
         children: [
           Icon(Icons.access_time),
           themetilecard ? RecordList() :
          Scrollbar(
            child: Column(
              children: <Widget>[
                //RecordList();

                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.work,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.devices_other,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
//                           color: Colors.black,
                        color: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: FittedBox(
                          child: Text('Time',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.cyanAccent,
                                letterSpacing: 2.0,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
//                          color: Colors.black,
                        color: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: FittedBox(
                          child: Text('Purpose',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyanAccent,
                                letterSpacing: 1.0,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
//                           color: Colors.black,
                        color: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: FittedBox(
                          child: Text( 'Device',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.cyanAccent,
                                letterSpacing: 1.0,
                              )),
                        ),
                      ),
                    ),

                  ],
                ),
                RecordList()

//
//              Align(
//                alignment: Alignment.center,
//                child: Image.asset('assets/HOMEPAGEf.jpg'),
//              )
                //RecordList()
              ],
            ),
          ),
           Icon(Icons.usb),

         ]
       )
//      ),
      ),
    );
  }
}

class RecordList extends StatefulWidget {
  @override
  _RecordListState createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {

//  RecordList({this.uid})
//  Future<DocumentSnapshot> get_Record() async {
//    var firestore = Firestore.instance;
//    String uid = (await FirebaseAuth.instance.currentUser()).uid;
//       DocumentSnapshot qns = await firestore.document("recordcollection/records_info$uid").document(dataid).collection('records_info').get();
//       final qnhs = await firestore.collection("recordcollection/records_info$uid").document().collection('records_info').getDocuments();
//       DocumentSnapshot qns = await firestore.document("recordcollection/${uid}").get();
//       return null;
//    return qns;
//  }


  //RecordList({this.})
  String uid;
  String computer = "computer";
  String fan = "fan";
  String light = "light";
  String AC = "AC";
  String  ID = "ID";
  String  lock = "lock";
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      uid = user.uid;
      setState(() {

      });
    });
  }
  ScrollController _controller = new ScrollController();

  //  final Function hta, this.hta;return

  @override
  Widget build(BuildContext context) {
//    DateTime now = DateTime.now();
//    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
//    var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");  // 8:18pm
//      var hour = DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()

    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, user) {
        if (user.hasData && user.connectionState == ConnectionState.done) {
          return StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(
                "record_collection/${user.data.uid}/records").orderBy("time", descending: true).snapshots(),

            builder: (context, docs) {
              if (docs.hasData &&
                  docs.connectionState != ConnectionState.waiting) {
                  if(docs.data.documents.isEmpty){
                    return Text('Show this when data is empty ');
                  }

                return ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  itemCount: docs.data.documents.length ,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = docs.data.documents[index];
//                      var time = DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String();
//                      assert(time.hour == 20);
//                      var difference = DateTime.now().difference(doc['time']);


//                      var hour = ;
//                    device_task();
//                    if (index >= docs.data.documents.length) {
//                    }


                    if(doc['device']== computer){
                      return Card(
                        child:  ListTile(
                          leading: Icon(
                            Icons.computer,
                            color: Colors.cyan,
                            size: 25,),
                          title: Row(
                            children: <Widget>[
                              Text("$index   "),
                              Text(doc['purpose']),

                            ],
                          ),
                          subtitle: Text(
                              DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()),
                        ),
                      );
                    }
                    else if(doc['device']== fan){
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.trip_origin,
                            color: Colors.black,
                            size: 25,),
                          title: Row(
                            children: <Widget>[
                              Text("$index   "),
                              Text(doc['purpose']),

                            ],
                          ),
                          subtitle: Text(
                              DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()),
                        ),
                      );
                    }
                    else if(doc['device']== light) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.lightbulb_outline,
                            color: Colors.indigoAccent,
                            size: 25,),
                          title: Row(
                            children: <Widget>[
                              Text("$index   "),
                              Text(doc['purpose']),

                            ],
                          ),
                          subtitle: Text(
                              DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()),
                        ),
                      );
                    }
                    else if(doc['device']== lock) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Colors.lightBlueAccent,
                            size: 25,),
                          title: Row(
                            children: <Widget>[
                              Text("$index   "),
                              Text(doc['purpose']),

                            ],
                          ),
                          subtitle: Text(
                              DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()),
                        ),
                      );
                    }
                    else if(doc['device']== AC) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.brightness_low,

                            color: Colors.lightBlueAccent,
                            size: 25,),
                          title: Row(
                            children: <Widget>[
                              Text("$index"),
                              Text(doc['purpose']),

                            ],
                          ),
                          subtitle: Text(
                              DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()),
                        ),
                      );
                    }
                    else if (doc['device']== ID) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.perm_identity,
                            color: Colors.lightBlueAccent,
                            size: 25,),
                          title: Row(
                            children: <Widget>[
                              Text("$index"),
//                              Text(doc['purpose']),

                            ],
                          ),
                          subtitle: Text(
                              DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()),
                        ),
                      );
                    }
                  else {
                      return  Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            Expanded(flex: 1,
                              child: Icon(Icons.tv,color: Colors.white,
                                size: 30,),),

                            Expanded(flex: 1,
                              child: Text(doc['purpose']),),

                            Expanded(flex: 1,
                              child: Icon(Icons.computer,color: Colors.white,
                                size: 30,),),

                            Text(
                                DateTime.fromMillisecondsSinceEpoch(doc['time']).toIso8601String()),

                          ],
                        ),
                      );

                  }


                  },
                );
              }
              return Center(child: CircularProgressIndicator(),);
            },
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },

    );

  }}

