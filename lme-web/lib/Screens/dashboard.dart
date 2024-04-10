import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lme_final/Screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return dash();
  }
}

class dash extends StatefulWidget {
  @override
  _dashState createState() => _dashState();
}

class _dashState extends State<dash> {
  // final _formkey = GlobalKey<FormState>(); //key created to interact with the form
  // var name,final_response;
  // //function to validate and save user form 
  // Future<void> _savingData() async{
  //   final validation = _formkey.currentState.validate();
  //   if (!validation){
  //     return;
  //   }
  //   _formkey.currentState.save();
  // }
  Widget screen(double width, double height) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonTheme(
                  minWidth: 90,
                  height: 45,
                  child: MaterialButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.blueAccent[700],
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreens()));

                      }),
                ),
                
              ],
            ),
            SizedBox(
              height: (height > 600) ? height * 0.18 : height * 0.1,
            ),
            // Form(key: _formkey,
            //     child: TextFormField(
            //         decoration: InputDecoration(
            //           labelText: 'Enter your name: ',
                      
            //         ),onSaved: (value){
            //           name = value; //getting data from the user form and assigning it to name 
            //         },
            //         ),
            //   ),
            
        

            // FlatButton(
            //   onPressed: () async {

            //     //validating the form and saving it
            //     try{
            //       _savingData();

            //     //url to send the post request to 
            //     final url = 'http://127.0.0.1:5000/name';

            //     //sending a post request to the url
            //     final response = await http.post(url, body: convert.jsonEncode({'name' : name}));
            //     }
            //     catch(e)
            //     {
            //       print(e);
            //     }

            //   },
            //   child: Text('SEND'),
            //   color: Colors.blue,
            // ),


            // FlatButton(
            //   onPressed: () async {

            //     //url to send the get request to 
            //     try{
            //       final url = 'http://127.0.0.1:5000/name';

            //     //getting data from the python server script and assigning it to response
            //     final response = await http.get(url);

            //     //converting the fetched data from json to key value pair that can be displayed on the screen
            //     if(response.statusCode == 200)
            //     {
            //       final decoded = convert.jsonDecode(response.body) as Map<String, dynamic>;

            //     //changing the UI be reassigning the fetched data to final response
            //     setState(() {
            //       final_response = decoded['name'];
            //     });
            //     }
            //     else
            //     print('fail');
            //     }catch(e){
            //       print(e);

            //     }
            //     print(final_response);

            //   },
            //   child: Text('GET'),
            //   color: Colors.lightBlue,
            // ),

            //displays the data on the screen
            //Text(final_response, style: TextStyle(fontSize: 24)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("service")
                    .doc("details")
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: (width > 1100)
                                ? width * 0.40
                                : (width > 600)
                                    ? width * 0.58
                                    : width - 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 40),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
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
                                Text("Service Details By LME"),
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
                                                  child: Text("Services",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              249, 111, 6, 1),
                                                          fontSize: (width >
                                                                  700)
                                                              ? 18
                                                              : (width > 450)
                                                                  ? 15
                                                                  : (width >
                                                                          320)
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
                                                          .data()['pending']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              249, 111, 6, 1),
                                                          fontSize: (width >
                                                                  700)
                                                              ? 18
                                                              : (width > 450)
                                                                  ? 15
                                                                  : (width >
                                                                          320)
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
                                                          fontSize: (width >
                                                                  700)
                                                              ? 18
                                                              : (width > 450)
                                                                  ? 15
                                                                  : (width >
                                                                          320)
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
                                                          .data()['progress']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              249, 111, 6, 1),
                                                          fontSize: (width >
                                                                  700)
                                                              ? 18
                                                              : (width > 450)
                                                                  ? 15
                                                                  : (width >
                                                                          320)
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
                                      //--------Cable - Payment----------
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
                                                          fontSize: (width >
                                                                  700)
                                                              ? 18
                                                              : (width > 450)
                                                                  ? 15
                                                                  : (width >
                                                                          320)
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
                                                          .data()['service']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              249, 111, 6, 1),
                                                          fontSize: (width >
                                                                  700)
                                                              ? 18
                                                              : (width > 450)
                                                                  ? 15
                                                                  : (width >
                                                                          320)
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
                                Text("Login to Experience the power of Service")
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("bgmain2.jpg"),
          fit: BoxFit.cover,
        )),
        child: screen(_width, _height),
      ),
    );
  }
}