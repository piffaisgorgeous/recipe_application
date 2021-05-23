import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';

import 'displayProfilePub.dart';

class Profilet extends StatefulWidget {
  String username;
  String email;

  Profilet({this.username, this.email});
  @override
  _ProfiletState createState() => _ProfiletState();
}

class _ProfiletState extends State<Profilet> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream email;

  Widget RecipeDetailstwo() {
    return StreamBuilder(
        stream: email,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount:snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return 
                    Container(
                      margin: EdgeInsets.only(bottom: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                               snapshot.data.docs[index]
                                  .data()['user_name']
                                  .toString(),
                                style: TextStyle(
                                    fontSize: 21.5, fontWeight: FontWeight.normal),
                              ),
                        ],
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  @override
  void initState() {
    databaseMethods
        .getUserPublish(widget.email, widget.username)
        .then((result) {
      setState(() {
        log('taler');
        email = result;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[200],
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
      children: [
      RecipeDetailstwo(),
          FlatButton(
                onPressed: () {
                  log("chu" +widget.username.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePub(
                              username: widget.username, email: widget.email, )));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "35",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Text(
                        "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Text(
                        "1M",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Publications",
                        style: TextStyle(fontSize: 16),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Text(
                        "Following",
                        style: TextStyle(fontSize: 16),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Text(
                        "Followers",
                        style: TextStyle(fontSize: 16),
                      ),
                      
                    
                      
                    ],
                  ),
                    ],
                
                  ),
                ),
       
          )],
    ),
        ));
  }
}
