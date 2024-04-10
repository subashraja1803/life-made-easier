import 'package:flutter/material.dart';
//import 'package:lme/constant.dart';
import 'package:email_auth/email_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  void initState() {
    super.initState();
  }
  var email;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool verify;
  bool dir;
  
  saveValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
}
  getValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  bool user = prefs.getBool('user');
  return user;
}
void retrive() async{
    dir  = await getValue() ?? "";
    print(email);
  }
  void sendOTP() async {
    EmailAuth.sessionName = "LME";

    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP sent");
    } else {
      print("Can't send OTP");
    }
  }
  bool verifyOTP() {
    var res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("OTP verified");
      return true;
    } else {
      print("Incorrect OTP");
      return false;
    }
  }
  Future dialogBox(
      var text,
      bool error,
      double screenheight,
      double screenwidth,
      int popcount,
      BuildContext context,
      var buttonstring) {
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
              width: screenwidth,
              height: screenheight,
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
                    Icon(
                      (error) ? Icons.error : Icons.done,
                      size: 40,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text(text, style: TextStyle(fontSize: 15))),
                    SizedBox(
                      height: 20,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.lightBlue[800],
                      child: Text(buttonstring,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        for (int i = 0; i <= popcount; i++)
                          Navigator.of(context).pop();
                      },
                    )
                  ])),
            ),
          );
        });
  }

  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    retrive();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: (width > 1100)
                  ? width * 0.40
                  : (width > 600)
                      ? width * 0.58
                      : width - 100,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value){
                              email=value;
                              saveValue();
                            },
                            decoration: InputDecoration(
                                hintText: "Enter email",
                                labelText: "Email",
                                suffixIcon: TextButton(
                                  child: Text("Send OTP"),
                                  onPressed: () {

                                    sendOTP();
                                  },
                                )),
                          ),
                          TextField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Enter OTP",
                              labelText: "OTP",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Material(
                    elevation: 5.0,
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        verify = verifyOTP();
                        if (verify) {
                          if(dir)
                          Navigator.pushNamed(context, 'usersignup');
                          else
                          Navigator.pushNamed(context, 'spsignup');
                        } else {
                          dialogBox("Re-Enter the OTP", true, 200, 350, 1,
                              context, "ok");
                        }
                      },
                      minWidth: 300.0,
                      height: 42.0,
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
