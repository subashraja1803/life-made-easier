import 'package:flutter/material.dart';
import 'package:lme_final/Screens/drawersp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert4;
import 'package:intl/intl.dart';

class Onprogresssp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return progresssp();
  }
}

class progresssp extends StatefulWidget {
  @override
  _progressspState createState() => _progressspState();
}

class _progressspState extends State<progresssp> {
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
  String formattedTime,duration,startTime;
  double totalcost;
  // Future calc(String startTime, String cost) async{
  //    DateTime now =
  //       DateTime.now();
  //   formattedTime =
  //       DateFormat('kk:mm:ss ')
  //           .format(now);
  //   // String startTime = snapshot.data.docs[i].data()['Start Time'];
  //   List<String> stsplit = startTime.split(':');
  //   List<String> etsplit = formattedTime.split(':');
  //   List<int> diff;
  //   diff[0] = int.parse(etsplit[0]) - int.parse(stsplit[0]);
  //   diff[1] = ((int.parse(etsplit[1]) - int.parse(stsplit[1]))+60)%60;
  //   diff[2] = ((int.parse(etsplit[2]) - int.parse(stsplit[2]))+60)%60;
  //   duration = diff[0].toString()+ ':'+ diff[1].toString()+':'+diff[2].toString();
  //   int diffs = (diff[0]*60*60) + (diff[1]*60) + (diff[0]);
  //   double diffc = diffs/(60.0*60.0);
      
  //   totalcost = diffc * double.parse(cost);
    
  //   print("end service");
  // } 
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
  List<int> dummylist = [1];
  Widget build(BuildContext context) {
    retrive();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: pulldrawer(context, 2),
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
                "Services  Onprogress",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                  child: StreamBuilder(
                stream: _firestoreInstance
                    .collection('SP')
                    .doc('$email')
                    .collection('Service')
                    .where('Status', isEqualTo: 'On Progress')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                                      snapshot.data.docs[i]
                                                              .data()['Brand'] +
                                                          ' ' +
                                                          snapshot.data.docs[i]
                                                                  .data()[
                                                              'Service_field'] +
                                                          ' Service',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              (width > 500)
                                                                  ? 16
                                                                  : (width > 360)?12:10),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Customer :" +
                                                        snapshot.data.docs[i]
                                                                .data()[
                                                            'Customer Name'],
                                                    style: TextStyle(
                                                        fontSize: (width > 360)
                                                            ? 14
                                                            : (width > 300)
                                                                ? 12
                                                                : 10)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Ph no : " +
                                                        snapshot.data.docs[i]
                                                            .data()[
                                                                'Customer Ph']
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
                                                Text(
                                                    "Area : " +
                                                        snapshot.data.docs[i]
                                                            .data()['Area'],
                                                    style: TextStyle(
                                                        fontSize: (width > 360)
                                                            ? 14
                                                            : (width > 300)
                                                                ? 12
                                                                : 10)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "City : " +
                                                        snapshot.data.docs[i]
                                                            .data()['City'],
                                                    style: TextStyle(
                                                        fontSize: (width > 360)
                                                            ? 14
                                                            : (width > 300)
                                                                ? 12
                                                                : 10)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Date : " +
                                                        snapshot.data.docs[i]
                                                            .data()['Date'],
                                                    style: TextStyle(
                                                        fontSize: (width > 360)
                                                            ? 14
                                                            : (width > 300)
                                                                ? 12
                                                                : 10)),
                                              ],
                                            ),
                                          ],
                                        ),
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
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  color: Colors.blueGrey,
                                                  child: Text(
                                                    "End Service",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: (width > 600)
                                                            ? 15
                                                            : 12),
                                                  ),
                                                  onPressed: () async{
                                                    //calc(snapshot.data.docs[i].data()['Start Time'],snapshot.data.docs[i].data()['CPH'].toString()).then((_){
                                                      try{
                                                        DateTime now =
                                                            DateTime.now();
                                                        formattedTime =
                                                            DateFormat('kk:mm:ss')
                                                                .format(now);
                                                                int cost1=snapshot.data.docs[i].data()['CPH'];
                                                        startTime = snapshot.data.docs[i].data()['Start Time'];
                                                        String convert,convert1;

                                                        List<String> stsplit = startTime.split(':');
                                                        List<String> etsplit = formattedTime.split(':');
                                                        List<int> diff=[0,0,0];
                                                        convert = etsplit[0];
                                                        convert1= stsplit[0];
                                            
                                                        diff[0] = int.parse(convert) - int.parse(convert1);
                                                        convert = etsplit[1];
                                                        convert1 = stsplit[1];
                                                        
                                                        diff[1] = int.parse(convert) - int.parse(convert1);
                                                        if(diff[1]<0){
                                                          diff[1]+=60;
                                                        }
                                                        duration = diff[0].toString()+ ':'+ diff[1].toString()+':'+diff[2].toString();
                                                        
                                                        int diffs = (diff[0]*60*60) + (diff[1]*60) + (diff[2]);
                                                        int cost2;
                                                        print(diffs);
                                                        if(diff[0] < 1){
                                                          cost2 = 100;
                                                        }
                                                        else{
                                                            double diffc = diffs/(60.0*60.0);
                                                                          print(diffc);             
                                                            double totalcost = diffc * 100;
                                                          print(totalcost);
                                                          
                                                            cost2 = totalcost.round();
                                                        print('$totalcost cost2 = $cost2');
                                                        }
                                                        
                                                        print('cost2 $cost2');
                                                        print("end service");
                                                    await _firestoreInstance
                                                        .collection('SP')
                                                        .doc('$email')
                                                        .collection('Service')
                                                        .doc(snapshot
                                                            .data.docs[i]
                                                            .data()[
                                                                'Service ID']
                                                            .toString())
                                                        .update({
                                                      'Status': 'History',
                                                      'End Time': formattedTime,
                                                      'Total' : cost2,
                                                      'Duration' : duration,
                                                      
                                                    }).then((_) {
                                                      _firestoreInstance
                                                          .collection('SP')
                                                          .doc('$email')
                                                          .update({
                                                        'Service': FieldValue
                                                            .increment(1),
                                                        'Progress': FieldValue
                                                            .increment(-1),
                                                      });
                                                    });
                                                    await _firestoreInstance
                                                        .collection('Users')
                                                        .doc(snapshot
                                                                .data.docs[i]
                                                                .data()[
                                                            'Customer_Email'])
                                                        .collection('Service')
                                                        .doc(snapshot
                                                            .data.docs[i]
                                                            .data()[
                                                                'Service ID']
                                                            .toString())
                                                        .update({
                                                      'Status': 'History',
                                                      'End Time': formattedTime,
                                                      'Total' : cost2,
                                                      'Duration' : duration,
                                                      'Rate' : 0,
                                                    }).then((_) {
                                                      _firestoreInstance
                                                          .collection('Users')
                                                          .doc(snapshot
                                                                  .data.docs[i]
                                                                  .data()[
                                                              'Customer_Email'])
                                                          .update({
                                                        'Service': FieldValue
                                                            .increment(1),
                                                        'Progress': FieldValue
                                                            .increment(-1),
                                                      });
                                                    }).then((_) {
                                                      _firestoreInstance
                                                          .collection('service')
                                                          .doc('details')
                                                          .update({
                                                        'progress': FieldValue
                                                            .increment(-1),
                                                        'service': FieldValue
                                                            .increment(1),
                                                      });
                                                    }).then((_)async{
                                                      try{
             final url = 'http://127.0.0.1:5000/complete';

                //sending a post request to the url
                final response = await http.post(url, body: convert4.jsonEncode({
                  'email' : snapshot.data.docs[i].data()['Customer_Email'],
                  
                  }));
              
              
          }catch(e){
            print(e);
          }
                                                    });
                                                      }catch(e){
                                                        print(e);
                                                      }
                                                    _dialogbox(
                                                        'Service Completed\nFor more details, check "History" tab');
                                                    }
                                                    
                                                    ),
                                                      
                                                  
                                                    
                                                  ),
                                            
                                          ],
                                        ),
                                        SizedBox(width: 40),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: (width < 400) ? 210 : 230),
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
              )),
            ],
          ),
        ),
      ]),
    );
  }
}
