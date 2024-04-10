import 'dart:html';

import 'package:flutter/material.dart';
Widget pulldrawer(BuildContext context, int option) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        //1
        Container(
          child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xff7b1fa2), const Color(0xff18ffff)],
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 45, 5, 3),
                child: Text(
                  "Greetings!",
                  textAlign: TextAlign.center,
                  
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.5,
                      fontFamily: 'Segoe UI'),
                ),
              )),
        ),

        //2
        ListTile(
          leading: Icon(Icons.history, color: Colors.black),
          title: Text("History",
              style: TextStyle(
                  color: (option == 1) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.pushNamed(context, 'historysp');
          },
        ),

        //3
        ListTile(
          leading: Icon(Icons.ondemand_video_rounded, color: Colors.black),
          title: Text("On Progress",
              style: TextStyle(
                  color: (option == 2) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.pushNamed(context, 'onprogresssp');
          },
        ),

        //4
        ListTile(
          leading: Icon(Icons.paste_sharp, color: Colors.black),
          title: Text("Complaints",
              style: TextStyle(
                  color: (option == 3) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
           Navigator.pushNamed(context, 'reportsp');
          },
        ),

        //5
        ListTile(
          leading: Icon(
            Icons.verified,
            color: Colors.black,
          ),
          title: Text("Verification",
              style: TextStyle(
                  color: (option == 4) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.pushNamed(context, 'spverify');
          },
        ),

        //6
        ListTile(
          leading: Icon(Icons.pending_actions_rounded, color: Colors.black),
          title: Text("Pending",
              style: TextStyle(
                  color: (option == 5) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.pushNamed(context, 'pendingsp');
             
          },
        ),

        //7
       
        ListTile(
          leading: Icon(Icons.exit_to_app,color: Colors.black),
          title: Text("Logout",
              style: TextStyle(
                  color: (option == 3) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
           Navigator.pushNamed(context, 'dashboard');
          },
        ),
      ],
    ),
  );
}