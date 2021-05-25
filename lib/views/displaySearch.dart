import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/views/feed_details.dart';
import 'package:recipe_application/views/searchIcon.dart';
import 'package:recipe_application/widget/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class DisplaySearch extends StatefulWidget {
  final List<String> category;
  DisplaySearch({this.category});
  @override
  _DisplaySearchState createState() => _DisplaySearchState();
}

TextEditingController textController = null;
VideoPlayerController controller;
String url = null;
String typeString = null;

class _DisplaySearchState extends State<DisplaySearch> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream searchedRecipe;
  List<String> categoryFromFirebase;

  Widget RecipeList() {
    return StreamBuilder(
        stream: searchedRecipe,
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
    databaseMethods.getSearchedRecipe(widget.category).then((result) {
      setState(() {
        searchedRecipe = result;
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
              'Feed',
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
  Stream n;

  Widget Neym() {
    return StreamBuilder(
        stream: n,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Text(
                  snapshot.data.docs[0].data()['name'].toString().toUpperCase(),
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20.0,
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
        n = result;
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
                    child: Align(alignment: Alignment.topLeft, child: Neym()),
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
                                    alignment: Alignment.topCenter,
                                    child: buildVideo()),
                      )),
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

class DisplaySearchRecipe extends StatefulWidget {
  final String recipeName;
  DisplaySearchRecipe({this.recipeName});
  @override
  _DisplaySearchRecipeState createState() => _DisplaySearchRecipeState();
}

class _DisplaySearchRecipeState extends State<DisplaySearchRecipe> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream searchedRecipe;

  Widget Recipe() {
    return StreamBuilder(
        stream: searchedRecipe,
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
    databaseMethods.getSpecificRecipe(widget.recipeName).then((result) {
      setState(() {
        searchedRecipe = result;
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
            widget.recipeName,
            style: TextStyle(color: Colors.white),
          )),
      body: Container(
        child: Recipe(),
      ),
    );
  }
}
