import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:js1/Screens/Student registration/sregistration.dart';
void main() => runApp(MaterialApp(
  home: studentregistration(),
  debugShowCheckedModeBanner: false,
));

class studentregistration extends StatefulWidget {
  @override
  MystudentregistrationState createState() => MystudentregistrationState();
}
class MystudentregistrationState extends State<studentregistration> {
  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );
  DateTime selectedDate = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name, email, password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => sregistration()));
      }
    });
  }
  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {
          await _auth.currentUser.updateProfile(displayName: name);
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    //ScreenUtil.instance =ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(750, 1334),
        orientation: Orientation.portrait);
    return Scaffold(
        backgroundColor: Color(0xFF131313),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Image.asset('Assets/image_02.png'),
              ],
            ),
            SingleChildScrollView(
                child: Padding(
                    padding:
                    EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'Assets/logo.png',
                              width: ScreenUtil().setWidth(110),
                              height: ScreenUtil().setHeight(110),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('JOB SQUARE',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(46),
                                  letterSpacing: .6,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(180),
                        ),
                        Container(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(650),
                            decoration: BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(2.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0,
                                ),
                                BoxShadow(
                                  color: Colors.white12,
                                  offset: Offset(0.0, -10.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      'Registration Portal For JOBSQAURE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(45),
                                        fontFamily: 'Poppins-Bold',
                                        letterSpacing: .6,
                                      )
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  Container(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) return 'Enter Name';
                                                },
                                                style: TextStyle(color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText: 'Name',
                                                    hintStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                                                    prefixIcon: Icon(Icons.person_add,color: Colors.white,)),
                                                onSaved: (input) => name = input),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(50),
                                          ),
                                          Container(
                                            child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) return 'Enter Email';
                                                },
                                                style: TextStyle(color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText: 'email',
                                                    hintStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                                                    prefixIcon: Icon(Icons.email,color: Colors.white,)),
                                                onSaved: (input) => email = input),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(50),
                                          ),
                                          Container(child: TextFormField(
                                              validator: (input) {
                                                if (input.length < 6)
                                                  return 'Provide Minimum 6 Character';
                                              },
                                              style: TextStyle(color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: 'password',
                                                hintStyle: TextStyle(color: Colors.white, fontSize: 15.0 ),
                                                prefixIcon: Icon(Icons.lock,color: Colors.white,),
                                              ),
                                              obscureText: true,
                                              onSaved: (input) => password = input),

                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: ScreenUtil().setHeight(35),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(width: ScreenUtil().setWidth(10),),
                            FlatButton(
                              padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                              onPressed: signUp,
                              child: Text('Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins-Bold',
                                    fontSize: 20.0,
                                    letterSpacing: 1.0),),
                              color: Color(0xF0CC3A3B),
                              height: ScreenUtil().setHeight(80),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                      ],
                    ))),
          ],
        ));
  }
}
