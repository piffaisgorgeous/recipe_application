import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserbyUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: username)
        .get();
  }

  getUserbyUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  uploadRecipeInfo( String recipeName, userMap) {
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeName)
        .set(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadDetailsofRecipe(ingredientsMap, recipeMap, healthInfoMap,
      String recipeName, String useremail) {
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeName)
        .collection('Health Informations')
        .add(healthInfoMap)
        .catchError((e) {
      print(e.toString());
    });
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeName)
        .collection('Ingredients')
        .add(ingredientsMap)
        .catchError((e) {
      print(e.toString());
    });

    FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeName)
        .collection('Recipe')
        .add(recipeMap)
        .catchError((e) {
      print(e.toString());
    });
   

  }

  getRecipe() async {
    return await FirebaseFirestore.instance
        .collection('recipes')
        .snapshots();
  }

  getDetailsofRecipe(String recipeName,String userEmail) async{
    return await FirebaseFirestore.instance
    .collection('recipes')
    .doc(recipeName)
    .collection('Health Informations')
    .snapshots();
  }

  getIngredients (String recipeName, String userEmail ) async{
    return await FirebaseFirestore. instance
    .collection('recipes')
    .doc(recipeName)
    .collection('Ingredients')
    .snapshots();
  }
  getRecipeDetails (String recipeName, String userEmail ) async{
    return await FirebaseFirestore. instance
    .collection('recipes')
    .doc(recipeName)
    .collection('Recipe')
    .snapshots();
  }

  getSearchedRecipe(List category) async
  {
    return await FirebaseFirestore.instance 
    .collection('recipes')
    .where('cat', arrayContainsAny: category)
    .snapshots();
  }

  uploadRecipeandAuthor(recipeName, userMap) {
    FirebaseFirestore.instance
        .collection('recipeDetails')
        .doc(recipeName)
        .set(userMap);
  }

 getUserPublish(String email,String username) async
  {
    return await FirebaseFirestore.instance 
    .collection('recipes')
    .where('email', isEqualTo:email)
    .where('user_name', isEqualTo:username)
    .snapshots();
  }

  recipeOfTheDay(DateTime date, recipeMap)
  {
       FirebaseFirestore.instance
        .collection('randomRecipe')
        .doc(date.toString())
        .set(recipeMap)
        .catchError((e) {
      print(e.toString());
    });

  }

  getrecipeOfTheDay(DateTime date) async
  {
      return await FirebaseFirestore.instance
        .collection('randomRecipe')
        .where('date', isEqualTo: date)
        .snapshots();
  }



}
