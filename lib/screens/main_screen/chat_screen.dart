import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khushi_creation/screens/chat/message_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat Screen"),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading....');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _builderListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _builderListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen(
              receiveUserName: data['name'],
              receiveUserEmail: data['email'],
              receiveUserID: data['uid'],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
