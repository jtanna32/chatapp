import 'package:chatappdemo/methods.dart';
import 'package:chatappdemo/screens/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userMap;
  TextEditingController search = new TextEditingController();
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore
        .collection('users')
        .where("email", isEqualTo: search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        setState(() {
          isLoading = false;
        });
        print(userMap);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                logOut(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: search,
                          decoration: InputDecoration(
                              hintText: "Search",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        onSearch();
                      },
                      child: Text(
                        "Search User",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    userMap == null
                        ? Container()
                        : InkWell(
                            onTap: () {
                              var chatId = chatRoomId(
                                  _auth.currentUser!.displayName!,
                                  userMap!['name']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatRoom(
                                            chatRoomId: chatId,
                                            userMap: userMap,
                                          )));
                            },
                            child: ListTile(
                              leading:
                                  Icon(Icons.account_box, color: Colors.black),
                              title: Text(
                                userMap!['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              subtitle: Text(userMap!['email']),
                              trailing: Icon(Icons.chat, color: Colors.black),
                            ),
                          )
                  ],
                ),
        ),
      ),
    );
  }
}
