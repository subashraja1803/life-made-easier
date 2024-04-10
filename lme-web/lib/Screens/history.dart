import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:lme_final/Screens/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class history extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return history1();
  }
}

class history1 extends StatefulWidget {
  @override
  _history1State createState() => _history1State();
}

class _history1State extends State<history1> {
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
  List<int> dummylist = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  Widget build(BuildContext context) {
    retrive();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: pulldrawer(context, 1),
      appBar: AppBar(
        title: Text(
          ' Life Made Easier',
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
                            .where('Status', isEqualTo: 'History')
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
                              padding: (width > 410)
                                  ? EdgeInsets.all(20.0)
                                  : (width > 310)
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
                                                          fontWeight: FontWeight.bold,
                                                          )),
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
                                                        (width > 360) ? 12 : 10),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Service Provider : " +
                                                                  snapshot.data
                                                                          .docs[i]
                                                                          .data()[
                                                                      'SP_name'],
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Phone no: " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'SP_ph']
                                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize:  (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          
                                        ],
                                      ),
                                      SizedBox(
                                        width: (width > 620)
                                            ? 200
                                            : (width > 500)
                                                ? 100
                                                : (width > 400)
                                                    ? 30
                                                    : 10,
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
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Email :" + snapshot.data.docs[i].data()['SP_Email'],
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
                                ],
                              ),
                            )),
                        SizedBox(height: (width < 400) ? 150 : 180),
                      ],
                    )
                    :(snapshot.data.docs[i].data()['Type'] == 'non-functional')?
                    Row(
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
                                  Text(
                                    'Non Functional Service',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        (width > 360) ? 16 : 14,
                                                      
                                                        ),
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
                                                        (width > 360) ? 16 : 14),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Service Provider : "+snapshot.data
                                                                          .docs[i]
                                                                          .data()[
                                                                      'SP_name'],
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          
                                          Text("Rating : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'Rating']
                                                                      .toString(),
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
                                          Text("Service ID : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'Service ID']
                                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: (width > 360)
                                                      ? 14
                                                      : (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Ph.no : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'SP_ph']
                                                                      .toString(),
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
                                  (snapshot.data.docs[i].data()['Rate'] == 0)?
                                  Center(
                                      child: SmoothStarRating(
                                    isReadOnly: false,
                                    size: 30,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: true,
                                    spacing: 2.0,
                                    onRated: (value) async{
                                      print("rating value -> $value");
                                      await _firestoreInstance.collection('Users').doc('$email').collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                        'Rate' : value,
                                      }).then((_){
                                        double rating = snapshot.data.docs[i].data()['Rating'];
                                        double calrate = (value + rating)/2;
                                        
                                        //if(calrate < 0){calrate = calrate * (-1) ; }
                                        //calrate = double.parse((calrate).toStringAsFixed(1));
                                        _firestoreInstance.collection('SP').doc(snapshot.data.docs[i].data()['SP_Email']).update({
                                          'Rating' : calrate,
                                        });
                                      });
                                      // print("rating value dd -> ${value.truncate()}");
                                    },
                                  )):Container(),
                                ],
                              ),
                            )),
                        SizedBox(height: (snapshot.data.docs[i].data()['Rate'] == 0)?210:180),
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
                                                        (width > 360) ? 14 : 12),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Service Provider : "+snapshot.data
                                                                          .docs[i]
                                                                          .data()[
                                                                      'SP_name'],
                                              style: TextStyle(
                                                  fontSize:(width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Service ID : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'Service ID']
                                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize:  (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Rating : " +
                                                                  snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                          'Rating']
                                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize:  (width > 300)
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
                                                    ? 20
                                                    : 10,
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
                                                  fontSize:  (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Duration of service : "+snapshot.data.docs[i].data()['Duration'],
                                              style: TextStyle(
                                                  fontSize:  (width > 300)
                                                          ? 12
                                                          : 10)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Cost : "+snapshot.data.docs[i].data()['Total'].toString()+ "+ External charges",
                                              style: TextStyle(
                                                  fontSize:  (width > 300)
                                                          ? 12
                                                          : 10)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  (snapshot.data.docs[i].data()['Rate'] == 0)?
                                  Center(
                                      child: SmoothStarRating(
                                    isReadOnly: false,
                                    size: 30,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: true,
                                    spacing: 2.0,
                                    onRated: (value) async{
                                      print("rating value -> $value");
                                      try{
                                        await _firestoreInstance.collection('Users').doc('$email').collection('Service').doc(snapshot.data.docs[i].data()['Service ID'].toString()).update({
                                        'Rate' : value,
                                      }).then((_){
                                        double rating = snapshot.data.docs[i].data()['Rating'];
                                        double calrate = (value + rating)/2;
                                        //if(calrate < 0){calrate = calrate * (-1) ; }
                                        calrate = double.parse((calrate).toStringAsFixed(1));
                                        print(calrate);
                                        _firestoreInstance.collection('SP').doc(snapshot.data.docs[i].data()['SP_Email']).update({
                                          'Rating' : calrate,
                                        });
                                      });
                                      }catch(e){
                                        print(e);
                                      }
                                      // print("rating value dd -> ${value.truncate()}");
                                    },
                                  )):Container(),
                                ],
                              ),
                            )),
                        SizedBox(height: (snapshot.data.docs[i].data()['Rate'] == 0)?210:180),
                      ],
                    ),
                    
                    
                    );
                    }
                    else{
                       return Center(
                                      child: Text(
                                    'No service history available!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ));
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
