import 'package:chat_app/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import "package:flutter/material.dart";

class ShowMessages extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Messages").orderBy("time").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, i){
            QueryDocumentSnapshot x = snapshot.data!.docs[i];
            return ListTile(
              title: Column(
                crossAxisAlignment: loginUser!.email == x['user'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: loginUser!.email == x['user'] ? Colors.blue.withOpacity(0.2) : Colors.purple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Text(x['messages']),
                        Text(x['user'], style: TextStyle(fontSize: 10),),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}