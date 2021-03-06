import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_application/helper/helperfunctions.dart';
import 'package:recipe_application/services/auth.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/views/home.dart';
// import 'package:recipe_application/views/chatRoomsScreen.dart';
import 'package:recipe_application/widget/widget.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  singIn() async {
    String username;
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailEditingController.text);

      databaseMethods
          .getUserbyUserEmail(emailEditingController.text)
          .then((result) {
        snapshotUserInfo = result;
        username= snapshotUserInfo.docs[0].data()["name"];
        log(username);
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
            
            print("last"+username);
      });
      setState(() {
        isLoading = true;
      });

      await authMethods
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) {
         if (result != null) {
           
         
          HelperFunctions.saveUserLoggedInSharedPreference(true);
           setState(() {
              //username= snapshotUserInfo.docs[0].data()["name"];
           });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BottomNav(
                userName:username, userEmail: emailEditingController.text
              )));
             print(username);
         }
      });
         
        
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // appBar: appBarMain(context),
        body: SafeArea(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
            Colors.indigoAccent[100],
            Colors.indigo,
          ])),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  Text(
                      "Wait For A While", 
                      style: biggerTextStyle())
                ],
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please Enter Correct Email";
                            },
                            controller: emailEditingController,
                            style: simpleTextStyle(),
                            decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.indigo[800],
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: 'Email',
    hintStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontStyle: FontStyle.italic,
    ),
  )
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Password must be 6 above characters";
                            },
                            style: simpleTextStyle(),
                            controller: passwordEditingController,
                            decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.indigo[800],
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText:'Password',
    hintStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontStyle: FontStyle.italic,
    ),
  )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        singIn();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ],
                            )),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Sign In",
                          style: biggerTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          style: simpleTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Register Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0)
                      ],
                    ),
                  ],
                ),
              ),
      ),
    )));
  }
}
