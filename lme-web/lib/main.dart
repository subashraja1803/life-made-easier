import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lme_final/Screens/dashboard.dart';
import 'package:lme_final/Screens/history.dart';
import 'package:lme_final/Screens/home_provider.dart';
import 'package:lme_final/Screens/home_user.dart';
import 'package:lme_final/Screens/report_screen.dart';
import 'package:lme_final/Screens/spsignup_screen.dart';
import 'package:lme_final/Screens/usignup_screen.dart';
import 'package:lme_final/Screens/verifyEmail_screen.dart';
//import 'package:lme/Screens/home_screen.dart';
//import 'package:lme/Screens/dash_screen.dart';
import 'package:lme_final/Screens/login_screen.dart';
import 'package:lme_final/Screens/spverify_screen.dart';
import 'package:lme_final/Screens/order_screen.dart';
import 'package:lme_final/Screens/onprpgress.dart';
import 'package:lme_final/Screens/historysp.dart';
import 'package:lme_final/Screens/pending.dart';
import 'package:lme_final/Screens/pendingsp.dart';
import 'package:lme_final/Screens/onprogresssp.dart';
import 'package:lme_final/Screens/report_screensp.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Lme());
//FirebaseMessaging.instance.getToken().then(print);
//FirebaseMessaging().getToken().then(print);
  // FirebaseMessaging ins = new FirebaseMessaging();
  // ins.getToken().then(print);
}

// ignore: must_be_immutable
class Lme extends StatelessWidget {
  // This widget is the root of your application.
  //final _auth = FirebaseAuth.instance;
  String s=(FirebaseAuth.instance.currentUser!=null)?'home':'welcome';
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Life Made Easier',
      debugShowCheckedModeBanner: false,
      initialRoute: 'dashboard',
      routes: {
        //'dash': (context) => DashScreen(),
        'dashboard': (context) => dashboard(),
        'verify': (context) => VerifyEmailScreen(),
        'login': (context) => LoginScreens(),
        'history': (context) => history(),
        'providerhome': (context) => homeprovider(),
        'userhome': (context) => homeuser(),
        'usersignup': (context) => UsignupScreens(),
        'spsignup': (context) => SpsignupScreens(),
        'report' : (context) => ReportScreens(),
        'spverify' : (context) => SpverifyScreens(),
        'order' : (context) => OrderScreens(),
        'onprogress' : (context) => onprogress(),
        'onprogresssp' : (context) => Onprogresssp(),
        'pending' : (context) => pending(),
        'historysp' : (context) => historyspsl(),
        'pendingsp' : (context) => pendsp(),
        'reportsp' : (context) => ReportScreenssp(),
        //'home':(context)=> HomeScreen(),
      },
    );
  }
}
