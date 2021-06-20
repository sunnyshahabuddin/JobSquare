import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:js1/Screens/Main Home Student/StudentSwipeCard.dart';
void main() => runApp(MaterialApp(
      home: sregistration(),
      debugShowCheckedModeBanner: false,
    ));
class sregistration extends StatefulWidget {
  @override
  MySregistrationState createState() => MySregistrationState();
}
class MySregistrationState extends State<sregistration> {
  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
  DateTime selectedDate = DateTime.now();
  String languages, email, name, project, skills, internships,father, hobbies, github, high_school_name, high_school_grade, secondary_school_name, secondary_scholol_grade, collage_name, collage_grade,phone;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  SaveDetails() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
    email = _auth.currentUser.email;
    name = _auth.currentUser.displayName;
    addUser();
    Navigator.pop(context,true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyStudentCard()));
  }

  String imageUrl;
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot =
            await _storage.ref().child(_auth.currentUser.email).putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
  List<String> arr=[];
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(_auth.currentUser.email)
        .set({
          'email': email,
          'name': name,
          'image url': imageUrl,
          'languages': languages,
          'project': project,
          'high_school_name': high_school_name,
          'high_school_grade': high_school_grade,
          'secondary_school_name': secondary_school_name,
          'secondary_scholol_grade': secondary_scholol_grade,
          'collage_name': collage_name,
          'collage_grade': collage_grade,
          'skills': skills,
          'internships': internships,
          'hobbies': hobbies,
          'github': github,
          'notshow':arr,
          'likecompany':arr,
          'phone':phone,
          'dislikecompany':arr,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
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
    return !isloggedin
        ? Center(child: CircularProgressIndicator()):Scaffold(
        backgroundColor: Color(0xFF131313),
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Image.asset(
                'Assets/logo.png',
              ),
            ),
          ),
          backgroundColor: Color(0xFF131313),
          title: Text('JOB SQUARE',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(40),
                fontFamily: 'Poppins-Bold',
                letterSpacing: 6,
              )),
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
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil().setHeight(1),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('It is Just a One Time Process',
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
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Enter Your Skills',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => skills = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Hobbies',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => hobbies = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Father name',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => father = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Project Description',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => project = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Internship Details',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => internships = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'High School name',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) =>
                                          high_school_name = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'High School Percentage',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) =>
                                          high_school_grade = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Secondary School Name',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) =>
                                          secondary_school_name = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Secondary school Percentage',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) =>
                                          secondary_scholol_grade = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'College Name',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => collage_name = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'College CGPA',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => collage_grade = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                      decoration: InputDecoration(
                                          hintText: 'Languages',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => languages = input,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                      decoration: InputDecoration(
                                          hintText: 'Phone Number',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => phone = input,
                                      scrollPadding:
                                      EdgeInsets.only(bottom: 40),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                      decoration: InputDecoration(
                                          hintText: 'github handle',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                      onSaved: (input) => github = input,
                                      scrollPadding:
                                          EdgeInsets.only(bottom: 40),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: (imageUrl != null)
                                  ? Image.network(imageUrl)
                                  : Image.asset('Assets/Dummy.png'),
                              height: 150,
                              width: 700,
                            ),
                            RaisedButton(
                              child: Text(
                                'Upload Image',
                                style: TextStyle(color: Colors.black),
                              ),
                              color: Colors.white,
                              onPressed: () => uploadImage(),
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
                          SizedBox(
                            width: ScreenUtil().setWidth(10),
                          ),
                          FlatButton(
                            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                            onPressed: SaveDetails,
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Bold',
                                  fontSize: 20.0,
                                  letterSpacing: 1.0),
                            ),
                            color: Color(0xF0CC3A3B),
                            height: ScreenUtil().setHeight(80),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
