import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:js1/Screens/Home.dart';
import 'package:js1/Screens/Student Profile/StudentResume.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js1/firestore/databasemanager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:js1/Screens/Main Home Student/StudentSwipeCard.dart';
void main() {
  runApp(MyNotificationStudent());
}
class MyNotificationStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationStudent(),
        debugShowCheckedModeBanner: false
    );
  }
}
class NotificationStudent extends StatefulWidget {
  @override
  _NotificationStudentState createState() => _NotificationStudentState();
}
class _NotificationStudentState extends State<NotificationStudent> {
  List userProfileList = [];
  List<DocumentSnapshot> documents = [];
  List<String> names = [];
  User user;
  bool isloggedin = false;
  int currentindex = 1;
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

  signOut() async {
    _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
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
      body:StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext _, AsyncSnapshot<User> snapshot) {
            if(! snapshot.hasData) return Center(child: CircularProgressIndicator(),);
            return StreamBuilder<DocumentSnapshot>(
              stream: DatabaseManager().getstudent(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                if (snapshot.hasData && !snapshot.data.exists)
                {
                  return Text('documentdoesnot exist');
                }
               return FutureBuilder(
                  future: DatabaseManager().getUsersList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> projectSnap){
                    if(projectSnap.hasData==true)
                      {
                        Map<String, dynamic> datas = snapshot.data.data();
                        List<dynamic> arr1=datas['likecompany'];
                        final data = projectSnap.data;
                        List<int> dp=[];
                        for(int i=0;i<data.docs.length;i++)
                          {
                            for(int j=0;j<arr1.length;j++)
                              {
                                if(data.docs[i].id==arr1[j])
                                  {
                                    dp.add(i);
                                    break;
                                  }
                              }
                          }
                        List<dynamic> arr=[];
                        List<dynamic>arr2=[];
                        for(int i=0;i<dp.length;i++)
                          {
                            arr.add(data.docs[dp[i]]['name']);
                            arr2.add(data.docs[dp[i]].id);
                          }
                        return new ListView.builder
                          (
                            itemCount: arr.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new Container(width: 100.0,height: 110.0,

                                child:
                                Center(child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10.0,),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Congratulations!! ',
                                          style: TextStyle(
                                            letterSpacing: 0.9,
                                            fontFamily: 'Assets/Poppins-Bold',
                                            fontSize: 22.0,
                                            color: Colors.white,
                                          ), /*defining default style is optional */
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'You have been selected by ',style:TextStyle(
                                            letterSpacing: 0.9,
                                            fontFamily: 'Assets/Poppins-Bold',
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),),
                                          TextSpan(
                                              text: arr[index]+".",
                                              style: TextStyle(
                                                letterSpacing: 0.9,
                                                fontFamily: 'Assets/Poppins-Bold',
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xF0CC3A3B),
                                              )),
                                          TextSpan(
                                              text: ' You can contact them at  ',
                                            style:TextStyle(
                                              letterSpacing: 0.9,
                                              fontFamily: 'Assets/Poppins-Bold',
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),),
                                          TextSpan(
                                              text: arr2[index],
                                              style: TextStyle(
                                            letterSpacing: 0.9,
                                            fontFamily: 'Assets/Poppins-Bold',
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xF0CC3A3B),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),),
                                  decoration: BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white60,
                                        //width: 2.0,
                                      ),
                                    ),
                              )); //;
                            }
                        );
                      }
                    else
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }
                  },
                );
              },
            );
        }
      ),
    );
  }
}
