// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore

import 'package:chat_app_push_notification/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (context, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          // ignore: prefer_const_constructors
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy(
                "createAt",
                descending: true,
              )
              .snapshots(),
          builder: (context, AsyncSnapshot chatSnapShot) {
            if (chatSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapShot.data.docs;

            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]["text"],
                chatDocs[index]["userId"] == futureSnapShot.data.uid,
                // key: ValueKey(chatDocs[index]FieldPath.documentId),
              ),
            );
          },
        );
      },
    );
  }
}
