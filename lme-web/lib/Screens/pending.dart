import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lme_final/Screens/drawer.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class pending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pendingstateful();
  }
}

class pendingstateful extends StatefulWidget {
  @override
  _pendingstatefulState createState() => _pendingstatefulState();
}

class _pendingstatefulState extends State<pendingstateful> {
  var email;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  retrive() async {
    SharedPreferences emailsp = await prefs; //.getString('email');

    setState(() {
      email = emailsp.getString('email');
    });
    // print(email);
    // print('hi from here');
  }

  Future _dialogbox(String val) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0.0, 1.0))
                ],
              ),
              width: 300,
              height: 180,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        '$val ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.lightBlue[800],
                      child: Text("OK", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        //_loginkey.currentState.reset();
                        Navigator.of(context).pop();
                        //Navigator.pushNamed(context, routeName);
                      },
                    )
                  ])),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    retrive();
    // List<int> dummylist = [1, 2];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: pulldrawer(context, 5),
      appBar: AppBar(
        title: Text(
          ' Life Made Easier',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'dashboard');
              }),
          Padding(padding: EdgeInsets.only(right: 10))
        ],
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
                child: (email == null)
                    ? CircularProgressIndicator()
                    : StreamBuilder(
                        stream: _firestoreInstance
                            .collection('Users')
                            .doc('$email')
                            .collection('Service')
                            .where('Status', isEqualTo: 'Pending')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: (snapshot.data.docs.length != 0)
                                  ? snapshot.data.docs.length
                                  : 1,
                              itemBuilder: (BuildContext context, int i) {
                                if (snapshot.data.docs.length != 0) {
                                  if (snapshot.data.docs[i].data()['Status'] ==
                                      'Pending')
                                    return Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Material(
                                            color: Colors.white,
                                            elevation: 14.0,
                                            borderRadius:
                                                BorderRadius.circular(14.0),
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                snapshot.data
                                                                            .docs[i]
                                                                            .data()[
                                                                        'Brand'] +
                                                                    ' ' +
                                                                    snapshot
                                                                        .data
                                                                        .docs[i]
                                                                        .data()['Service_field'] +
                                                                    ' Service',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: (width >
                                                                            500)
                                                                        ? 16
                                                                        : 10),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Service Provider : " +
                                                                  snapshot.data
                                                                          .docs[i]
                                                                          .data()[
                                                                      'SP_name'],
                                                              style: TextStyle(
                                                                  fontSize: (width >
                                                                          360)
                                                                      ? 14
                                                                      : (width >
                                                                              300)
                                                                          ? 12
                                                                          : 8)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Service ID : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'Service ID']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: (width >
                                                                          360)
                                                                      ? 14
                                                                      : (width >
                                                                              300)
                                                                          ? 12
                                                                          : 8)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Rating : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'Rating']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: (width >
                                                                          360)
                                                                      ? 14
                                                                      : (width >
                                                                              300)
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
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Phone no: " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'SP_ph']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: (width >
                                                                          360)
                                                                      ? 14
                                                                      : (width >
                                                                              300)
                                                                          ? 12
                                                                          : 10)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Years of Experience : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'YOE']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: (width >
                                                                          360)
                                                                      ? 14
                                                                      : (width >
                                                                              300)
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
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text("OTP :",
                                                                  style: TextStyle(
                                                                      fontSize: (width > 360)
                                                                          ? 14
                                                                          : (width > 300)
                                                                              ? 12
                                                                              : 10)),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                width: 200,
                                                                child:
                                                                    OTPTextField(
                                                                  length: 4,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  textFieldAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  fieldWidth:
                                                                      20,
                                                                  fieldStyle:
                                                                      FieldStyle
                                                                          .underline,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                  onCompleted:
                                                                      (pin) {
                                                                    print(snapshot
                                                                        .data
                                                                        .docs[i]
                                                                        .data()['OTP']);
                                                                    print(
                                                                        "Completed: " +
                                                                            pin);
                                                                    DateTime
                                                                        now =
                                                                        DateTime
                                                                            .now();
                                                                    String
                                                                        formattedTime =
                                                                        DateFormat('kk:mm:ss ')
                                                                            .format(now);
                                                                    print(
                                                                        formattedTime);
                                                                    String
                                                                        formattedDate =
                                                                        DateFormat('yMMMMd')
                                                                            .format(now);
                                                                    print(
                                                                        formattedDate);
                                                                    if (snapshot
                                                                            .data
                                                                            .docs[i]
                                                                            .data()['OTP']
                                                                            .toString() ==
                                                                        pin) {
                                                                      _firestoreInstance
                                                                          .collection(
                                                                              'Users')
                                                                          .doc(
                                                                              '$email')
                                                                          .collection(
                                                                              'Service')
                                                                          .doc(snapshot
                                                                              .data
                                                                              .docs[i]
                                                                              .data()['Service ID']
                                                                              .toString())
                                                                          .update({
                                                                        'Status':
                                                                            'On Progress',
                                                                        'Start Time':
                                                                            formattedTime,
                                                                        'Date':
                                                                            formattedDate,
                                                                      }).then((_) {
                                                                        _firestoreInstance
                                                                            .collection('Users')
                                                                            .doc('$email')
                                                                            .update({
                                                                          'Progress':
                                                                              FieldValue.increment(1),
                                                                          'Pending':
                                                                              FieldValue.increment(-1),
                                                                        });
                                                                      });
                                                                      _firestoreInstance
                                                                          .collection(
                                                                              'SP')
                                                                          .doc(snapshot.data.docs[i].data()[
                                                                              'SP_Email'])
                                                                          .collection(
                                                                              'Service')
                                                                          .doc(snapshot
                                                                              .data
                                                                              .docs[i]
                                                                              .data()['Service ID']
                                                                              .toString())
                                                                          .update({
                                                                        'Status':
                                                                            'On Progress',
                                                                        'Start Time':
                                                                            formattedTime,
                                                                        'Date':
                                                                            formattedDate,
                                                                      }).then((_) {
                                                                        _firestoreInstance
                                                                            .collection('SP')
                                                                            .doc(snapshot.data.docs[i].data()['SP_Email'])
                                                                            .update({
                                                                          'Progress':
                                                                              FieldValue.increment(1),
                                                                          'Pending':
                                                                              FieldValue.increment(-1),
                                                                        });
                                                                      }).then((_) {
                                                                        _firestoreInstance
                                                                            .collection('service')
                                                                            .doc('details')
                                                                            .update({
                                                                          'pending':
                                                                              FieldValue.increment(-1),
                                                                          'progress':
                                                                              FieldValue.increment(1),
                                                                        });
                                                                      }).then((_)async{
                                                                         try{
             final url = 'http://127.0.0.1:5000/progress';

                //sending a post request to the url
                final response = await http.post(url, body: convert.jsonEncode({
                  'name' : snapshot.data.docs[i].data()['SP_name'],
                  'email' : email,
                  'ph_no' : snapshot.data.docs[i].data()['SP_ph'],
                  }));
              
              
          }catch(e){
            print(e);
          }
                                                                      });
                                                                      _dialogbox(
                                                                          'Your Service is on progress\nFor more details, check "On Progress" tab');
                                                                    } else {
                                                                      _dialogbox(
                                                                          'Invalid OTP\nPlease verify the OTP');
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          width: (width > 620)
                                                              ? 175
                                                              : (width > 500)
                                                                  ? 85
                                                                  : 0),
                                                      (width > 500)
                                                          ? Column(
                                                              children: [
                                                                ButtonTheme(
                                                                  minWidth: 90,
                                                                  height: 45,
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
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      onPressed: () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topLeft: Radius.circular(10.0),
                                                                                      topRight: Radius.circular(10.0),
                                                                                      bottomLeft: Radius.circular(10.0),
                                                                                      bottomRight: Radius.circular(10.0),
                                                                                    ),
                                                                                    boxShadow: [
                                                                                      BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1, offset: Offset(0.0, 1.0))
                                                                                    ],
                                                                                  ),
                                                                                  width: 300,
                                                                                  height: 180,
                                                                                  child: Center(
                                                                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                    Center(
                                                                                        child: Text(
                                                                                      "Service Cancellation",
                                                                                      style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold, fontSize: 16),
                                                                                    )),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Center(child: Text("Do you want to cancel the Service", style: TextStyle(fontSize: 12))),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        RaisedButton(
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(18.0),
                                                                                          ),
                                                                                          color: Colors.lightBlue[800],
                                                                                          child: Text("Yes", style: TextStyle(color: Colors.white)),
                                                                                          onPressed: () {
                                                                                            _firestoreInstance.collection('Users').doc('$email').collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                                                                              'Status': 'History',
                                                                                              'Cancel': 1,
                                                                                            }).then((_) {
                                                                                              _firestoreInstance.collection('Users').doc('$email').update({
                                                                                                'Service': FieldValue.increment(1),
                                                                                                'Pending': FieldValue.increment(-1),
                                                                                              });
                                                                                            });
                                                                                            _firestoreInstance.collection('SP').doc(snapshot.data.docs[i].data()['SP_Email']).collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                                                                              'Status': 'History',
                                                                                              'Cancel': 1
                                                                                            }).then((_) {
                                                                                              _firestoreInstance.collection('SP').doc(snapshot.data.docs[i].data()['SP_Email']).update({
                                                                                                'Service': FieldValue.increment(1),
                                                                                                'Pending': FieldValue.increment(-1),
                                                                                              });
                                                                                            }).then((_) {
                                                                                              _firestoreInstance.collection('service').doc('details').update({
                                                                                                'pending': FieldValue.increment(-1),
                                                                                                'Service': FieldValue.increment(1),
                                                                                              });
                                                                                            });

                                                                                            Navigator.of(context).pop();
                                                                                          },
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 20,
                                                                                        ),
                                                                                        RaisedButton(
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(18.0),
                                                                                          ),
                                                                                          color: Colors.yellow[700],
                                                                                          child: Text("No", style: TextStyle(color: Colors.white)),
                                                                                          onPressed: () {
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
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                  (width > 500)
                                                      ? Container()
                                                      : SizedBox(
                                                          height: 20,
                                                        ),
                                                  (width > 500)
                                                      ? Container()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ButtonTheme(
                                                              minWidth: 90,
                                                              height: 35,
                                                              child:
                                                                  MaterialButton(
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0),
                                                                      ),
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      child:
                                                                          Text(
                                                                        "Cancel",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 12),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topLeft: Radius.circular(10.0),
                                                                                      topRight: Radius.circular(10.0),
                                                                                      bottomLeft: Radius.circular(10.0),
                                                                                      bottomRight: Radius.circular(10.0),
                                                                                    ),
                                                                                    boxShadow: [
                                                                                      BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1, offset: Offset(0.0, 1.0))
                                                                                    ],
                                                                                  ),
                                                                                  width: 300,
                                                                                  height: 180,
                                                                                  child: Center(
                                                                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                    Center(
                                                                                        child: Text(
                                                                                      "Service Cancellation",
                                                                                      style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold, fontSize: 16),
                                                                                    )),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Center(child: Text("Do you want to cancel the Service", style: TextStyle(fontSize: 12))),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        RaisedButton(
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(18.0),
                                                                                          ),
                                                                                          color: Colors.lightBlue[800],
                                                                                          child: Text("Yes", style: TextStyle(color: Colors.white)),
                                                                                          onPressed: () {
                                                                                            _firestoreInstance.collection('Users').doc('$email').collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                                                                              'Status': 'History',
                                                                                              'Cancel': 1,
                                                                                            }).then((_) {
                                                                                              _firestoreInstance.collection('Users').doc('$email').update({
                                                                                                'Service': FieldValue.increment(1),
                                                                                                'Pending': FieldValue.increment(-1),
                                                                                              });
                                                                                            });
                                                                                            _firestoreInstance.collection('SP').doc(snapshot.data.docs[i].data()['SP_Email']).collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                                                                              'Status': 'History',
                                                                                              'Cancel': 1
                                                                                            }).then((_) {
                                                                                              _firestoreInstance.collection('SP').doc(snapshot.data.docs[i].data()['SP_Email']).update({
                                                                                                'Service': FieldValue.increment(1),
                                                                                                'Pending': FieldValue.increment(-1),
                                                                                              });
                                                                                            }).then((_) {
                                                                                              _firestoreInstance.collection('service').doc('details').update({
                                                                                                'pending': FieldValue.increment(-1),
                                                                                                'Service': FieldValue.increment(1),
                                                                                              });
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                          },
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 20,
                                                                                        ),
                                                                                        RaisedButton(
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(18.0),
                                                                                          ),
                                                                                          color: Colors.yellow[700],
                                                                                          child: Text("No", style: TextStyle(color: Colors.white)),
                                                                                          onPressed: () {
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
                                                ],
                                              ),
                                            )),
                                        SizedBox(height: 250),
                                      ],
                                    ));
                                } else {
                                  return Center(
                                      child: Text(
                                    'No pending service !',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ));
                                }
                                return null;
                              },
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
