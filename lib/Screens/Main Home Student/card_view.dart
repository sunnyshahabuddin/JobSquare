import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key key,
    this.text = "Card View",this.role = "Card View",this.offer = "Card View",this.treq = "Card View",this.bacthes = "Card View",
    this.name = "Card View",this.cgpa = "Card View",this.allowance = "Card View",this.website = "Card View",this.about = "Card View",this.phone = "Card View",
    this.imgurl = "Card View",
  }) : super(key: key);
  final String text, name, role,offer,treq,bacthes,cgpa,allowance,website,phone,about,imgurl;
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
                                Container(
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
                                            role,
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
                                           offer,
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
                               treq,
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
                                bacthes,
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
                                cgpa,
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
                                allowance,
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
                                "Website",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18.0,
                                  letterSpacing: 0.9,
                                  fontFamily: 'Assets/Poppins-Bold',
                                ),
                              ),
                              subtitle: Text(
                                website,
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
                                about,
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
        ),
      )
    );
  }
}