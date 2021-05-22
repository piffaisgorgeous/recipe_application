import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_application/views/feed_details.dart';

class DisplaySearch extends StatefulWidget {
  // final String category;
  // DisplaySearch({this.category});
    final List<String> category;
  DisplaySearch({this.category});
  @override
  _DisplaySearchState createState() => _DisplaySearchState();
}

class _DisplaySearchState extends State<DisplaySearch> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  //List <Stream> searchedRecipe;
  Stream searchedRecipe;
  List <String> categoryFromFirebase;

//display(){
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
                                          email:snapshot.data.docs[index]
                                          .data()['email']
                                          .toString(),
                                          recipe:snapshot.data.docs[index]
                                          .data()['recipe_name']
                                          .toString(),
                                            foodName: snapshot.data.docs[index]
                            .data()['recipe_name']
                            .toString()

                                    )));
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
//}

  @override
  void initState() {

    //for(int i=0; i<widget.category.length;i++)
    

    databaseMethods.getSearchedRecipe(widget.category).then((result) {
      setState(() {
        searchedRecipe=result;
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
                     // child: Image.network(image),
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
