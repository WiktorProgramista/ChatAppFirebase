import 'package:chat_app/chat_page.dart';
import 'package:chat_app/login_page.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Service {

  final auth = FirebaseAuth.instance;

  void createUser(context, email, password) async {

    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatPage()));
      });
    }catch(e){
      erroBox(context, e);
    }
  }

  void loginUser(context, email, password) async {

    try{
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatPage()));
      });
    }catch(e){
      erroBox(context, e);
    }
  }

  void signOut(context) async {

    try{
      await auth.signOut().then((value) => 
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginPage()), 
        (route) => false));
    }catch(e){
      erroBox(context, e);
    }
  }

  void erroBox(context, e) {

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("error"),
        content: Text(e.toString()),
      );
    });
  }


}