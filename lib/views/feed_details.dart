import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

class FeedDetails extends StatefulWidget {
  final String image;
  final String email;
  final String recipe;

  FeedDetails({this.image, this.email, this.recipe});
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
                Text('Calories'+snapshot.data.docs[0].data()['calories'].toString()),
                Text('Carbs'+snapshot.data.docs[0].data()['carbs'].toString()),
                Text('Fats'+snapshot.data.docs[0].data()['fats'].toString()),
                Text('Proteins'+snapshot.data.docs[0].data()['proteins'].toString()),
                ])
              : Container();
        });
  }

Widget IngredientsDetails() {
    return StreamBuilder(
        stream: ingredientsSnapshot,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? 
              ListView.builder(
                shrinkWrap: true,
                  itemCount: snapshot.data.docs[0].data()['ing'].length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        snapshot.data.docs[0].data()['ing'][index].toString(),
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
              ? 
              ListView.builder(
                shrinkWrap: true,
                  itemCount: snapshot.data.docs[0].data()['rec'].length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        snapshot.data.docs[0].data()['rec'][index].toString(),
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
   databaseMethods
        .getIngredients(widget.recipe, widget.recipe)
        .then((result) {
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
        appBar: AppBar(
          title: Text('churva'),
        ),
        body: 
        SingleChildScrollView(child:
        Column(children:[
          
          Container(child:Image.network(widget.image)),
          Text('NUTRITIONAL INFORMATIONS',style: TextStyle(fontSize: 20.0),),
          RecipeDetails(),
          SizedBox(height:30.0),
          Text('INGREDIENTS',style: TextStyle(fontSize: 20.0),),
          IngredientsDetails(),
          SizedBox(height:30.0),
          Text('RECIPES',style: TextStyle(fontSize: 20.0),),
          RecipeDetailstwo(),

        ], )
        )
        );
  }
}
