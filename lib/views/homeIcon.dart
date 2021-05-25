import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_application/views/feed_details.dart';
import 'package:recipe_application/widget/basic_overlay_widget.dart';
import 'dart:math';

import 'package:video_player/video_player.dart';

int randomNumber = 0;

TextEditingController textController = null;
VideoPlayerController controller;
String url = null;
String typeString = null;

class Home extends StatefulWidget {
  // String barName;
  // Feed({this.barName});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream publishedRecipe;
  Stream randomResult;
  List numberofRecipe;
  String emailforDetail;
  String recipeforDetail;
  String imageforDetail;
  Stream churva;
  int please;
  Stream b, l, s, d;

  List<String> breakfast = [
    'salad',
    'beverage',
    'breakfast food',
    'sandwiches',
    'vegetarian cuisine'
  ];
  List<String> lunch = [
    'pastries and desserts',
    'main dishes',
    'bouillons',
    'sauces',
    'beverage',
    'lunch cuisine',
    'vegetarian cuisine'
  ];
  List<String> snack = [
    'snacks',
    'beverage',
    'sandwiches',
    'finger food',
    'vegetarian cuisine'
  ];
  List<String> dinner = [
    'salad',
    'sauces',
    'beverage',
    'dinner style',
    'vegetarian cuisine'
  ];

  Widget Food(Stream food) {
    return StreamBuilder(
        stream: food,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? PageView.builder(
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

  Widget RecipeList(int value) {
    return StreamBuilder(
        stream: publishedRecipe,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return index == value
                        ? GestureDetector(
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
                          )
                        : Container();
                  },
                )
              : Container();
        });
  }

  Widget ResultValue() {
    return StreamBuilder(
      stream: randomResult,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? RecipeList(snapshot.data.docs[0].data()['random'])
            : Container();
      },
    );
  }

  Widget newww() {
    return StreamBuilder(
      stream: churva,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container()
            //snapshot.data.docs.length
            : 0;
      },
    );
  }

  randomize() {
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    Random random = new Random();

    randomNumber = random.nextInt(2);
    print(randomNumber);
    Map<String, dynamic> recipeMap = {'date': date, 'random': randomNumber};
    databaseMethods.recipeOfTheDay(date, recipeMap);
    print('niabot ari');
  }

  @override
  void initState() {
    int flag = 0;
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    print(date);

    randomize();
    databaseMethods.checkRandom(date).then((result) {
      churva = result;
      // int valuessss=newww();
      //print(valuessss);
      if (churva.first == null) {
        setState(() {
          randomize();
          databaseMethods.getRecipe().then((result) {
            setState(() {
              print('talerrrrr');
              // databaseMethods.getRandom(date).then((result) {
              //   //setState(() {
              //     randomResult = result;
              //   //});
              // });
              publishedRecipe = result;
            });
          });
        });
      } else {
        setState(() {
          databaseMethods.getRecipe().then((result) {
            setState(() {
              print('notche buena');
              databaseMethods.getRandom(date).then((result) {
                setState(() {
                  randomResult = result;
                });
              });
              ////Stream<QuerySnapshot> snapshots;
              publishedRecipe = result;
            });
          });
        });
      }
    });

    databaseMethods.getFood(breakfast).then((result) {
      setState(() {
        b = result;
      });
    });
    databaseMethods.getFood(lunch).then((result) {
      setState(() {
        l = result;
      });
    });
    databaseMethods.getFood(snack).then((result) {
      setState(() {
        s = result;
      });
    });
    databaseMethods.getFood(dinner).then((result) {
      setState(() {
        d = result;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
          backgroundColor: Colors.indigo[300],
          title: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Recipe of the Day',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[400],
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(1, 4),
                        blurRadius: 1),
                    Shadow(
                        color: Colors.indigo[200],
                        offset: Offset(2, 1),
                        blurRadius: 2),
                  ]),
            ),
            SingleChildScrollView(
                child: Column(
              children: [
                Container(height: 500, child: ResultValue()),
                Column(
                  children: [
                    Text("Breakfast".toUpperCase(),
                  style: TextStyle(
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20.0,),
                ),
                    Container(height: 500, child: Food(b)),
                  ],
                ),
                Column(
                  children: [
                   Text("Lunch".toUpperCase(),
                  style: TextStyle(
                   color: Colors.indigo[400],
                   fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20.0,),
                ),
                    Container(height: 500, child: Food(l)),
                  ],
                ),
                Column(
                  children: [
                   Text("Snack".toUpperCase(),
                  style: TextStyle(
                 color: Colors.indigo[400],
                 fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20.0,),
                ),
                    Container(height: 500, child: Food(s)),
                  ],
                ),
                Column(
                  children: [
                   Text("Dinner".toUpperCase(),
                  style: TextStyle(
                  color: Colors.indigo[400],
                  fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20.0,),
                ),
                    Container(height: 500, child: Food(d)),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
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
        user = result;
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                margin: const EdgeInsets.all(12.0),
                elevation: 10,
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
                              alignment: Alignment.topLeft, child: Userneym()),
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
                                          aspectRatio:
                                              controller.value.aspectRatio,
                                          child: Image.network(widget.image))
                                      : Container(
                                          // color: Colors.green,
                                          alignment: Alignment.topCenter,
                                          child: buildVideo()),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Recipe Name: " + widget.foodName,
                              style: TextStyle(
                                color: Colors.grey[850],
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]
            // MO EAT SAKOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
            ),
      ),
    );
  }
}
