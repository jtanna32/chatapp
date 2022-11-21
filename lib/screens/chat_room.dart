import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({this.chatRoomId, this.userMap, Key? key}) : super(key: key);

  final String? chatRoomId;
  final Map<String, dynamic>? userMap;

  @override
  _ChatRoomState createState() =>
      _ChatRoomState(userMap: userMap!, chatRoomId: chatRoomId!);
}

class _ChatRoomState extends State<ChatRoom> {
  _ChatRoomState({this.userMap, this.chatRoomId});

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController message = new TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? chatRoomId;
  final Map<String, dynamic>? userMap;

  void onSendMessage() async {
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": message.text,
        "time": FieldValue.serverTimestamp()
      };
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
      message.clear();
    } else {
      print("enter text");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(userMap!['name']),
      ),
      body: Container(
        height: size.height / 1.25,
        width: size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('chatroom')
              .doc(chatRoomId)
              .collection('chats')
              .orderBy('time', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? m = snapshot.data!.docs[index].data() as Map<String, dynamic>?;
                    return messagesList(size, m);
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height / 10,
        width: size.width,
        alignment: Alignment.center,
        child: Container(
          height: size.height / 12,
          width: size.width / 1.1,
          child: Row(
            children: [
              Container(
                height: size.height / 12,
                width: size.width / 1.5,
                child: TextField(
                  controller: message,
                  decoration: InputDecoration(
                      hintText: "Enter message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSendMessage();
                  },
                  icon: Icon(Icons.send))
            ],
          ),
        ),
      ),
    );
  }

  Widget messagesList(Size size, var map) {
    print(map['sendby']);
    return Container(
      alignment: map['sendby'] == _auth.currentUser!.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: map['sendby'] == _auth.currentUser!.displayName ? Colors.blue : Colors.grey
        ),
        child: Text(
          map['message'],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
