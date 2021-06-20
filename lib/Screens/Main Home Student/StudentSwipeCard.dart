import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:js1/Screens/Main Home Student/card_view.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:js1/Screens/Home.dart';
import 'package:js1/Screens/Student Profile/StudentResume.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js1/firestore/databasemanager.dart';
import 'package:js1/Screens/Main Home Student/Notification Screen.dart';
void main() {
  runApp(MyStudentCard());
}
class MyStudentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySwipeCard(),
        debugShowCheckedModeBanner: false
    );
  }
}
class MySwipeCard extends StatefulWidget {
  @override
  _MySwipeCardState createState() => _MySwipeCardState();
}
class _MySwipeCardState extends State<MySwipeCard> {
  List userProfileList = [];
  User user;
  bool isloggedin = false;
  int currentindex = 0;
  int counter = 4;
  final List<String> _names = [];
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
    //create a CardController
    CardController _cardController = CardController();
    CollectionReference students = FirebaseFirestore.instance.collection('users');
    CollectionReference company = FirebaseFirestore.instance.collection('company');
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyNotificationStudent()));
            }
            if (currentindex == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyStudentCard()));
            }
          },
        ),
        body:StreamBuilder<User>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext _, AsyncSnapshot<User> snapshot) {
              //if the snapshot is null, or not has data it is signed out
              if(! snapshot.hasData) return Center(child: CircularProgressIndicator(),);
              // if the snapshot is having data it is signed in, show the homescreen
              return StreamBuilder<QuerySnapshot>(
                stream: DatabaseManager().getc(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> projectSnap) {
                    if (projectSnap.hasData == true) {
                      final data = projectSnap.data;
                      return StreamBuilder<DocumentSnapshot>(
                        stream: DatabaseManager().getstudent(),
                        builder:
                            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData && !snapshot.data.exists)
                          {
                            return Text('documentdoesnot exist');
                          }
                          Map<String, dynamic> datas = snapshot.data.data();

                          List<dynamic> arr=datas['notshow'];
                          List<dynamic> arr1=[];
                          List<int> dp=[];
                          for(int i=0;i<data.docs.length;i++)
                          {
                            arr1.add(data.docs[i].id);
                          }
                          var filtered_lst = List.from(arr1.where(
                                  (value) => !arr.contains(value)));
                          for(int i=0;i<data.docs.length;i++)
                          {
                            for(int j=0;j<filtered_lst.length;j++)
                            {
                              if(data.docs[i].id==filtered_lst[j]){
                                dp.add(i);
                                break;
                              }
                            }
                          }
                          if(filtered_lst.length>=3){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SwipeableCardsSection(
                                  cardController: _cardController,
                                  context: context,
                                  //add the first 3 cards
                                  items: [
                                    CardView(name:data.docs[dp[0]]['name'],text: filtered_lst[0],imgurl:data.docs[dp[0]]['image url']?.toString(),
                                      role: data.docs[dp[0]]['role'],offer: data.docs[dp[0]]['offer'],treq: data.docs[dp[0]]['Technical Requirement'],bacthes: data.docs[dp[0]]['Eligible Batches'],
                                      cgpa: data.docs[dp[0]]['Minimum CGPA'],allowance:data.docs[dp[0]]['allowance'] ,website:data.docs[dp[0]]['website'] ,phone:data.docs[dp[0]]['phone'] ,about:data.docs[dp[0]]['about'] ,),
                                    CardView(name:data.docs[dp[1]]['name'],text: filtered_lst[1],imgurl:data.docs[dp[1]]['image url']?.toString(),
                                      role: data.docs[dp[1]]['role'],offer: data.docs[dp[1]]['offer'],treq: data.docs[dp[1]]['Technical Requirement'],bacthes: data.docs[dp[1]]['Eligible Batches'],
                                      cgpa: data.docs[dp[1]]['Minimum CGPA'],allowance:data.docs[dp[1]]['allowance'] ,website:data.docs[dp[1]]['website'] ,phone:data.docs[dp[1]]['phone'] ,about:data.docs[dp[1]]['about'] ,),
                                    CardView(name:data.docs[dp[2]]['name'],text: filtered_lst[2],imgurl:data.docs[dp[2]]['image url']?.toString(),
                                      role: data.docs[dp[2]]['role'],offer: data.docs[dp[2]]['offer'],treq: data.docs[dp[2]]['Technical Requirement'],bacthes: data.docs[dp[2]]['Eligible Batches'],
                                      cgpa: data.docs[dp[2]]['Minimum CGPA'],allowance:data.docs[dp[2]]['allowance'] ,website:data.docs[dp[2]]['website'] ,phone:data.docs[dp[2]]['phone'] ,about:data.docs[dp[2]]['about'] ,),
                                  ],
                                  onCardSwiped: (dir, index, widget) {
                                    //Add the next card
                                    if (counter < filtered_lst.length) {
                                      _cardController.addItem(CardView(name:data.docs[dp[counter]]['name'],text: filtered_lst[counter],imgurl:data.docs[dp[counter]]['image url']?.toString(),
                                        role: data.docs[dp[counter]]['role'],offer: data.docs[dp[counter]]['offer'],treq: data.docs[dp[counter]]['Technical Requirement'],bacthes: data.docs[dp[counter]]['Eligible Batches'],
                                        cgpa: data.docs[dp[counter]]['Minimum CGPA'],allowance:data.docs[dp[counter]]['allowance'] ,website:data.docs[dp[counter]]['website'] ,phone:data.docs[dp[counter]]['phone'] ,about:data.docs[dp[counter]]['about'] ,),);
                                      counter++;
                                    }
                                    if (dir == Direction.left) {
                                      arr.add((widget as CardView).text);
                                      students.doc(datas['email']).update({
                                        'notshow': arr,
                                      }).then((value) => print("User Updated")).catchError((error) => print("Failed to add user: $error"));
                                      print('onDisliked ${(widget as CardView).text} $index');
                                      FirebaseFirestore.instance.collection('company').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          List<dynamic> value = documentSnapshot.get("sdislike");
                                          value.add(datas['email']);
                                          company
                                              .doc(filtered_lst[index])
                                              .update({
                                            'sdislike': value,
                                          })
                                              .then((value) => print("User Updated"))
                                              .catchError((error) => print("Failed to add user: $error"));
                                        } else {
                                          print('Document does not exist on the database');
                                        }
                                      });

                                    }
                                    else if (dir == Direction.right) {
                                      print('onLiked ${(widget as CardView).text} $index');
                                      arr.add((widget as CardView).text);
                                      students.doc(datas['email']).update({
                                        'notshow': arr,
                                      }).then((value) => print("User Updated"))
                                          .catchError((error) => print("Failed to add user: $error"));
                                      FirebaseFirestore.instance.collection('company').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          List<dynamic> value = documentSnapshot.get("slike");
                                          value.add(datas['email']);
                                          company
                                              .doc(filtered_lst[index])
                                              .update({
                                            'slike': value,
                                          })
                                              .then((value) => print("User Updated"))
                                              .catchError((error) => print("Failed to add user: $error"));
                                        } else {
                                          print('Document does not exist on the database');
                                        }
                                      });
                                    }
                                  },
                                  enableSwipeUp: false,
                                  enableSwipeDown: false,
                                ),
                                SizedBox(height: ScreenUtil().setHeight(100),)
                              ],
                            );
                          }
                          if(filtered_lst.length==2)
                          {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SwipeableCardsSection(
                                  cardController: _cardController,
                                  context: context,
                                  //add the first 3 cards
                                  items: [
                                    CardView(name:data.docs[dp[0]]['name'],text: filtered_lst[0],imgurl:data.docs[dp[0]]['image url']?.toString(),
                                      role: data.docs[dp[0]]['role'],offer: data.docs[dp[0]]['offer'],treq: data.docs[dp[0]]['Technical Requirement'],bacthes: data.docs[dp[0]]['Eligible Batches'],
                                      cgpa: data.docs[dp[0]]['Minimum CGPA'],allowance:data.docs[dp[0]]['allowance'] ,website:data.docs[dp[0]]['website'] ,phone:data.docs[dp[0]]['phone'] ,about:data.docs[dp[0]]['about'] ,),
                                    CardView(name:data.docs[dp[1]]['name'],text: filtered_lst[1],imgurl:data.docs[dp[1]]['image url']?.toString(),
                                      role: data.docs[dp[1]]['role'],offer: data.docs[dp[1]]['offer'],treq: data.docs[dp[1]]['Technical Requirement'],bacthes: data.docs[dp[1]]['Eligible Batches'],
                                      cgpa: data.docs[dp[1]]['Minimum CGPA'],allowance:data.docs[dp[1]]['allowance'] ,website:data.docs[dp[1]]['website'] ,phone:data.docs[dp[1]]['phone'] ,about:data.docs[dp[1]]['about'] ,),
                                  ],
                                  onCardSwiped: (dir, index, widget) {
                                    if (dir == Direction.left) {
                                      arr.add((widget as CardView).text);
                                      students.doc(datas['email']).update({
                                        'notshow': arr,
                                      }).then((value) => print("User Updated")).catchError((error) => print("Failed to add user: $error"));
                                      print('onDisliked ${(widget as CardView).text} $index');
                                      FirebaseFirestore.instance.collection('company').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          List<dynamic> value = documentSnapshot.get("sdislike");
                                          value.add(datas['email']);
                                          company
                                              .doc(filtered_lst[index])
                                              .update({
                                            'sdislike': value,
                                          })
                                              .then((value) => print("User Updated"))
                                              .catchError((error) => print("Failed to add user: $error"));
                                        } else {
                                          print('Document does not exist on the database');
                                        }
                                      });

                                    }
                                    else if (dir == Direction.right) {
                                      print('onLiked ${(widget as CardView).text} $index');
                                      arr.add((widget as CardView).text);
                                      students.doc(datas['email']).update({
                                        'notshow': arr,
                                      }).then((value) => print("User Updated"))
                                          .catchError((error) => print("Failed to add user: $error"));
                                      FirebaseFirestore.instance.collection('company').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          List<dynamic> value = documentSnapshot.get("slike");
                                          value.add(datas['email']);
                                          company
                                              .doc(filtered_lst[index])
                                              .update({
                                            'slike': value,
                                          })
                                              .then((value) => print("User Updated"))
                                              .catchError((error) => print("Failed to add user: $error"));
                                        } else {
                                          print('Document does not exist on the database');
                                        }
                                      });
                                    }
                                  },
                                  enableSwipeUp: false,
                                  enableSwipeDown: false,
                                ),
                                SizedBox(height: ScreenUtil().setHeight(100),)
                              ],
                            );
                          }
                          if(filtered_lst.length==1)
                          {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SwipeableCardsSection(
                                  cardController: _cardController,
                                  context: context,
                                  //add the first 3 cards
                                  items: [
                                    CardView(name:data.docs[dp[0]]['name'],text: filtered_lst[0],imgurl:data.docs[dp[0]]['image url']?.toString(),
                                      role: data.docs[dp[0]]['role'],offer: data.docs[dp[0]]['offer'],treq: data.docs[dp[0]]['Technical Requirement'],bacthes: data.docs[dp[0]]['Eligible Batches'],
                                      cgpa: data.docs[dp[0]]['Minimum CGPA'],allowance:data.docs[dp[0]]['allowance'] ,website:data.docs[dp[0]]['website'] ,phone:data.docs[dp[0]]['phone'] ,about:data.docs[dp[0]]['about'] ,),
                                  ],
                                  onCardSwiped: (dir, index, widget) {
                                    if (dir == Direction.left) {
                                      arr.add((widget as CardView).text);
                                      students.doc(datas['email']).update({
                                        'notshow': arr,
                                      }).then((value) => print("User Updated")).catchError((error) => print("Failed to add user: $error"));
                                      print('onDisliked ${(widget as CardView).text} $index');
                                      FirebaseFirestore.instance.collection('company').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          List<dynamic> value = documentSnapshot.get("sdislike");
                                          value.add(datas['email']);
                                          company
                                              .doc(filtered_lst[index])
                                              .update({
                                            'sdislike': value,
                                          })
                                              .then((value) => print("User Updated"))
                                              .catchError((error) => print("Failed to add user: $error"));
                                        } else {
                                          print('Document does not exist on the database');
                                        }
                                      });

                                    }
                                    else if (dir == Direction.right) {
                                      print('onLiked ${(widget as CardView).text} $index');
                                      arr.add((widget as CardView).text);
                                      students.doc(datas['email']).update({
                                        'notshow': arr,
                                      }).then((value) => print("User Updated"))
                                          .catchError((error) => print("Failed to add user: $error"));
                                      FirebaseFirestore.instance.collection('company').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.exists) {
                                          List<dynamic> value = documentSnapshot.get("slike");
                                          value.add(datas['email']);
                                          company
                                              .doc(filtered_lst[index])
                                              .update({
                                            'slike': value,
                                          })
                                              .then((value) => print("User Updated"))
                                              .catchError((error) => print("Failed to add user: $error"));
                                        } else {
                                          print('Document does not exist on the database');
                                        }
                                      });
                                    }
                                  },
                                  enableSwipeUp: false,
                                  enableSwipeDown: false,
                                ),
                                SizedBox(height: ScreenUtil().setHeight(100),)
                              ],
                            );
                          }
                          if(filtered_lst.length==0)
                          {
                            return Center(child: Container(height:100,width:400,margin: EdgeInsets.only(left: 12.0,right: 16.0),
                              child: Center(child: Text("Oops!! it seems there are no more company available.Comeback later",style:TextStyle(
                                fontFamily: 'Assets/Poppins-Bold', fontSize: 22.0, color: Colors.white,)),),),);
                          }
                          return Center(child: CircularProgressIndicator(),);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator(),);
                  }

              ) ;})
    );
  }
}
