import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lme_final/Screens/drawersp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class pendsp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pendingsp();
  }
}

class pendingsp extends StatefulWidget {
  @override
  _pendingspState createState() => _pendingspState();
}

class _pendingspState extends State<pendingsp> {
  
  var email;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
   Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  retrive() async {
    SharedPreferences emailsp = await prefs;//.getString('email');
    
    setState(() {
      email = emailsp.getString('email');
    });
    // print(email);
    // print('hi from here');
  }


  List<int> dummylist = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    retrive();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: pulldrawer(context, 5),
      appBar: AppBar(
        title: Text(
          ' Life Made Easier (Service Provider)',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange[300],
      ),
      body: ListView(children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                "Pending Services",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                child: (email == null)?CircularProgressIndicator():StreamBuilder(
                    stream: _firestoreInstance.collection('SP').doc('$email').collection('Service').where('Status', isEqualTo : 'Pending').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount:(snapshot.data.docs.length != 0)?snapshot.data.docs.length : 1,
                  itemBuilder: (BuildContext context, int i) {
                    if(snapshot.data.docs.length != 0){
                      if(snapshot.data.docs[i].data()['Status'] == 'Pending') 
                    return Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(14.0),
                            shadowColor: Color(0x802196F3),
                            child: Padding(
                              padding: (width > 410)
                                  ? EdgeInsets.all(20.0)
                                  : (width > 310)
                                      ? EdgeInsets.all(10.0)
                                      : EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data.docs[i].data()['Brand']+' '+snapshot.data.docs[i].data()['Service_field']+' Service',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        (width > 500) ? 16 : 10),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Customer :" + snapshot.data.docs[i].data()['Customer Name'],
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("city : "+snapshot.data.docs[i].data()['City'],
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("area : "+snapshot.data.docs[i].data()['Area'],
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: (width > 620)
                                            ? 200
                                            : (width > 500)
                                                ? 100
                                                : (width > 400)
                                                    ? 50
                                                    : 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Ph no : "+snapshot.data.docs[i].data()['Customer Ph'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("OTP : "+snapshot.data.docs[i].data()['OTP'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ButtonTheme(
                                            minWidth: 90,
                                            height: (width > 600) ? 45 : 35,
                                            child: MaterialButton(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                ),
                                                color: Colors.blueGrey,
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: (width > 600)
                                                          ? 15
                                                          : 12),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    blurRadius: 1,
                                                                    spreadRadius:
                                                                        1,
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            1.0))
                                                              ],
                                                            ),
                                                            width: 300,
                                                            height: 180,
                                                            child: Center(
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                  Center(
                                                                      child: Text(
                                                                    "Service Cancellation",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                                .blue[
                                                                            400],
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16),
                                                                  )),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Center(
                                                                      child: Text(
                                                                          "Do you want to cancel the Service",
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  12))),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      RaisedButton(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(18.0),
                                                                        ),
                                                                        color: Colors
                                                                                .lightBlue[
                                                                            800],
                                                                        child: Text(
                                                                            "Yes",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                        onPressed:
                                                                            () {
                                                                               _firestoreInstance.collection('SP').doc('$email').collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                            'Status' : 'History',
                                            'Cancel' : 1,
                                          }).then((_){
                                            _firestoreInstance.collection('SP').doc('$email').update({
                                            'Service' : FieldValue.increment(1),
                                            'Pending' : FieldValue.increment(-1),
                                          });
                                          });
                                          _firestoreInstance.collection('Users').doc(snapshot.data.docs[i].data()['Customer_Email']).collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                            'Status' : 'History',
                                            'Cancel' : 1
                                              }).then((_){
                                            _firestoreInstance.collection('Users').doc(snapshot.data.docs[i].data()['Customer_Email']).update({
                                            'Service' : FieldValue.increment(1),
                                            'Pending' : FieldValue.increment(-1),
                                          });
                                          } ).then((_){
                                            _firestoreInstance.collection('service').doc('details').update({
                                              'pending' : FieldValue.increment(-1),
                                              'Service' : FieldValue.increment(1),
                                            });
                                          } );
                                             Navigator.of(context).pop();
                                                                            },
                                                                      ),
                                                                      SizedBox(
                                                                        width: 20,
                                                                      ),
                                                                      RaisedButton(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(18.0),
                                                                        ),
                                                                        color: Colors
                                                                                .yellow[
                                                                            700],
                                                                        child: Text(
                                                                            "No",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                        onPressed:
                                                                            () {
                                                                                Navigator.of(context).pop();
                                                                            },
                                                                      ),
                                                                    ],
                                                                  )
                                                                ])),
                                                          ),
                                                        );
                                                      });
                                                }),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 40),
                                      Column(
                                        children: [
                                          ButtonTheme(
                                            minWidth: 90,
                                            height: (width > 600) ? 45 : 35,
                                            child: MaterialButton(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                ),
                                                color: Colors.redAccent,
                                                child: Text(
                                                  "Report",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: (width > 600)
                                                          ? 15
                                                          : 12),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    blurRadius: 1,
                                                                    spreadRadius:
                                                                        1,
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            1.0))
                                                              ],
                                                            ),
                                                            width: 300,
                                                            height: 180,
                                                            child: Center(
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                  Center(
                                                                      child: Text(
                                                                    "Service Cancellation",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                                .blue[
                                                                            400],
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16),
                                                                  )),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Center(
                                                                      child: Text(
                                                                          "Fake Service Request",
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  12))),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      RaisedButton(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(18.0),
                                                                        ),
                                                                        color: Colors
                                                                                .lightBlue[
                                                                            800],
                                                                        child: Text(
                                                                            "Yes",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                        onPressed:
                                                                            () {
                                                                               _firestoreInstance.collection('SP').doc('$email').collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                            'Status' : 'History',
                                            'Cancel' : 1,
                                          }).then((_){
                                            _firestoreInstance.collection('SP').doc('$email').update({
                                            'Service' : FieldValue.increment(1),
                                            'Pending' : FieldValue.increment(-1),
                                          });
                                          });
                                          _firestoreInstance.collection('Users').doc(snapshot.data.docs[i].data()['Customer_Email']).collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                            'Status' : 'History',
                                            
                                            'Cancel' : 1
                                              }).then((_){
                                            _firestoreInstance.collection('Users').doc(snapshot.data.docs[i].data()['Customer_Email']).update({
                                            'Service' : FieldValue.increment(1),
                                            'Pending' : FieldValue.increment(-1),
                                          });
                                          } ).then((_){
                                            _firestoreInstance.collection('service').doc('details').update({
                                              'pending' : FieldValue.increment(-1),
                                              'Service' : FieldValue.increment(1),
                                            });
                                          } ).then((_){
                                            _firestoreInstance.collection('Users').doc(snapshot.data.docs[i].data()['Customer_Email']).update({
                                              'Credibility': FieldValue.increment(-1),
                                            });
                                          });
                                             Navigator.of(context).pop();
                                                                                Navigator.of(context).pop();
                                                                            },
                                                                      ),
                                                                      SizedBox(
                                                                        width: 20,
                                                                      ),
                                                                      RaisedButton(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(18.0),
                                                                        ),
                                                                        color: Colors
                                                                                .yellow[
                                                                            700],
                                                                        child: Text(
                                                                            "No",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                        onPressed:
                                                                            () {
                                                                                Navigator.of(context).pop();
                                                                            },
                                                                      ),
                                                                    ],
                                                                  )
                                                                ])),
                                                          ),
                                                        );
                                                      });
                                                }),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 40)
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: (width > 400) ? 250 : 200),
                      ],
                    ));
                  }else
                  {
                    return Center(
                          child: Text(
                            'No pending service !',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          )
                        );
                  }
                   }
                    );
                        }}),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
