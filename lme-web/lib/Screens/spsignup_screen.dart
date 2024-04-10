import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
class SpsignupScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpsignupScreen(),
    );
  }
}

class SpsignupScreen extends StatefulWidget {
  @override
  _SpsignupScreenState createState() => _SpsignupScreenState();
}

class _SpsignupScreenState extends State<SpsignupScreen> {
  var name, age, address, ph, password,url,city,area,yoe,field,type,id;
  var email;
  final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
  void initState() {
    super.initState();
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
    final path = '$email/Aadhaar';
    uploadImage(onSelected: (file) {
      fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child(path)
        .put(file).future.then((_){
                    _firestoreInstance.collection('SP').doc('$email').set({'Aadhaar' : path});
                    print(path);
                    Toast.show("Aadhar card has been uploaded", context, duration: 3, gravity:  Toast.BOTTOM);

        });
    });
  }

  @override
  Widget signup(double width, double height) {
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
                          EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
                              labelText: "Name",
                            ),
                            onChanged: (value){
                              name = value;
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Age",
                            ),
                            onChanged: (value){
                              age = value;
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              labelText: "Address",
                            ),
                            onChanged: (value){
                              address = value;
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              labelText: "City",
                            ),
                            onChanged: (value){
                              city = value.toLowerCase();
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              labelText: "Area",
                            ),
                            onChanged: (value){
                              area = value.toLowerCase();
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Phone No.",
                            ),
                            onChanged: (value){
                              ph = value;
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Years of Experience",
                            ),
                            onChanged: (value){
                              yoe = value;
                            },
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                           
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              
            },
            decoration: InputDecoration(
                hintText: "Upload your Aadhaar card",
                labelText: "Aadhar card",
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
                                  try {
                                    print(password);
                                    _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                  } catch (e) {
                                    Navigator.pushNamed(context, 'verify');
                                  }
                                  _firestoreInstance.collection('SP').doc('$email').update({
                                        'Email' : email,
                                        'Name' : name,
                                        'Age' : age,
                                        'Address' : address,
                                        'Phone no' : ph,
                                        'City' : city,
                                        'Area' : area,
                                        'Rating' : 5,
                                        'Recent' : 5,
                                        
                                        'YOE' : yoe,
                                        'Pending' : 0,
                                        'Progress' : 0,
                                        'Service' : 0,
                                        //'Type' : type,

                                      });
                                  Navigator.pushNamed(context, 'login');
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              /*Row(
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
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
                        'Aadhar Card',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'ZillaSlab',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                     
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              */
            ],
          ),
        ],
      ),
    );
  }

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
        child: signup(_width, _height),
      ),
    );
  }
}
