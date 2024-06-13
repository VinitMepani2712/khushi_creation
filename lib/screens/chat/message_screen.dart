import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
    final String receiveUserEmail;
    final String receiveUserName;
    final String receiveUserID;

  MessageScreen({super.key, required this.receiveUserEmail, required this.receiveUserID, required this.receiveUserName});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiveUserName),),
    );
  }
}
