import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool selectedlogin = true, selectedloginsp = false;
  var email;
  saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user', selectedlogin);
    prefs.setString('email', email);
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
    print('');
  }
  

  final _auth = FirebaseAuth.instance;
  var password;

  Future _dialogbox(String msg, bool error) {
    saveValue();
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
                    Center(
                        child: (error)
                            ? Text(
                                "Error",
                                style: TextStyle(
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            : Text(
                                "Done",
                                style: TextStyle(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: (error)
                          ? Icon(
                              Icons.error,
                              size: 40,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.done,
                              size: 40,
                              color: Colors.green,
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: (!error)
                            ? Text("Logged in Successfully",
                                style: TextStyle(fontSize: 15))
                            : (msg ==
                                    "There is no user record corresponding to this identifier. The user may have been deleted.")
                                ? Text("User Not Found",
                                    style: TextStyle(fontSize: 15))
                                : (msg ==
                                        "The password is invalid or the user does not have a password.")
                                    ? Text("Invalid Password",
                                        style: TextStyle(fontSize: 15))
                                    : Text("Something Went Wrong,Try Later",
                                        style: TextStyle(fontSize: 15))),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.lightBlue[800],
                      child: Text("OK", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        //_loginkey.currentState.reset();
                        Navigator.of(context).pop();

                        if (!error) {
                          if (selectedlogin) {
                            Navigator.pushNamed(context, 'userhome');
                          } else {
                            Navigator.pushNamed(context, 'providerhome');
                          }
                        }
                      },
                    )
                  ])),
            ),
          );
        });
  }

  Widget login(double width) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  buttonColor: selectedlogin
                      ? Color.fromRGBO(255, 255, 255, 0.8)
                      : Colors.grey[350],
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    elevation: selectedlogin ? 0 : 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Customer",
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
                        selectedlogin = true;
                        selectedloginsp = false;
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
                  buttonColor: selectedloginsp
                      ? Color.fromRGBO(255, 255, 255, 0.8)
                      : Colors.grey[350],
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    elevation: selectedloginsp ? 0 : 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.handyman),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Service Provider",
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
                        selectedloginsp = true;
                        selectedlogin = false;
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
          Container(
            width: (width > 1100)
                ? width * 0.40
                : (width > 600)
                    ? width * 0.58
                    : width - 100,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8),
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
                  onChanged: (val) {
                    email = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  onChanged: (val) {
                    password = val;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "New User ",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        child: Text("Sign Up",
                            style: TextStyle(color: Colors.blue[900])),
                        onPressed: () {
                          saveValue();
                          if(selectedlogin)
                          Navigator.pushNamed(context, 'verify');
                          else
                          Navigator.pushNamed(context, 'verify');
                        },
                      ),
                    ],
                  ),
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
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        dynamic newUser;
                        String info;
                        try {
                          newUser = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          //newUser = _auth.currentUser.uid;
                        } catch (e) {
                          print(e.message);
                          newUser = null;
                          info = e.message.toString();
                        }
                        if (newUser != null) {
                          _dialogbox(info, false);
                        } else {
                          _dialogbox(info, true);
                        }
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("bg2.jpg"),
          fit: BoxFit.cover,
        )),
        child: login(_width),
      ),
    );
  }
}
