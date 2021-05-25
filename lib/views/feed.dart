import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_application/views/feed_details.dart';
import 'package:recipe_application/widget/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class Feed extends StatefulWidget {
  // String barName;
  // Feed({this.barName});
  @override
  _FeedState createState() => _FeedState();
}

TextEditingController textController = null;
VideoPlayerController controller;
String url = null;
String typeString = null;

class _FeedState extends State<Feed> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream publishedRecipe;
  String emailforDetail;
  String recipeforDetail;
  String imageforDetail;

  Stream user;

  Widget RecipeList() {
    return StreamBuilder(
        stream: publishedRecipe,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? PageView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedDetails(
                                    image: snapshot.data.docs[index]
                                        .data()['upload']
                                        .toString(),
                                    email: snapshot.data.docs[index]
                                        .data()['email']
                                        .toString(),
                                    recipe: snapshot.data.docs[index]
                                        .data()['recipe_name']
                                        .toString(),
                                    foodName: snapshot.data.docs[index]
                                        .data()['recipe_name']
                                        .toString())));
                      },
                      child: CardForRecipe(
                        name: snapshot.data.docs[index]
                            .data()['email']
                            .toString(),
                        image: snapshot.data.docs[index]
                            .data()['upload']
                            .toString(),
                        foodName: snapshot.data.docs[index]
                            .data()['recipe_name']
                            .toString(),
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  @override
  void initState() {
    databaseMethods.getRecipe().then((result) {
      setState(() {
        publishedRecipe = result;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[50],
        appBar: AppBar(
            backgroundColor: Colors.indigo[400],
            title: Text(
              "Feed",
              style: TextStyle(color: Colors.white),
            )),
        body: Container(child: RecipeList()));
  }
}

class CardForRecipe extends StatefulWidget {
  final String name;
  final String image;
  final String foodName;
  CardForRecipe({this.name, this.image, this.foodName});

  @override
  _CardForRecipeState createState() => _CardForRecipeState();
}

class _CardForRecipeState extends State<CardForRecipe> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream user;

  Widget Userneym() {
    return StreamBuilder(
        stream: user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Text(
                  "Publisher: " +
                      snapshot.data.docs[0]
                          .data()['name']
                          .toString()
                          .toUpperCase(),
                  style: TextStyle(
                    color: Colors.indigo[600],
                      fontStyle: FontStyle.italic,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                )
              : Container();
        });
  }

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );

  @override
  void initState() {
    databaseMethods.getUserbyUserEmail(widget.name).then((result) {
      setState(() {
        log("dzai");
        user = result;
        log("dzaaaaai");
        Uri uri = Uri.parse(widget.image);
        typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
        controller = VideoPlayerController.network(widget.image)
          ..addListener(() => setState(() {}))
          ..setLooping(false)
          ..initialize().then((_) => controller.play());
        buildVideo();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          margin: const EdgeInsets.all(12.0),
          elevation: 8,
          color: Colors.indigo[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Container(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    // butanganan(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft, child: Userneym()

                          // Text(
                          //   "Publisher: " + widget.name.toUpperCase(),
                          //   style: TextStyle(
                          //       fontStyle: FontStyle.italic, fontSize: 25.0, fontWeight: FontWeight.bold),
                          // ),
                          ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: typeString == null
                              ? Container(
                                  child: Text("haksog"),
                                )
                              : typeString == "jpg" || typeString == "png"
                                  ? AspectRatio(
                                      aspectRatio: controller.value.aspectRatio,
                                      child: Image.network(widget.image))
                                  : Container(
                                      // color: Colors.green,
                                      alignment: Alignment.topCenter,
                                      child: buildVideo()),
                        )

                        // Container(
                        //   // color: Colors.blue,
                        //   height: 200,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Image.network(image),
                        // ),
                        ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Recipe Name: " + widget.foodName,
                          style: TextStyle(
                             color: Colors.grey[850],
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
