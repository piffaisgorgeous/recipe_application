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

//mao ni
  uploadRecipeInfo(categoryMap, String recipeName, userMap) {
    // log('tabang');
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeName)
        .set(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadDetailsofRecipe(ingredientsMap, recipeMap, healthInfoMap,
      String recipeName, categoryMap, String useremail) {
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
    // FirebaseFirestore.instance
    //    .collection('recipes')
    //     .doc(recipeName)
    //     .collection('Image Video')
    //     .add(imageMap)
    //     .catchError((e) {
    //   print(e.toString());
    // });

    FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeName)
        .collection('Category')
        .add(categoryMap)
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

  uploadRecipeandAuthor(recipeName, userMap) {
    FirebaseFirestore.instance
        .collection('recipeDetails')
        .doc(recipeName)
        .set(userMap);
  }

  // createChatRoom(String chatRoomId, chatRoomMap) {
  //   FirebaseFirestore.instance
  //       .collection("ChatRoom")
  //       .doc(chatRoomId)
  //       .set(chatRoomMap)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // getConversationMessages(String chatRoomId) async {
  //   return await FirebaseFirestore.instance
  //       .collection("ChatRoom")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .orderBy("time", descending: false)
  //       .snapshots();
  // }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
