import 'package:chat_app/firebase_helper.dart';
import 'package:chat_app/show_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Service service = Service();

  final auth = FirebaseAuth.instance;

  final storeMessage = FirebaseFirestore.instance;


  getCurrentUser(){
    final user = auth.currentUser;

    if(user!=null){
      loginUser = user;
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override

  TextEditingController msg = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginUser!.email.toString()),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: IconButton(
              onPressed: () async {
                service.signOut(context);
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("email");
              }, 
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ShowMessages()
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(

                  ),
                  child: TextField(
                    controller: msg,
                    decoration: InputDecoration(
                      hintText: "Enter Message",
                      suffixIcon: IconButton(
                        onPressed: () {
                          if(msg.text.isNotEmpty){
                            storeMessage.collection("Messages").doc().set({
                              "messages": msg.text.trim(),
                              "user": loginUser!.email.toString(),
                              "time": DateTime.now(),
                            });
                            msg.clear();
                          }
                        }, 
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}