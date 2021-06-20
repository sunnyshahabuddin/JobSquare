import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:js1/Screens/Main Home Company/Card_view_Company.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:js1/Screens/Home.dart';
import 'package:js1/Screens/Company Profile/CompanyProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js1/firestore/databasemanager.dart';
void main() {
  runApp(MyCompanyHome());
}
class MyCompanyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyCompanyCard(),
        debugShowCheckedModeBanner: false
    );
  }
}
class MyCompanyCard extends StatefulWidget {
  @override
  _MyCompanyCardState createState() => _MyCompanyCardState();
}
class _MyCompanyCardState extends State<MyCompanyCard> {
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
    CardController _cardController = CardController();
    CollectionReference students = FirebaseFirestore.instance.collection('users');
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
      body:StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User> snapshot) {
          //if the snapshot is null, or not has data it is signed out
          if(! snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          // if the snapshot is having data it is signed in, show the homescreen
          return StreamBuilder<QuerySnapshot>(
          stream: DatabaseManager().gets(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> projectSnap) {
                if (projectSnap.hasData == true) {
                  final data = projectSnap.data;
                  return StreamBuilder<DocumentSnapshot>(
                    stream:DatabaseManager().getcompany(),
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
                      Map<String, dynamic> datas = snapshot.data.data();
                      List<dynamic>arr1=datas['slike'];
                      List<dynamic>arr=datas['saccept'];
                      var filtered_lst = List.from(arr1.where(
                              (value) => !arr.contains(value)));
                      List<int> dp=[];
                      for(int i=0;i<filtered_lst.length;i++)
                      {
                        for(int j=0;j<data.docs.length;j++)
                        {
                          if(data.docs[j].id==filtered_lst[i]){
                            dp.add(j);
                            break;
                          }
                        }
                      }
                      print(dp);
                      if(filtered_lst.length>=3){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new SwipeableCardsSection(
                              cardController: _cardController,
                              context: context,
                              //add the first 3 cards
                              items: [
                                CardView(name:data.docs[dp[0]]['name'],text: filtered_lst[0],imgurl:data.docs[dp[0]]['image url']?.toString(),skills:data.docs[dp[0]]['skills'] ,
                                  interests: data.docs[dp[0]]['hobbies'],internship: data.docs[dp[0]]['internships'],languages:data.docs[dp[0]]['languages'],highschool: data.docs[dp[0]]['high_school_name'],
                                  highmark: data.docs[dp[0]]['high_school_grade'],secondaryschool: data.docs[dp[0]]['secondary_school_name'],secondarymark: data.docs[dp[0]]['secondary_scholol_grade'],
                                  phone: data.docs[dp[0]]['phone'],projects: data.docs[dp[0]]['project'],college: data.docs[dp[0]]['collage_name'],collegemark: data.docs[dp[0]]['collage_grade'],),
                                CardView(name:data.docs[dp[1]]['name'],text: filtered_lst[1],imgurl:data.docs[dp[1]]['image url']?.toString(),skills:data.docs[dp[1]]['skills'] ,
                                  interests: data.docs[dp[1]]['hobbies'],internship: data.docs[dp[1]]['internships'],languages:data.docs[dp[1]]['languages'],highschool: data.docs[dp[1]]['high_school_name'],
                                  highmark: data.docs[dp[1]]['high_school_grade'],secondaryschool: data.docs[dp[1]]['secondary_school_name'],secondarymark: data.docs[dp[1]]['secondary_scholol_grade'],
                                  phone: data.docs[dp[1]]['phone'],projects: data.docs[dp[1]]['project'],college: data.docs[dp[1]]['collage_name'],collegemark: data.docs[dp[1]]['collage_grade'],),
                                CardView(name:data.docs[dp[2]]['name'],text: filtered_lst[2],imgurl:data.docs[dp[2]]['image url']?.toString(),skills:data.docs[dp[2]]['skills'] ,
                                  interests: data.docs[dp[2]]['hobbies'],internship: data.docs[dp[2]]['internships'],languages:data.docs[dp[2]]['languages'],highschool: data.docs[dp[2]]['high_school_name'],
                                  highmark: data.docs[dp[2]]['high_school_grade'],secondaryschool: data.docs[dp[2]]['secondary_school_name'],secondarymark: data.docs[dp[2]]['secondary_scholol_grade'],
                                  phone: data.docs[dp[2]]['phone'],projects: data.docs[dp[2]]['project'],college: data.docs[dp[2]]['collage_name'],collegemark: data.docs[dp[2]]['collage_grade'],),

                              ],
                              onCardSwiped: (dir, index, widget) {
                                //Add the next card
                                if (counter < filtered_lst.length) {
                                  _cardController.addItem(CardView(name:data.docs[dp[counter]]['name'],text: filtered_lst[counter],imgurl:data.docs[dp[counter]]['image url']?.toString(),skills:data.docs[dp[counter]]['skills'] ,
                                    interests: data.docs[dp[counter]]['hobbies'],internship: data.docs[dp[counter]]['internships'],languages:data.docs[dp[counter]]['languages'],highschool: data.docs[dp[2]]['high_school_name'],
                                    highmark: data.docs[dp[counter]]['high_school_grade'],secondaryschool: data.docs[dp[counter]]['secondary_school_name'],secondarymark: data.docs[dp[counter]]['secondary_scholol_grade'],
                                    phone: data.docs[dp[counter]]['phone'],projects: data.docs[dp[counter]]['project'],college: data.docs[dp[counter]]['collage_name'],collegemark: data.docs[dp[counter]]['collage_grade'],),
                                  );
                                  counter++;
                                }
                                if (dir == Direction.left) {
                                  print('onDisliked ${(widget as CardView).text} $index');
                                  arr.add((widget as CardView).text);
                                  users
                                      .doc(_auth.currentUser.email)
                                      .update({
                                    'saccept':arr,
                                  })
                                      .then((value) => print("User Added"))
                                      .catchError((error) => print("Failed to add user: $error"));
                                  FirebaseFirestore.instance.collection('users').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      List<dynamic> value = documentSnapshot.get("dislikecompany");
                                      value.add(datas['email']);
                                      students
                                          .doc(filtered_lst[index])
                                          .update({
                                        'dislikecompany': value,
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
                                  users.doc(_auth.currentUser.email).update({
                                    'saccept':arr,
                                  }).then((value) => print("User Added"))
                                      .catchError((error) => print("Failed to add user: $error"));
                                  FirebaseFirestore.instance.collection('users').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      List<dynamic> value = documentSnapshot.get("likecompany");
                                      value.add(datas['email']);
                                      students
                                          .doc(filtered_lst[index])
                                          .update({
                                        'likecompany': value,
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

                            new SwipeableCardsSection(
                              cardController: _cardController,
                              context: context,
                              //add the first 3 cards
                              items: [
                                CardView(name:data.docs[dp[0]]['name'],text: filtered_lst[0],imgurl:data.docs[dp[0]]['image url']?.toString(),skills:data.docs[dp[0]]['skills'] ,
                                  interests: data.docs[dp[0]]['hobbies'],internship: data.docs[dp[0]]['internships'],languages:data.docs[dp[0]]['languages'],highschool: data.docs[dp[0]]['high_school_name'],
                                  highmark: data.docs[dp[0]]['high_school_grade'],secondaryschool: data.docs[dp[0]]['secondary_school_name'],secondarymark: data.docs[dp[0]]['secondary_scholol_grade'],
                                  phone: data.docs[dp[0]]['phone'],projects: data.docs[dp[0]]['project'],college: data.docs[dp[0]]['collage_name'],collegemark: data.docs[dp[0]]['collage_grade'],),
                                CardView(name:data.docs[dp[1]]['name'],text: filtered_lst[1],imgurl:data.docs[dp[1]]['image url']?.toString(),skills:data.docs[dp[1]]['skills'] ,
                                  interests: data.docs[dp[1]]['hobbies'],internship: data.docs[dp[1]]['internships'],languages:data.docs[dp[1]]['languages'],highschool: data.docs[dp[1]]['high_school_name'],
                                  highmark: data.docs[dp[1]]['high_school_grade'],secondaryschool: data.docs[dp[1]]['secondary_school_name'],secondarymark: data.docs[dp[1]]['secondary_scholol_grade'],
                                  phone: data.docs[dp[1]]['phone'],projects: data.docs[dp[1]]['project'],college: data.docs[dp[1]]['collage_name'],collegemark: data.docs[dp[1]]['collage_grade'],),
                                 ],
                              onCardSwiped: (dir, index, widget) {
                                if (dir == Direction.left) {
                                  print('onDisliked ${(widget as CardView).text} $index');
                                  arr.add((widget as CardView).text);
                                  users
                                      .doc(_auth.currentUser.email)
                                      .update({
                                    'saccept':arr,
                                  })
                                      .then((value) => print("User Added"))
                                      .catchError((error) => print("Failed to add user: $error"));
                                  FirebaseFirestore.instance.collection('users').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      List<dynamic> value = documentSnapshot.get("dislikecompany");
                                      value.add(datas['email']);
                                      students
                                          .doc(filtered_lst[index])
                                          .update({
                                        'dislikecompany': value,
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
                                  users.doc(_auth.currentUser.email).update({
                                    'saccept':arr,
                                  }).then((value) => print("User Added"))
                                      .catchError((error) => print("Failed to add user: $error"));
                                  FirebaseFirestore.instance.collection('users').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      List<dynamic> value = documentSnapshot.get("likecompany");
                                      value.add(datas['email']);
                                      students
                                          .doc(filtered_lst[index])
                                          .update({
                                        'likecompany': value,
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
                              new SwipeableCardsSection(
                                cardController: _cardController,
                                context: context,
                                //add the first 3 cards
                                items: [
                                  CardView(name:data.docs[dp[0]]['name'],text: filtered_lst[0],imgurl:data.docs[dp[0]]['image url']?.toString(),skills:data.docs[dp[0]]['skills'] ,
                                    interests: data.docs[dp[0]]['hobbies'],internship: data.docs[dp[0]]['internships'],languages:data.docs[dp[0]]['languages'],highschool: data.docs[dp[0]]['high_school_name'],
                                    highmark: data.docs[dp[0]]['high_school_grade'],secondaryschool: data.docs[dp[0]]['secondary_school_name'],secondarymark: data.docs[dp[0]]['secondary_scholol_grade'],
                                    phone: data.docs[dp[0]]['phone'],projects: data.docs[dp[0]]['project'],college: data.docs[dp[0]]['collage_name'],collegemark: data.docs[dp[0]]['collage_grade'],),
                                  ],
                                onCardSwiped: (dir, index, widget) {
                                  if (dir == Direction.left) {
                                    print('onDisliked ${(widget as CardView).text} $index');
                                    arr.add((widget as CardView).text);
                                    users
                                        .doc(_auth.currentUser.email)
                                        .update({
                                      'saccept':arr,
                                    })
                                        .then((value) => print("User Added"))
                                        .catchError((error) => print("Failed to add user: $error"));
                                    FirebaseFirestore.instance.collection('users').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                      if (documentSnapshot.exists) {
                                        List<dynamic> value = documentSnapshot.get("dislikecompany");
                                        value.add(datas['email']);
                                        students
                                            .doc(filtered_lst[index])
                                            .update({
                                          'dislikecompany': value,
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
                                    users.doc(_auth.currentUser.email).update({
                                      'saccept':arr,
                                    }).then((value) => print("User Added"))
                                        .catchError((error) => print("Failed to add user: $error"));
                                    FirebaseFirestore.instance.collection('users').doc(filtered_lst[index]).get().then((DocumentSnapshot documentSnapshot) {
                                      if (documentSnapshot.exists) {
                                        List<dynamic> value = documentSnapshot.get("likecompany");
                                        value.add(datas['email']);
                                        students
                                            .doc(filtered_lst[index])
                                            .update({
                                          'likecompany': value,
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
                            child: Center(child: Text("Applied Students would be shown here",style:TextStyle(
                                fontFamily: 'Assets/Poppins-Bold', fontSize: 22.0, color: Colors.white,)),),),);
                        }
                      return Center(child: CircularProgressIndicator(),);
                      },
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              }
          );
        },
      ),
    );
  }
}
