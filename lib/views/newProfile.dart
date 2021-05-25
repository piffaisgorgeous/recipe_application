import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_application/helper/authenticate.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/widget/widget.dart';

import 'displayProfilePub.dart';
import 'package:recipe_application/services/auth.dart';

class NewProfileInfo extends StatefulWidget {
  final String username;
  final String email;
  NewProfileInfo({this.username, this.email});
  @override
  _NewProfileInfoState createState() => _NewProfileInfoState();
}

class _NewProfileInfoState extends State<NewProfileInfo> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream users;

  Widget UsersList() {
    return StreamBuilder(
        stream: users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Text(snapshot.data.docs[0].data()['name'].toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              : Container();
        });
  }

  @override
  void initState() {
    databaseMethods.getUserbyUserEmail(widget.email).then((result) {
      setState(() {
        users = result;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[100],
        appBar: AppBar(
          backgroundColor: Colors.indigo[400],
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Text('Profile'),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: Colors.indigo[200],
                      content: Text(
                        "Are you sure you want to log out?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          minWidth: 12,
                          color: Colors.indigo[400],
                          onPressed: () {
                            authMethods.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Authenticate()));
                            Navigator.of(ctx).pop();
                          },
                          child: Text("YES"),
                        ),
                        FlatButton(
                          minWidth: 12,
                          color: Colors.indigo[400],
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("NO"),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.exit_to_app))),
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 180,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: Colors.blue[400],
                ),
              ),
              //RecipeDetailstwo(),
              UsersList(),
              //  Text(widget.username,
              //   style: TextStyle(
              //     fontSize: 20, fontWeight: FontWeight.bold
              //   ),),
              SizedBox(height: 15),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "35",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "YOUTUBE : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Recipe Channel",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "I am ambitious and driven. I thrive on challenge and constantly set goals for myself, so I have something to strive toward. I'm not comfortable with settling, and I'm always looking for an opportunity to do better and achieve greatness. ",
                  maxLines: 20,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 19, fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    log("chu" + widget.username.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePub(
                                  username: widget.username,
                                  email: widget.email,
                                )));
                  },
                  child: containerDecoration("PUBLICATION")), // IWIT SAKA
            ],
          ),
        ));
  }
}
