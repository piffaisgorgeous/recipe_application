import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_application/views/feed_details.dart';
import 'package:recipe_application/widget/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class ProfilePub extends StatefulWidget {
  final String username;
 final  String email;
  ProfilePub({this.username, this.email});

  @override
  _ProfilePubState createState() => _ProfilePubState();
}
TextEditingController textController = null;
VideoPlayerController controller;
String url = null;
String typeString = null;
class _ProfilePubState extends State<ProfilePub> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream publishedRecipe;

  Widget RecipeList() {
    return StreamBuilder(
        stream: publishedRecipe,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
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
                            .data()['user_name']
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
    databaseMethods
        .getUserPublish(widget.email, widget.username)
        .then((result) {
      setState(() {
        publishedRecipe = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            backgroundColor: Colors.indigo[400],
            title: Text(
              'Published Recipe',
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
 setState(() {
      //uploadFile();
      Uri uri = Uri.parse(widget.image);
      typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
      controller = VideoPlayerController.network(widget.image)
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) => controller.play());
        buildVideo();
      //  isMuted = controller.value.volume == 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          color: Colors.indigo[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Container(
              child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 25.0),
                      ),
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
                                    child:  buildVideo()),
                      )
                    // Container(
                    //   // color: Colors.blue,
                    //   height: 200,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Image.network(widget.image),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.foodName,
                        style: TextStyle(
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
    );
  }
}
