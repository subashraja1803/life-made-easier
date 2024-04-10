//import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lme_final/constant.dart';

//import 'package:flutter/animation.dart';
class DashScreen extends StatefulWidget {
  const DashScreen({Key key}) : super(key: key);
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        elevation: 20.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
              ),
              child: Text(
                "Life Made Easier",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                //do something
                //Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.add_to_queue),
              title: Text('Update Details'),
              onTap: () {
                //do spmething
                //Navigator.pushNamed(context, 'change');
              },
            ),
            /*ListTile(
                leading: Icon(Icons.assessment),
                title: Text('SCAN'),
                onTap: (){
                  //do spmething
                  //Navigator.pushNamed(context, 'scan');
                },
              ),*/
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Change Password'),
              onTap: () {
                // do something
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('About Us'),
              onTap: () {
                // do something
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  //_auth.signOut();
                  //Navigator.pushReplacement(context,
                  //    MaterialPageRoute(builder: (context) => WelcomeScreen()));
                }),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {}),
        ],
        title: Text(
          'Connector_PH',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Architects',
            fontWeight: FontWeight.w700,
          ),
        ),
        //backgroundColor: Hexcolor('#d2e603'),
      ),
      body: Container(
        height: size.height,
        // it will take full width
        width: size.width,

        /*decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/anyimage.png"),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomAppBar(),
            ]),
      ),
      backgroundColor: Colors.black54,
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final Function press;
  const MenuItem({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: kTextcolor.withOpacity(0.3),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(46),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.handyman),
          SizedBox(width: 5),
          Text(
            "Life Made Easier",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          MenuItem(
            title: "Feedback",
            press: () {},
          ),
          MenuItem(
            title: "About",
            press: () {},
          ),
          MenuItem(
            title: "Contact",
            press: () {},
          ),
          MenuItem(
            title: "SignUp",
            press: () {},
          ),
          SizedBox(
            width: 20.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            // ignore: deprecated_member_use
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              color: kPrimaryColor,
              onPressed: () {
                //Navigator.pushNamed(context, 'verify');
                
              },
              child: Text(
                "LOGIN",
              ),
            ),
          )
        ],
      ),
    );
  }
}
