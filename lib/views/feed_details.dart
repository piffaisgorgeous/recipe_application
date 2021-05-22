import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/widget/widget.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

class FeedDetails extends StatefulWidget {
  final String image;
  final String email;
  final String recipe;
  final String foodName;

  FeedDetails({this.image, this.email, this.recipe, this.foodName});
  @override
  _FeedDetailsState createState() => _FeedDetailsState();
}

class _FeedDetailsState extends State<FeedDetails> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream healthInfosnapshot;
  Stream ingredientsSnapshot;
  Stream recipeSnapshot;
  Widget RecipeDetails() {
    return StreamBuilder(
        stream: healthInfosnapshot,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Column(children: [
                  rowFeedHealth(
                      snapshot.data.docs[0].data()['calories'].toString(),
                      snapshot.data.docs[0].data()['carbs'].toString(),
                      snapshot.data.docs[0].data()['fats'].toString(),
                      snapshot.data.docs[0].data()['proteins'].toString()),

                  // Text('Calories' +
                  //     snapshot.data.docs[0].data()['calories'].toString()),
                  // Text('Carbs' +
                  //     snapshot.data.docs[0].data()['carbs'].toString()),
                  // Text(
                  //     'Fats' + snapshot.data.docs[0].data()['fats'].toString()),
                  // Text('Proteins' +
                  //     snapshot.data.docs[0].data()['proteins'].toString()),
                ])
              : Container(child: Text("hakdog"));
        });
  }

  Widget get IngredientsDetails {
    return StreamBuilder(
        stream: ingredientsSnapshot,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs[0].data()['ing'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          snapshot.data.docs[0].data()['ing'][index].toString(),
                          style: TextStyle(
                            fontSize: 21.5,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  Widget RecipeDetailstwo() {
    return StreamBuilder(
        stream: recipeSnapshot,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs[0].data()['rec'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          snapshot.data.docs[0].data()['rec'][index].toString(),
                          style: TextStyle(
                              fontSize: 21.5, fontWeight: FontWeight.normal),
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
        .getDetailsofRecipe(widget.recipe, widget.recipe)
        .then((result) {
      setState(() {
        healthInfosnapshot = result;
      });
    });
    databaseMethods.getIngredients(widget.recipe, widget.recipe).then((result) {
      setState(() {
        ingredientsSnapshot = result;
      });
    });
    databaseMethods
        .getRecipeDetails(widget.recipe, widget.recipe)
        .then((result) {
      setState(() {
        log('nisud na sya');
        recipeSnapshot = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[200], // balika ni sakits mata puti
        appBar: AppBar(
            backgroundColor: Colors.indigo[300],
            title: Text(widget.foodName.toUpperCase())),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(widget.image)),
            ),

            // sa pic
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [Colors.grey[350], Colors.grey[400]],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.info, color: Colors.black)),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'NUTRITIONAL INFORMATIONS',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  RecipeDetails(),
                ]),
              ),
            ),
            // SizedBox(
            //   height: 10
            // ),

            ///
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [Colors.grey[350], Colors.grey[400]],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  child: Container(
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child:
                                    Icon(Icons.fastfood, color: Colors.black)),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'INGREDIENTS',
                                style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IngredientsDetails,
                    ])),
                  )),
            ),
            // SizedBox(
            //   height: 10
            // ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [Colors.grey[350], Colors.grey[400]],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.integration_instructions,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'RECIPES',
                              style: TextStyle(
                                  fontSize: 23.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RecipeDetailstwo(),
                  ]))),
            ),
          ],
        )));
  }
}
