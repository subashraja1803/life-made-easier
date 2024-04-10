import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class ReportScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReportScreen(),
    );
  }
}
class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}



class _ReportScreenState extends State<ReportScreen> {

  var name;
  var email,detail,service_id;
  final _firestoreInstance = Firestore.instance;
  var hello='hello';
  void initState() {
    super.initState();
    retrive().then((_){
      create(); 
    });     
  }
  create() async{
    var pr = _firestoreInstance.collection('Report').doc('$email').set({'Service ID': ''});
    print('from create');
  }
 getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('email');
    return stringValue;
  }

  Future retrive() async {
    email = await getValue() ?? "";
    print(email);
    print('hi from here');
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
  // ignore: missing_return
  void uploadToStorage() {
    final path = '$email/Report';
    uploadImage(onSelected: (file) {
      fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child(path)
        .put(file).future.then((_){
                    _firestoreInstance.collection('Report').doc('$email').update({'Report' : path});
                    print(path);
                    Toast.show("Report image has been uploaded", context, duration: 3, gravity:  Toast.BOTTOM);

        });
    });
  }



  
flask_connect() async{
  
}







  @override
  Widget report(double width,double height){
    
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
                children: [
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
                            decoration: InputDecoration(
                              labelText: "Service ID",
                            ),
                            onChanged: (value){
                              service_id = value;
                              _firestoreInstance.collection('Report').doc('$email').update({'Service ID' : service_id});
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Service Provider's Name",
                            ),
                            onChanged: (value){
                              name = value;
                              _firestoreInstance.collection('Report').doc('$email').update({'SP Name' : name});
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.name,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "Report",
                            ),
                            onChanged: (value){
                              detail = value;
                              _firestoreInstance.collection('Report').doc('$email').update({'Details' : detail});
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.name,
                            onChanged: (value){
                              
                            },
                            decoration: InputDecoration(
                                hintText: "Upload image if any",
                                labelText: "Image",
                                suffixIcon: TextButton(
                                  child: Text("Upload"),
                                  onPressed: () {
                                    uploadToStorage();
                                  },
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
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
                                  Navigator.pushNamed(context, 'userhome');
                                }),
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
                                  'hello',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async{
                                try{
                 // _savingData();

                //url to send the post request to 
                final url = 'http://127.0.0.1:5000/name';

                //sending a post request to the url
                final response = await http.post(url, body: convert.jsonEncode({
                  'name' : name,
                  'email' : email,
                  'detail' : detail,
                  }));
                }
                catch(e)
                {
                  print(e);
                }
                Navigator.pushNamed(context, 'userhome');
                _dialogbox('Report has been filed successfully');
                               }),
                          ),
                          // Text(hello),
                        ],
                      ),
                    ),
                  ),
                ],
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
        child: report(_width, _height),
      ),
    );
  }
}