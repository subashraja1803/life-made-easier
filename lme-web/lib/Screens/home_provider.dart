import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lme_final/Screens/drawersp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase/firebase.dart' as fb;
//import 'package:lme/Screens/login_screen.dart';

class homeprovider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homepro();
  }
}

class homepro extends StatefulWidget {
  @override
  _homeproState createState() => _homeproState();
}

class _homeproState extends State<homepro> {
 var UserMail;
  var email;
  var url1,url2,url3;
  var url1f,url2f,url3f;
  String email_id;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  void initState() {
    super.initState();
    retrive().then((_) {
      //geturl();
    });
    //getCurrentUser().then((_) {geturl();});
    
    //getemail();  
     
  }
  var temp;
  final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
  Future geturl() async{
    print(email_id+'from geturl');
   
        fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child('trial2sp@gmail.com/Aadhaar')
        .getDownloadURL().then((value){
          setState(() {
            url1f = value;
            print(url1f+'bye');
          });
        } );
        fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child('trial2sp@gmail.com/Certificate')
        .getDownloadURL().then((value) {
          setState((){
            url2f = value;
            print(url2f+'hey');
          });
        });
        fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child('trial2sp@gmail.com/Work')
        .getDownloadURL().then((value) {
          setState((){
            url3f = value;
            print(url3f+'low');
          });
        });
      
     
     
     
  }
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        UserMail = user.email;
        final uid=user.uid;
      }
      print(UserMail);
    } catch (e) {
      print(e);
    }
    //setState(() {});
 }
  Future retrive() async {
    SharedPreferences emailsp = await prefs;//.getString('email');
    
    setState(() {
      email_id = emailsp.getString('email');
    });
    // print(email_id);
    // print('hi from here');
  }
  
  Widget screen(double width, double height) {
    
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(  //////////sdfbjksf
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
                  child: StreamBuilder(
          stream: (email_id == null)?CircularProgressIndicator():FirebaseFirestore.instance
              .collection("SP")
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
                  Text("Details of services Provided by You"),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: width * 0.15,
                                  //padding: EdgeInsets.symmetric()
                                  child: Center(
                                    child: Text("Services Completed",
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
                                            fontFamily: 'Segoe UI')),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.0),
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
                                            fontFamily: 'Segoe UI')),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.0),
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
                                            fontFamily: 'Segoe UI')),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.0),
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
                                            fontFamily: 'Segoe UI')),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.0),
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
                                            fontFamily: 'Segoe UI')),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.0),
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
                                            fontFamily: 'Segoe UI')),
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
          }),
                ),
              ),
            ],
          ));
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
          '   Life Made Easier  (Service Provider)',
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