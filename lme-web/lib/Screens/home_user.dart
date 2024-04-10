import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lme_final/Screens/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:lme/Screens/login_screen.dart';

class homeuser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homeuse();
  }
}

class homeuse extends StatefulWidget {
  @override
  _homeuseState createState() => _homeuseState();
}

class _homeuseState extends State<homeuse> {
  String email;
  var gotemail;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
  void initState() {
    super.initState();
    retrive();
    //getemail();  
     
  }
  getemail() async{
    var temp;
    var msg=await _firestoreInstance.collection('Users').where('Email',isEqualTo: 'supertr@gmail.com' ).get();
    for(var m in msg.docs)
    {
      temp=m.data();
    }
    gotemail = temp['Email'];
    print(gotemail+'lol');
  }
  // getValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   String stringValue = prefs.getString('email');
  //   return stringValue;
  // }
  String email_id;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  retrive() async {
    SharedPreferences emailsp = await prefs;//.getString('email');
    
    setState(() {
      email_id = emailsp.getString('email');
    });
    print(email_id);
    print('hi from here');
  }

  
  
    
    //email = prefs.getString('email');

  Future set;
  Widget screen(double width, double height) {
      
    //set.whenComplete(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  width: (width > 1100)
                      ? width * 0.40
                      : (width > 600)
                          ? width * 0.58
                          : width - 50,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  
                  child: (email_id == null)?CircularProgressIndicator():StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(email_id)
                          .snapshots(),
                          
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shutter_speed,
                                    size: 40.0,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Center(
                                      child: Text(
                                    "Life Made Easier",
                                    style: TextStyle(
                                      fontFamily: 'arial',
                                      fontSize: (width > 700)
                                          ? 24
                                          : (width > 450)
                                              ? 20
                                              : 16,
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Details of the services optained by You"),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: width * 0.15,
                                              //padding: EdgeInsets.symmetric()
                                              child: Center(
                                                child: Text(
                                                    "Services Completed",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            249, 111, 6, 1),
                                                        fontSize: (width > 700)
                                                            ? 18
                                                            : (width > 450)
                                                                ? 15
                                                                : (width > 320)
                                                                    ? 10
                                                                    : 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Segoe UI')),
                                              )),
                                        ],
                                      ),
                                    ),
                                    //-----------Vertical line-----------
                                    // Container(
                                    //   width: 2,
                                    //   height: 60,
                                    //   color: Colors.grey,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: width * 0.15,
                                              //padding: EdgeInsets.symmetric()
                                              child: Center(
                                                child: Text(
                                                    snapshot.data
                                                        .data()['Service']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            249, 111, 6, 1),
                                                        fontSize: (width > 700)
                                                            ? 18
                                                            : (width > 450)
                                                                ? 15
                                                                : (width > 320)
                                                                    ? 10
                                                                    : 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Segoe UI')),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: width * 0.15,
                                              //padding: EdgeInsets.symmetric()
                                              child: Center(
                                                child: Text(
                                                    "Services On Progress",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            249, 111, 6, 1),
                                                        fontSize: (width > 700)
                                                            ? 18
                                                            : (width > 450)
                                                                ? 15
                                                                : (width > 320)
                                                                    ? 10
                                                                    : 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Segoe UI')),
                                              )),
                                        ],
                                      ),
                                    ),
                                    //-----------Vertical line-----------
                                    // Container(
                                    //   width: 2,
                                    //   height: 60,
                                    //   color: Colors.grey,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: width * 0.15,
                                              //padding: EdgeInsets.symmetric()
                                              child: Center(
                                                child: Text(
                                                    snapshot.data
                                                        .data()['Progress']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            249, 111, 6, 1),
                                                        fontSize: (width > 700)
                                                            ? 18
                                                            : (width > 450)
                                                                ? 15
                                                                : (width > 320)
                                                                    ? 10
                                                                    : 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Segoe UI')),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: width * 0.15,
                                              //padding: EdgeInsets.symmetric()
                                              child: Center(
                                                child: Text("Services Pending",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            249, 111, 6, 1),
                                                        fontSize: (width > 700)
                                                            ? 18
                                                            : (width > 450)
                                                                ? 15
                                                                : (width > 320)
                                                                    ? 10
                                                                    : 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Segoe UI')),
                                              )),
                                        ],
                                      ),
                                    ),
                                    //-----------Vertical line-----------
                                    // Container(
                                    //   width: 2,
                                    //   height: 60,
                                    //   color: Colors.grey,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: width * 0.15,
                                              //padding: EdgeInsets.symmetric()
                                              child: Center(
                                                child: Text(
                                                    snapshot.data
                                                        .data()['Pending']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            249, 111, 6, 1),
                                                        fontSize: (width > 700)
                                                            ? 18
                                                            : (width > 450)
                                                                ? 15
                                                                : (width > 320)
                                                                    ? 10
                                                                    : 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Segoe UI')),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      })),
            ),
          ],
        ),
    );
  
  }
  

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: pulldrawer(context, 0),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                //Navigator.pushNamed(context, 'dashboard');
              }),
          Padding(padding: EdgeInsets.only(right: 10))
        ],
        title: Text(
          '   Life Made Easier',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange[300],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("bg4.jpg"),
          fit: BoxFit.cover,
        )),
        child: Container(
          child: screen(_width, _height),
        ), //
      ),
    );
  }
}