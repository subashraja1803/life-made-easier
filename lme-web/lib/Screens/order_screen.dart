import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:lme_final/Screens/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class OrderScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OrderScreen(),
    )
  ;
  }
}
class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}
enum rad{Brand,Local}
class _OrderScreenState extends State<OrderScreen> {
    rad bol;
    var id,id1,rand;
    var random = new Random();
    
    bool error=false,functional=true,nonf=false;
    var name,door,city,area,service_field,brand,detail,email;
      // ignore: deprecated_member_use
      final _firestoreInstance = Firestore.instance;
    registration() async{
      
      var sp_id;
      print(city);
      print(area);
      print(brand);
      print(service_field);
      int min = 1000; //min and max values act as your 6 digit range
      int max = 9999;
      var rand1 = new Random(); 
      var rNum = min + rand1.nextInt(max - min);
      //.orderBy('Rating',descending: true).orderBy('Recent',descending: true)
      DocumentSnapshot sp_query,sp_query1,query1,query2;
      if(functional)
      {
        try{
        
      var msg =await _firestoreInstance.collection('SP').where('City', isEqualTo : '$city').where('Service_field', isEqualTo : '$service_field').where('Brand', isEqualTo : '$brand').orderBy('Rating',descending: true).orderBy('Recent',descending: true).get().then((value) {
        //print(value.size);
        if(value.size == 0)
        {
          print("none");
          _dialogbox('Service not found');
        }
        sp_id = value.docs[0].id;
        sp_query = value.docs[0];
        for(var i=0;i<value.size;i++)
        {
          if(value.docs[i].data()['Area']==area)
          {
            sp_id = value.docs[i].id;
            sp_query = value.docs[i];
          print(sp_id+'in for');
          break;
          }
        }
        
        print(sp_id);
      
      }).then((_){
        _firestoreInstance.collection('Users').doc('$email').collection('Service').doc('$rand').update({
        'Service ID' : rand,
        'City' : city,
        'Area' : area,
        'Rating' : sp_query.data()['Rating'],
        'Brand' : brand,
        'Service_field' : service_field,
        'YOE' : sp_query.data()['YOE'],
        'SP_ph' : sp_query.data()['Phone no'],
        'SP_name' : sp_query.data()['Name'],
        'OTP' : rNum,
        'Status' : 'Pending',
        'Cancel' : 0,
        'SP_Email' : sp_id,
        'CPH' : sp_query.data()['CPH'],
        'Type' : sp_query.data()['Type'],
        'Rate' : 0,
      });
      _firestoreInstance.collection('Users').doc('$email').get().then((value){
        query1 = value;

      }).then((_){
        _firestoreInstance.collection('SP').doc('$sp_id').collection('Service').doc('$rand').set({
        'Service ID' : rand,
        'City' : city,
        'Area' : area,
        'Brand' : brand,
        'Service_field' : service_field,
        'OTP' : rNum,
        'Customer Ph' : query1.data()['Phone no'],
        'Customer Name' : query1.data()['Name'],
        'Status' : 'Pending',
        'Cancel' : 0,
        'Customer_Email' : email,
        'CPH' : sp_query.data()['CPH'],
        'Type' : sp_query.data()['Type'],
      });
      });
      }).then((_) {
        _firestoreInstance.collection('service').doc('details').update({
          'pending' : FieldValue.increment(1),
        });
      }).then((_){
        _firestoreInstance.collection('SP').doc('$sp_id').update({
          'Pending' : FieldValue.increment(1),
        });
      } ).then((_){
        _firestoreInstance.collection('Users').doc('$email').update({
          'Pending' : FieldValue.increment(1),
        });
      }).then((_)async{
         try{
             final url = 'http://127.0.0.1:5000/allotment';
print(sp_id);
print(email);
// print(query1.data()['Name']);
// print(query1.data()['Phone no']);
                //sending a post request to the url
                final response = await http.post(url, body: convert.jsonEncode({
                  
                  
                  'email' : sp_id,
                  }));
              

          }catch(e){
            print(e);
          }
      });
        _dialogbox('Service Alloted\nRefer "Pending" for more details \nService ID : $rand \nNote this ID for future use');
      
      
  }catch(e){
        print(e);
      }
      }
      else{
        try{
          var nfrand = random.nextInt(999999);
          var msg =await _firestoreInstance.collection('SP').where('City', isEqualTo : '$city').where('Service_field', isEqualTo : '$service_field').where('Brand', isEqualTo : '$brand').orderBy('Rating',descending: true).orderBy('Recent',descending: true).get().then((value) {
          if(value.size == 0)
        {
          print("none");
          _dialogbox('Service not found');
        }
        sp_id = value.docs[0].id;
        sp_query1 = value.docs[0];
        for(var i=0;i<value.size;i++)
        {
          if(value.docs[i].data()['Area']==area)
          {
            sp_id = value.docs[i].id;
            sp_query1 = value.docs[i];
          print(sp_id+'in for');
          break;
          }
        }
        
        print(sp_id);
      
        }).then((_) {
          _firestoreInstance.collection('Users').doc('$email').collection('Service').doc('$nfrand').set({
        'Service ID' : nfrand,
        'City' : city,
        'Area' : area,
        'Rating' : sp_query1.data()['Rating'],
        'Brand' : brand,
        'Service_field' : service_field,
        'SP_ph' : sp_query1.data()['Phone no'],
        'SP_Email' : sp_id,
        'SP_name' : sp_query1.data()['Name'],
        'Status' : 'History',
        'Type' : sp_query1.data()['Type'],
        'Rate' : 0,
      }).then((_) {
        _firestoreInstance.collection('Users').doc('$email').get().then((value){
        query2 = value;

      }).then((_){
        _firestoreInstance.collection('SP').doc('$sp_id').collection('Service').doc('$nfrand').set({
        'Service ID' : nfrand,
        'City' : city,
        'Area' : area,
        'Brand' : brand,
        'Service_field' : service_field,
        'Customer Ph' : query2.data()['Phone no'],
        'Customer Name' : query2.data()['Name'],
        'Status' : 'History',
        'Type' : sp_query1.data()['Type'],
      });
      });
      });
        }).then((_) {
           _firestoreInstance.collection('service').doc('details').update({
          'service' : FieldValue.increment(1),
        });
        }).then((_){
           _firestoreInstance.collection('Users').doc('$email').update({
          'Service' : FieldValue.increment(1),
        });
        }).then((_) {
           _firestoreInstance.collection('SP').doc('$sp_id').update({
          'Service' : FieldValue.increment(1),
        });
        }).then((_)async{
          try{
             final url = 'http://127.0.0.1:5000/allotment';

                //sending a post request to the url
                final response = await http.post(url, body: convert.jsonEncode({
                  'name' : query2.data()['Name'],
                  'email' : sp_id,
                  'ph_no' : query2.data()['Phone no'],
                  }));
              

          }catch(e){
            print(e);
          }
        });
        _dialogbox('Service Alloted\nRefer "History" for more details \nService ID : $nfrand \nNote this ID for future use');
        }catch(e)
        {
          print(e);
        }
      }
      
      
    }
    
  List<String> Brand=['Samsung','Whirpool','Cropmton'];
  void uploadImage({@required Function(File file) onSelected}){
    InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event){
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event){
        onSelected(file);
        //return true;
      });
      
    });
  }
  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('email');
    return stringValue;
  }

  void retrive() async {
    email = await getValue() ?? "";
    print(email);
    print('hi from here');
  }
  void ServiceImg() {
    final path = '$email/Service';
    rand = random.nextInt(999999);
    print(rand);
    uploadImage(onSelected: (file) {
      fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child(path)
        .put(file).future.then((_){
                    _firestoreInstance.collection('Users').doc('$email').collection('Service').doc('$rand').set({'ServiceImg' : path});
                    print(path);
                    Toast.show("ID has been uploaded", context, duration: 3, gravity:  Toast.BOTTOM);

        });
    });
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
                        child: Text('$val ',
                                style: TextStyle(fontSize: 15,),
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
                  ]
                )
              ),
            ),
          );
        }
      );
    }



  @override
  Widget order(double width, double height){
    retrive();
    return Container(
      child: ListView(
        children: [
          SizedBox(
            height: (height > 600) ? height * 0.15 : height * 0.08,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: (width > 1100)
                ? width * 0.20
                : (width > 600)
                    ? width * 0.29
                    : (width - 100) * 0.5,
                child: ButtonTheme(
              //minWidth: (width - 550) / 2,
              height: 50.0,
              buttonColor: functional
                  ? Color.fromRGBO(255, 255, 255, 0.8)
                  : Colors.grey[350],
              // ignore: deprecated_member_use
              child: RaisedButton(
                elevation: functional ? 0 : 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Functional Service",
                      style: TextStyle(
                          fontSize: (width > 700)
                              ? 20
                              : (width > 450)
                                  ? 15
                                  : 10,
                          color: Color.fromRGBO(45, 109, 120, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Segoe UI'),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    functional = true;
                    nonf = false;
                  });
                },
              ),
                ),
              ),
              Container(
                width: (width > 1100)
                ? width * 0.20
                : (width > 600)
                    ? width * 0.29
                    : (width - 100) * 0.5,
                child: ButtonTheme(
              //minWidth: (width - 550) / 2,
              height: 50.0,
              buttonColor: nonf
                  ? Color.fromRGBO(255, 255, 255, 0.8)
                  : Colors.grey[350],
              // ignore: deprecated_member_use
              child: RaisedButton(
                elevation: nonf ? 0 : 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.handyman),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Non-functional Service",
                      style: TextStyle(
                          fontSize: (width > 700)
                              ? 20
                              : (width > 450)
                                  ? 15
                                  : 10,
                          color: Color.fromRGBO(113, 110, 109, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Segoe UI'),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    functional = false;
                    nonf = true;
                  });
                },
              ),
                ),
              ),
            ],
          ),


          SizedBox(
            height: 3.0,
          ),
                functional ? Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Container(
                  width: (width > 1100)
                      ? width * 0.40
                      : (width > 600)
                          ? width * 0.58
                          : width - 100,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                      children: [
                        Text(
                          'Which one do you prefer ?',
                          style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'ZillaSlab',
                          fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        ListTile(  
                        title: Text('Brand'),  
                        leading: Radio(    
                          groupValue: bol, 
                          value: rad.Brand, 
                          onChanged: (rad value) {  
                            setState(() {  
                              bol= value;
                              id=1;  
                            });  
                          },   
                        ),  
                      ),  
                        ListTile(  
                          title: Text('Local'),  
                          leading: Radio(    
                            groupValue: bol,
                            value: rad.Local, 
                            onChanged: (rad value) {  
                              setState(() {  
                                bol= value; 
                                id=2; 
                              });  
                            },  
                          ),  
                        ),
                        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              door = value;
            },
            decoration: InputDecoration(
                hintText: "",
                labelText: "Door No",
              )
          ),
                        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              area = value.toLowerCase();
            },
            decoration: InputDecoration(
                hintText: "",
                labelText: "Area",
              )
          ),
          TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              city = value.toLowerCase();
            },
            decoration: InputDecoration(
                hintText: "",
                labelText: "City",
              )
          ),
                        Container(
          padding: EdgeInsets.only(right: 15),
          child: DropdownButtonFormField<String>(
              isExpanded: true,
              hint: Text("Service",
                  style: TextStyle(color: Colors.black)),
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none),
              
              items: (id==2)?<String>[
                'Electrician',
                'Plumber',
                'Carpenter',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList():<String>[
                'Refridgerator',
                'Microwave Oven',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value){
                service_field = value;
                if(id==2){
                  brand = 'General';
                }
              },
              ),
    
        ),
        (id==1)?Container(
          padding: EdgeInsets.only(right: 15),
          child: DropdownButtonFormField<String>(
              isExpanded: true,
              hint: Text("Brand",
                  style: TextStyle(color: Colors.black)),
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none),
              
              items: Brand.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value){
                brand = value;
              },
              ),
        ):Container(),
         TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    maxLines: 5,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      detail = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Details',
                      labelStyle: TextStyle( color: Colors.black,fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.brown[700], width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.brown[700], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              
            },
            decoration: InputDecoration(
                hintText: "Service related image if any",
                labelText: "Image",
                suffixIcon: TextButton(
                  child: Text("Upload"),
                  onPressed: () {
                    
                    ServiceImg();
                    
                    }
                  
                )),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
                            minWidth: 100,
                            height: 40,
                            child: MaterialButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: Colors.indigo[500],
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  print('hello');
                                  registration();
                                  Navigator.pushNamed(context, 'order');
                                }),
                          ),
                      ]
         
                  ),
                ),
              )
              :
              
              
              
              
              Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Container(
                  width: (width > 1100)
                      ? width * 0.40
                      : (width > 600)
                          ? width * 0.58
                          : width - 100,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                      children: [
                        
                        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              door = value;
            },
            decoration: InputDecoration(
                hintText: "",
                labelText: "Door No",
              )
          ),
                        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              area = value.toLowerCase();
            },
            decoration: InputDecoration(
                hintText: "",
                labelText: "Area",
              )
          ),
          TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              city = value.toLowerCase();
            },
            decoration: InputDecoration(
                hintText: "",
                labelText: "City",
              )
          ),
                        Container(
          padding: EdgeInsets.only(right: 15),
          child: DropdownButtonFormField<String>(
              isExpanded: true,
              hint: Text("Service",
                  style: TextStyle(color: Colors.black)),
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none),
             
              items: <String>[
                'Newspaper',
                'Milk Delivery',
                'Ration',
                'Medicine'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value){
                service_field = value;
                brand = 'General';
              },
              ),
        ),
        
         TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    maxLines: 5,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      
                    },
                    decoration: InputDecoration(
                      labelText: 'Details',
                      labelStyle: TextStyle( color: Colors.black,fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.brown[700], width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.brown[700], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
        
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
                            minWidth: 100,
                            height: 40,
                            child: MaterialButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: Colors.indigo[500],
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  print('hello');
                                  registration();
                                  
                                  Navigator.pushNamed(context, 'order');
                                }),
                          ),
                      ]
         
                  ),
                ),
              ),
            ],
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
      drawer: pulldrawer(context, 7),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'dashboard');
              }),
        ],
        title: Text(
          '   Life Made Easier',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange[400],
      ),
      body: Container(
        child: order(_width, _height),
      ),
    );
  }
}
    