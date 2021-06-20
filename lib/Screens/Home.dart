import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js1/Screens/Company login/logincom.dart';
import 'package:js1/Screens/Student Login/Login.dart';
void main() {
  runApp(HomePage());
}
class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
        debugShowCheckedModeBanner: false
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset('Assets/Main.jpg'),
              color: Colors.black,
              height: 350.0,
            ),

            Container(
              padding: EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0,10.0, 10.0, 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.userGraduate,),
                          SizedBox(width: 20.0,),
                          Text('Tap To Get Your Dream Job'),
                        ],
                      ),
                      color: Color(0xF0CC3A3B),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 25.0, right: 15.0),
                          child: Divider(
                            color: Colors.white,
                            height: 50,
                          )),
                    ),

                    Text('OR',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 15.0, right: 25.0),
                          child: Divider(
                            color: Colors.white,
                            height: 50,
                          )),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0,5.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.businessTime,),
                          SizedBox(width: 20.0,),
                          Text('Tap To Get Your Right Candidate'),
                        ],
                      ),
                      color: Color(0xFF0A66C2),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyLoginPage()));
                      },
                    ),
                  ),
                ],),
            ),
            SizedBox(height: 25.0,),
          ],
        ),
      ),
    );
  }
}
