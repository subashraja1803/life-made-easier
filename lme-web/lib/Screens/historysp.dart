import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lme_final/Screens/drawersp.dart';
import 'package:shared_preferences/shared_preferences.dart';
class historyspsl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return historyspsf();
  }
}

class historyspsf extends StatefulWidget {
  @override
  _historyspsfState createState() => _historyspsfState();
}

class _historyspsfState extends State<historyspsf> {

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



  @override
  List<int> dummylist = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  Widget build(BuildContext context) {
    retrive();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: pulldrawer(context, 1),
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
                "History of Services",
                style: TextStyle(fontSize: (width > 600) ? 24 : 18, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                child: (email == null)?CircularProgressIndicator():StreamBuilder(
                    stream: _firestoreInstance.collection('SP').doc('$email').collection('Service').where('Status', isEqualTo : 'History').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return  ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: (snapshot.data.docs.length != 0)?snapshot.data.docs.length : 1,
                  itemBuilder: (BuildContext context, int i) {
                    if(snapshot.data.docs.length != 0){
                    return Container(
                        child: (snapshot.data.docs[i].data()['Cancel'] == 1)
                        ?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(14.0),
                            shadowColor: Color(0x802196F3),
                            child: Padding(
                              padding: (width > 510)
                                  ? EdgeInsets.all(20.0)
                                  : (width > 410)
                                      ? EdgeInsets.all(10.0)
                                      : EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text('Cancelled Service',
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10,
                                                          fontWeight: FontWeight.bold
                                                          )
                                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
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
                                                        (width > 600) ? 16 : (width > 420)?12:8 ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Customer :" + snapshot.data.docs[i].data()['Customer Name'],
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Ph no : "+snapshot.data.docs[i].data()['Customer Ph'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          
                                        ],
                                      ),
                                      SizedBox(
                                        width: (width > 620)
                                            ? 200
                                            : (width > 500)
                                                ? 50
                                                : (width > 400)
                                                    ? 10
                                                    : 8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Service ID :" + snapshot.data.docs[i].data()['Service ID'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width >500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Email :" + snapshot.data.docs[i].data()['Customer_Email'],
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: (width < 400) ? 150 : 180),
                      ],
                    )
                    :(snapshot.data.docs[i].data()['Type'] == 'non-functional')?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(14.0),
                            shadowColor: Color(0x802196F3),
                            child: Padding(
                              padding: (width > 510)
                                  ? EdgeInsets.all(20.0)
                                  : (width > 410)
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
                                                        (width > 600) ? 16 : (width > 420)?12:8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Customer :" + snapshot.data.docs[i].data()['Customer Name'],
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Ph no : "+snapshot.data.docs[i].data()['Customer Ph'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          :8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          
                                        ],
                                      ),
                                      SizedBox(
                                        width: (width > 620)
                                            ? 200
                                            : (width > 500)
                                                ? 50
                                                : (width > 400)
                                                    ? 10
                                                    : 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                         Text('Service ID : '+snapshot.data.docs[i].data()['Service ID'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),Text('Area : '+snapshot.data.docs[i].data()['Area'],
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('City : '+snapshot.data.docs[i].data()['City'],
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: (width < 400) ? 150 : 180),
                      ],
                    )
                    :Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(14.0),
                            shadowColor: Color(0x802196F3),
                            child: Padding(
                              padding: (width > 510)
                                  ? EdgeInsets.all(20.0)
                                  : (width > 410)
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
                                                        (width > 600) ? 16 : (width > 400)?12:8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Customer :" + snapshot.data.docs[i].data()['Customer Name'],
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Service ID :" + snapshot.data.docs[i].data()['Service ID'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Ph no : "+snapshot.data.docs[i].data()['Customer Ph'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          
                                        ],
                                      ),
                                      SizedBox(
                                        width: (width > 620)
                                            ? 200
                                            : (width > 500)
                                                ? 50
                                                : (width > 400)
                                                    ? 10
                                                    : 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Date : "+snapshot.data.docs[i].data()['Date'].toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Duration of service(hh:mm:ss) : "+ snapshot.data.docs[i].data()['Duration'],
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Cost : "+snapshot.data.docs[i].data()['Total'].toString()+ "+external charges",
                                              style: TextStyle(
                                                  fontSize: (width > 500)
                                                      ? 14
                                                      : (width > 400)
                                                          ? 12
                                                          : 8)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: (width < 400) ? 170 : 200),
                      ],
                    ),




                    );
                    }else{
                      return Center(
                          child: Text(
                            'No service history found!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          )
                        );
                    }
                  },
                );
                        }
                    }
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
