import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DatabaseManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getUsersList() async {
    return FirebaseFirestore.instance.collection('company').get();
  }
  Future<QuerySnapshot<Map<String, dynamic>>> getUsersListStudent() async {
    return FirebaseFirestore.instance.collection('users').get();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> getuid() async{
    return FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.email).get();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> getcompuid() async{
    return FirebaseFirestore.instance.collection('company').doc(_auth.currentUser.email).get();
  }
  Stream<DocumentSnapshot> getcompany(){
    return FirebaseFirestore.instance.collection('company').doc(_auth.currentUser.email).snapshots();
  }
  Stream<QuerySnapshot> getc(){
    return FirebaseFirestore.instance.collection('company').snapshots();
  }
  Stream<QuerySnapshot> gets(){
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
  Stream<DocumentSnapshot> getstudent(){
    return FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.email).snapshots();
  }
}