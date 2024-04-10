import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
class SpverifyScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpverifyScreen(),
    );
  }
}
class SpverifyScreen extends StatefulWidget {
  @override
  _SpverifyScreenState createState() => _SpverifyScreenState();
}
 enum rad{Brand,Local} 
class _SpverifyScreenState extends State<SpverifyScreen> {
  rad bol;
  var email,brand,id,refname,refph,type,service_field,id1; int cph;
   // ignore: deprecated_member_use
   final _firestoreInstance = Firestore.instance;
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
  List<String> Local=['General'];
  List<String> Brand=['Samsung','Whirpool','Cropmton'];
      // ignore: missing_return
  void Id() {
    final path = '$email/Id';
    uploadImage(onSelected: (file) {
      fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child(path)
        .put(file).future.then((_){
                    _firestoreInstance.collection('SP').doc('$email').update({'Id' : path});
                    print(path);
                    Toast.show("ID has been uploaded", context, duration: 3, gravity:  Toast.BOTTOM);

        });
    });
  }
  void certificate() {
    final path = '$email/Certificate';
    uploadImage(onSelected: (file) {
      fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child(path)
        .put(file).future.then((_){
                    _firestoreInstance.collection('SP').doc('$email').update({'Certificate' : path});
                    print(path);
                    Toast.show("Certificate has been uploaded", context, duration: 3, gravity:  Toast.BOTTOM);

        });
    });
  }
  void Work() {
    final path = '$email/Work';
    uploadImage(onSelected: (file) {
      fb
        .storage()
        .refFromURL('gs://lifemadeeasier-4cf1d.appspot.com/')
        .child(path)
        .put(file).future.then((_){
                    _firestoreInstance.collection('SP').doc('$email').update({
                    // 'Brand' : '',
                    // 'B/L' : '',
                    'Work' : path,
                    });
                    print(path);
                    Toast.show("Work image has been uploaded", context, duration: 3, gravity:  Toast.BOTTOM);

        });
    });
  }
  // void uploadtoStore(){
  //    _firestoreInstance.collection('SP').doc('$email').update({
  //                                       'Brand' : brand,
  //                                       'B/L' : bol,
  //                                     }).then((_){
                                        
  //                                     });
  // }



  @override
  Widget verify(double width, double height){
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
                            ListTile(  
          title: Text('Functional Service'),  
          leading: Radio(    
            groupValue: id1, 
            value: 1, 
            onChanged: (value) {  
              setState(() {
                id1=1;
              });
                
              
            },   
          ),  
        ),  
        ListTile(  
          title: Text('Non-Functional Service'),  
          leading: Radio(    
            groupValue: id1,
            value: 2, 
            onChanged: (value) {  
                setState(() {
                id1=2;
              });
               
                
            },  
          ),  
        ), 

        (id1==1)?Text(
            'Are you Brand service provider or Local service provider?',
            style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: 'ZillaSlab',
            fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ):Container(),
          (id1==1)?ListTile(  
          title: Text('Brand'),  
          leading: Radio(    
            groupValue: id, 
            value: 1, 
            onChanged: (value) {  
              setState(() {
                id=1;
              });
                
              
            },   
          ),  
        ):Container(),  
        (id1==1)?ListTile(  
          title: Text('Local'),  
          leading: Radio(    
            groupValue: id,
            value: 2, 
            onChanged: (value) {  
                setState(() {
                id=2;
              });
               
                
            },  
          ),  
        ):Container(),


                          Container(
                            padding: EdgeInsets.only(right: 15),
                            child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                hint: Text("Select your Service",
                                    style: TextStyle(color: Colors.black)),
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none),
                                //onChanged: (String newValue) {},
                                items: (id1==1)?(id==2)?<String>[
                                  'Carpenter',
                                  'Electrician',
                                  'Mechanic',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                                :<String>[
                                  'Refridgerator',
                                  'Microwave Oven',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList():
                                <String>[
                                  'Newspaper',
                                  'Milk Delivery',
                                  'Medicine',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value){
                              service_field = value;
                              if(id1==1)
                              {
                                type='functional';
                              }
                              else
                              {
                                type='non-functional';
                              }
                              _firestoreInstance.collection('SP').doc('$email').update({'Service_field' : service_field, 'Type' : type});
                              },
                                ),
                          ),
           
        (id1==1)?(id==1)?Container(
          padding: EdgeInsets.only(right: 15),
          child: DropdownButtonFormField<String>(
              isExpanded: true,
              hint: Text("Brand",
                  style: TextStyle(color: Colors.black)),
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none),
              
              items: 
              Brand
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                
                  child: Text(value),
                );
              }).toList(),
              
              onChanged: (value){
                brand = value;
                _firestoreInstance.collection('SP').doc('$email').update({'Brand' : brand});
                
              },
              ),
        ):Container(
          
        ):Container(),
        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              cph = int.parse(value);
              _firestoreInstance.collection('SP').doc('$email').update({'CPH' : cph});
            },
            decoration: InputDecoration(
                
                hintText: "Enter your charging amount in rupees",
                labelText: "Cost per hour",
               ),
          ),
        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              refname = value;
              _firestoreInstance.collection('SP').doc('$email').update({'Ref Name' : refname});
            },
            decoration: InputDecoration(
                
                hintText: "Give his/her name",
                labelText: "Reference Person",
               ),
          ),
          TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              refph = value;
              if(id==1)
              _firestoreInstance.collection('SP').doc('$email').update({'Ref Ph' : refph,'BOL' : 'brand'});
              else
              _firestoreInstance.collection('SP').doc('$email').update({'Ref Ph' : refph,'BOL' : 'local','Brand' : 'General'});
              
            },
            decoration: InputDecoration(
                hintText: "Give his/her phone number",
                labelText: "Reference Ph.no",
               ),
          ),
        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              
            },
            decoration: InputDecoration(
                hintText: "Upload your ID",
                labelText: "ID",
                suffixIcon: TextButton(
                  child: Text("Upload"),
                  onPressed: () {
                    Id();
                  },
                )),
          ),
        TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              
            },
            decoration: InputDecoration(
                hintText: "Certificate of your work if any",
                labelText: "Certificate",
                suffixIcon: TextButton(
                  child: Text("Upload"),
                  onPressed: () {
                    certificate();
                  },
                )),
          ),
         TextField(
            keyboardType: TextInputType.name,
            onChanged: (value){
              
            },
            decoration: InputDecoration(
                hintText: "Upload your Workfield image",
                labelText: "Workfield Image",
                suffixIcon: TextButton(
                  child: Text("Upload"),
                  onPressed: () {
                    Work();
                  },
                )),
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
                                  
                                Navigator.pushNamed(context, 'providerhome');
                                print('done');
                                  
                                      
      
                                }),
                          ),
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
        child: verify(_width, _height),
      ),
    );
  }
}

















