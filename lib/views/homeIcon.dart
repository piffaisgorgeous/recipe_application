import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_application/views/feed_details.dart';
import 'dart:math';

int randomNumber;

class Home extends StatefulWidget {
  // String barName;
  // Feed({this.barName});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream publishedRecipe;
  List numberofRecipe;
  String emailforDetail;
  String recipeforDetail;
  String imageforDetail;

  Widget RecipeList() {
    return StreamBuilder(
        stream: publishedRecipe,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return index == randomNumber
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
                                  .data()['user_name']
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

  randomize() {
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    Random random = new Random();
    databaseMethods.getRecipe().then((result) {
      setState(() {
        numberofRecipe = result;
      });
    });

    randomNumber = random.nextInt(1);
    print(randomNumber);
    Map<String, dynamic> recipeMap = {'date': date, 'random': randomNumber};
    databaseMethods.recipeOfTheDay(date, recipeMap);
  }

  @override
  void initState() {
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    databaseMethods.getrecipeOfTheDay(date).then((result) {
      if (result == null) {
        setState(() {
          randomize();
          databaseMethods.getRecipe().then((result) {
            setState(() {
              publishedRecipe = result;
            });
          });
        });
      } else {
        setState(() {
          databaseMethods.getRecipe().then((result) {
            setState(() {
              publishedRecipe = result;
            });
          });
        });
      }
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
              "Feed",
              style: TextStyle(color: Colors.white),
            )),
        body: Container(
          child: RecipeList(),
        ));
  }
}

class CardForRecipe extends StatelessWidget {
  final String name;
  final String image;
  final String foodName;
  CardForRecipe({this.name, this.image, this.foodName});
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
                        name,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 25.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      // color: Colors.blue,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        foodName,
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
