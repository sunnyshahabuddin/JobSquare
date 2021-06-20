import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:js1/Screens/Main Home Company/CompanyHome.dart';
void main() => runApp(MaterialApp(
      home: register_recruiter(),
      debugShowCheckedModeBanner: false,
    ));

class register_recruiter extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<register_recruiter> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
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
  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  String email,name,website,phone,about;
  String img,role,offer,allowance,techreq,batches,mincgpa;
  String imageUrl;
  @override
  SaveDetails()
  {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();}
    email=_auth.currentUser.email;
    name=_auth.currentUser.displayName;
    addUser();
    Navigator.pop(context,true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyCompanyHome()));
  }
  CollectionReference users = FirebaseFirestore.instance.collection('company');
  List<String> arr=[];
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(_auth.currentUser.email)
        .set({
      'email':email,
      'name':name,
      'role':role,
      'offer':offer,
      'allowance':allowance,
      'Technical Requirement':techreq,
      'Eligible Batches':batches,
      'Minimum CGPA':mincgpa,
      'image url': imageUrl,
      'slike':arr,
      'saccept':arr,
      'sdislike':arr,
      'phone':phone,
      'website':website,
      'about':about,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted){
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null){
        var snapshot = await _storage.ref()
            .child(_auth.currentUser.email)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl=downloadUrl;
        });
      }
      else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
  @override
  void initState() {
    super.initState();
    this.getUser();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(750, 1334),
        orientation: Orientation.portrait);

    return  !isloggedin
        ? Center(child: CircularProgressIndicator())
        :  Scaffold(
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
              'JOB SQUARE',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(40),
                fontFamily: 'Poppins-Bold',
                letterSpacing: .6,
              )
          ),
        ),
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
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Registration For Recruiters',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(45),
                                    fontFamily: 'Poppins-Bold',
                                    letterSpacing: .6,
                                  )),
                              SizedBox(
                                height: ScreenUtil().setHeight(30),
                              ),
                              Container(
                                child: Form(
                                  key: formKey ,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Role',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>role=input,
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(30),
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Offer',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>offer=input,
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(30),
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Allowance',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>allowance=input,
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(30),
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Technical Requirements',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>techreq=input,
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(30),
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Batches Eligible',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>batches=input,
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(30),
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Minimum CGPA Required ',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>mincgpa=input,
                                      ),TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Phone Number',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>phone=input,
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'Website',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>website=input,
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white,fontSize: 15.0),
                                        decoration: InputDecoration(
                                            hintText: 'About',
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0)),
                                        onSaved: (input)=>about=input,
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(30),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: (imageUrl != null)
                                    ? Image.network(imageUrl)
                                    : Image.asset('Assets/company.png'),
                                height: 150,
                                width: 700,

                              ),
                              RaisedButton(
                                child: Text('Upload Image',
                                  style: TextStyle(color: Colors.black),),
                                color: Colors.white,
                                onPressed: () =>uploadImage(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(35),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: ScreenUtil().setWidth(12.0),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(8.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(width: ScreenUtil().setWidth(10),),
                            FlatButton(
                              padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                              onPressed: SaveDetails,
                              child: Text('REGISTER',
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
        )
        );
  }
}
