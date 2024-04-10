import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'drawer.dart';

class onprogress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return progress();
  }
}

class progress extends StatefulWidget {
  @override
  _progressState createState() => _progressState();
}

class _progressState extends State<progress> {
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

  @override
  List<int> dummylist = [1];
  Widget build(BuildContext context) {
    retrive();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: pulldrawer(context, 2),
      appBar: AppBar(
        title: Text(
          ' Life Made Easier ',
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
                "Services Onprogress",
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
                            .where('Status', isEqualTo: 'On Progress')
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
                                  return Container(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                                  snapshot.data
                                                                          .docs[i]
                                                                          .data()[
                                                                      'Service_field'] +
                                                                  ' Service',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      (width >
                                                                              500)
                                                                          ? 16
                                                                          : (width > 360)?12:10),
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
                                                                        : 10)),
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
                                                                        : 10)),
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
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                          height: (width < 400) ? 150 : 180),
                                    ],
                                  ));
                                } else {
                                  return Center(
                                      child: Text(
                                    'No services On Progress !',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ));
                                }
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
