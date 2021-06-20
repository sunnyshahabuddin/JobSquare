import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:js1/firestore/databasemanager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:js1/Screens/Main Home Student/StudentSwipeCard.dart';
import 'package:js1/Screens/Main Home Student/Notification Screen.dart';

import 'package:js1/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() {
  runApp(MyStudentResume());
}
class MyStudentResume extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyStudentProfiles(),
    );
  }
}
class MyStudentProfiles extends StatefulWidget {
  @override
  _MyStudentProfilesState createState() => _MyStudentProfilesState();
}
class _MyStudentProfilesState extends State<MyStudentProfiles> {
  User user;
  bool isloggedin = false;
  int currentindex = 2;
  int counter = 4;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    this.getUser();
    this.checkAuthentification();
  }
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }
  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }
  CollectionReference users = FirebaseFirestore.instance.collection('company');

  signOut() async {

    _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DocumentSnapshot>( builder:  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> datas = snapshot.data.data();
          return Scaffold(
            backgroundColor: Color(0xFF131313),
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.only(left: 12),
                child: IconButton(
                  icon: Image.asset('Assets/logo.png',),
                ),
              ),
              backgroundColor: Color(0xFF131313),
              title: Text(
                  '           JOB OFFERS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(40),
                    fontFamily: 'Poppins-Bold',
                    letterSpacing: .6,
                  )
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentindex,
              backgroundColor: Color(0xFF131313),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    backgroundColor: Color(0xFF131313)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    title: Text('Notification'),
                    backgroundColor: Color(0xFF131313)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text('Profile'),
                    backgroundColor: Color(0xFF131313)),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  title: Text('SignOut'),
                  backgroundColor: Colors.blue,
                ),
              ],
              onTap: (index) {
                setState(() {
                  currentindex = index;
                });
                if(currentindex==2){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyStudentProfiles()));
                }
                if (currentindex == 3) {
                  signOut();
                }
                if (currentindex == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>MyNotificationStudent()));
                }
                if (currentindex == 0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyStudentCard()));
                }

              },
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    width: 400,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 96.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            datas['name'],
                                            style: TextStyle(
                                              fontFamily: 'Assets/Poppins-Bold',
                                              letterSpacing: 1.9,
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(46.0),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: NetworkImage(datas['image url']),
                                      fit: BoxFit.cover)),
                              margin: EdgeInsets.only(left: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text("Education",
                                    style: TextStyle(
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                      fontSize: 22.0,
                                      color: Color(0xF0CC3A3B),
                                    )),
                              ),
                              Divider(
                                height: 5,
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  "High School",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    text: datas['high_school_name']+"  ",
                                    style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: datas['high_school_grade'],
                                        style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                          fontFamily: 'Assets/Poppins-Bold',),)
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Secondary School",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    text: datas['secondary_school_name']+"  ",
                                    style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: datas['secondary_scholol_grade'],
                                        style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                          fontFamily: 'Assets/Poppins-Bold',),)
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "College",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle:RichText(
                                  text: TextSpan(
                                    text: datas['collage_name']+"  ",
                                    style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: datas['collage_grade'],
                                        style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                          fontFamily: 'Assets/Poppins-Bold',),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text("Projects",
                                    style:  TextStyle(
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                      fontSize: 22.0,
                                      color: Color(0xF0CC3A3B),
                                    )),
                              ),
                              Divider(
                                height: 5,
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  datas['project'],
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                              ),
                            ])),
                        SizedBox(height: 10.0),
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(children: <Widget>[
                              ListTile(
                                title: Text("Internship",
                                    style:  TextStyle(
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                      fontSize: 22.0,
                                      color: Color(0xF0CC3A3B),
                                    )),
                              ),
                              Divider(
                                height: 5,
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  datas['internships'],
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                              ),
                            ])),
                        SizedBox(height: 10.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text("Personal information",
                                    style: TextStyle(
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                      fontSize: 22.0,
                                      color: Color(0xF0CC3A3B),
                                    )),
                              ),
                              Divider(
                                height: 5,
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  "Email",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle: Text(
                                  datas['email'],
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 15.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                leading: Icon(
                                  Icons.email,
                                  color: Color(0xF0CC3A3B),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Phone",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle: Text(
                                  datas['phone'],
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 15.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                leading: Icon(
                                  Icons.phone,
                                  color: Color(0xF0CC3A3B),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Skills",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle: Text(
                                  datas['skills'],
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 15.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                leading: Icon(
                                  Icons.person_add,
                                  color: Color(0xF0CC3A3B),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Language",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle: Text(
                                  datas['languages'],
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 15.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                leading: Icon(
                                  Icons.label,
                                  color: Color(0xF0CC3A3B),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Interests",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18.0,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                subtitle: Text(
                                  datas['hobbies'],
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 15.0,
                                    letterSpacing: 0.6,
                                    fontFamily: 'Assets/Poppins-Bold',
                                  ),
                                ),
                                leading: Icon(
                                  Icons.icecream,
                                  color: Color(0xF0CC3A3B),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

        }
        return Center(child: CircularProgressIndicator(),);
      },
        future: DatabaseManager().getuid(),
      ),
    );}
}
