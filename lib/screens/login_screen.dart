import 'package:chatappdemo/methods.dart';
import 'package:chatappdemo/screens/home_screen.dart';
import 'package:chatappdemo/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Login Screen"
        ),
      ),
      body: Container(
        child: Center(
          child: isLoading ? CircularProgressIndicator() : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
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
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
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
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  onPressed: (){
                    if(email.text.isNotEmpty && password.text.isNotEmpty){
                      setState(() {
                        isLoading = true;
                      });
                      login(email.text, password.text).then((user){
                        if(user != null) {
                          setState(() {
                            isLoading = false;
                          });
                          print("Logged in successfully");
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
                        } else {
                          print("User not logged in successfully");
                        }
                      });
                    }
                  },
                  color: Colors.blue,
                  child: Text(
                    "Login",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                },
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      color: Colors.blue
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
