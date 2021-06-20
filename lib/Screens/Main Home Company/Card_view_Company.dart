import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CardView extends StatelessWidget {
  const CardView({
    Key key,
    this.text = "Card View Company",this.name = "Card View Company",this.phone = "Card View Company",
    this.imgurl = "Card View Company",this.languages = "Card View Company",
    this.skills="Card View Company",this.interests="Card View Company",this.internship="Card View Company",this.highschool="Card View Company",this.secondaryschool="Card View Company",
    this.college="Card View Company",this.projects="Card View Company",this.secondarymark="Card View Company",this.highmark="Card View Company",this.collegemark="Card View Company",
  }) : super(key: key);
  final String text, name,phone,imgurl,languages;
  final String skills,interests,highschool,secondaryschool,college,internship,projects,secondarymark,highmark,collegemark;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF121212),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF383838).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Scaffold(
            backgroundColor: Color(0xFF131313),
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
                                            name,
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
                                      image: NetworkImage(imgurl),
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
                                    text: highschool+"  ",
                                    style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: highmark,
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
                                    text: secondaryschool+"  ",
                                    style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: secondarymark,
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
                                    text: college+"  ",
                                    style: TextStyle(color: Colors.white, fontSize: 15.0,  letterSpacing: 0.9,
                                      fontFamily: 'Assets/Poppins-Bold',),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: collegemark,
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
                                  projects,
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
                                 internship,
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
                                  text,
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
                                  phone,
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
                                  skills,
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
                                  languages,
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
                                  interests,
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
          ),
        )
    );
  }
}