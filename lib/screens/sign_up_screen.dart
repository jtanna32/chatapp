import 'package:chatappdemo/methods.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "SignUp Screen"
        ),
      ),
      body: Container(
        child: Center(
          child: isLoading ? CircularProgressIndicator() : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height/15,
                  width: MediaQuery.of(context).size.width/1.3,
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height/15,
                width: MediaQuery.of(context).size.width/1.3,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height/15,
                width: MediaQuery.of(context).size.width/1.3,
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  onPressed: (){
                      if(name.text.isNotEmpty && password.text.isNotEmpty && email.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        createAccount(name.text, email.text, password.text).then((user){
                          if(user != null) {
                              setState(() {
                                isLoading = false;
                              });
                              print("account created successfully");
                          } else {
                            print("Sign up failed");
                          }
                        });
                      } else {
                        print("Please enter fields");
                      }
                  },
                  color: Colors.blue,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.blue
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }
}
