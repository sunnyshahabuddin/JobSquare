import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:js1/firestore/databasemanager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:js1/Screens/Main Home Company/CompanyHome.dart';
import 'package:js1/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: company_profile(),
    );
  }
}
class company_profile extends StatefulWidget {
  @override
  _company_profileState createState() => _company_profileState();
}
class _company_profileState extends State<company_profile> {
  User user;
  bool isloggedin = false;
  int currentindex = 0;
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
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 12),
              child: IconButton(
                icon: Image.asset('Assets/logo.png',),
              ),
            ),
            backgroundColor: Color(0xFF131313),
            title: Text(
                'JOB SQUARE',
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
                  icon: Icon(Icons.home,color: Colors.white,),
                  title: Text('Home',style: TextStyle(color: Colors.white),),
                  backgroundColor: Color(0xFF131313)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,color: Colors.white,),
                  title: Text('Profile',style: TextStyle(color: Colors.white),),
                  backgroundColor: Color(0xFF131313)),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout,color: Colors.white,),
                title: Text('SignOut',style: TextStyle(color: Colors.white),),
                backgroundColor: Color(0xFF131313),
              ),
            ],
            onTap: (index) {
              setState(() {
                currentindex = index;
              });
              if(currentindex==0){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>MyCompanyHome()));
              }
              if (currentindex == 2) {
                signOut();
              }
              if (currentindex == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => company_profile()));
              }
            },
          ),
              backgroundColor: Color(0xFF131313),
              body: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    SizedBox(height: 10.0,),
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
                                    Container(
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
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Role",
                                                style: TextStyle(
                                                    letterSpacing: 0.9,
                                                    fontFamily: 'Assets/Poppins-Bold',
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                              Text(
                                                datas['role'],
                                                style: TextStyle(
                                                    letterSpacing: 0.9,
                                                    color: Colors.white,
                                                    fontFamily: 'Assets/Poppins-Bold',
                                                    fontSize: 15.0),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Offer",
                                                style: TextStyle(
                                                    letterSpacing: 0.9,
                                                    fontFamily: 'Assets/Poppins-Bold',
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                              Text(
                                                datas['offer'],
                                                style: TextStyle(
                                                    letterSpacing: 0.9,
                                                    fontFamily: 'Assets/Poppins-Bold',
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
                                  title: Text("Requirements",
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
                                    "Technical Requirement",
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 18.0,
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                    ),
                                  ),
                                  subtitle: Text(
                                    datas['Technical Requirement'],
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Batches Eligible",
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 18.0,
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                    ),
                                  ),
                                  subtitle: Text(
                                    datas['Eligible Batches'],
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Minimum CGPA Required",
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 18.0,
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                    ),
                                  ),
                                  subtitle: Text(
                                    datas['Minimum CGPA'],
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
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
                                  title: Text("Allowances",
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
                                    datas['allowance'],
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
                                  title: Text("Company information",
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
                                    "Website",
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 18.0,
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                    ),
                                  ),
                                  subtitle: Text(
                                    datas['website'],
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 15.0,
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.web,
                                    color: Color(0xF0CC3A3B),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "About",
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 18.0,
                                      letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',
                                    ),
                                  ),
                                  subtitle: Text(
                                    datas['about'],
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 15.0,
                                      letterSpacing: 0.6,
                                      fontFamily: 'Assets/Poppins-Bold',
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.person,
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
        future: DatabaseManager().getcompuid(),
      ),
    );}
}
