import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/widget/widget.dart';

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
  String uname;
  Widget RecipeDetailstwo() {
    return StreamBuilder(
        stream: email,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    uname = snapshot.data.docs[index]
                        .data()['user_name']
                        .toString();
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data.docs[index]
                                  .data()['user_name']
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "email",
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic),
                            ),
                            SizedBox(height: 8),
                            Text(
                              snapshot.data.docs[index]
                                  .data()['email']
                                  .toString()
                                  .toLowerCase(),
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
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
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
          backgroundColor: Colors.indigo[400],
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          )),
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            RecipeDetailstwo(),
            Container(
              //margin: EdgeInsets.only(bottom: 200),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "35",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "IG : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@" + uname,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FACEBOOK : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@" + uname,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "I am ambitious and driven. I thrive on challenge and constantly set goals for myself, so I have something to strive toward. I'm not comfortable with settling, and I'm always looking for an opportunity to do better and achieve greatness. ",
                maxLines: 20,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 19),
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
                child: containerDecoration("ABOUT")),
          ],
        ),
      ),
    );
  }
}
