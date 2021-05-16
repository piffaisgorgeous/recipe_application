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

  uploadRecipeInfo(String chosenCategory, String recipeName, userMap) {
     FirebaseFirestore.instance.collection('recipes')
     .doc('reccipes')
     .collection(chosenCategory)
     .doc(recipeName)
     .set(userMap)
     .catchError((e) {
      print(e.toString());
    });

  }
  uploadRecipeandAuthor(recipeName,userMap)
  {
    FirebaseFirestore.instance.collection('recipeDetails').doc(recipeName)
    .set(userMap);
  }

  uploadDetailsofRecipe(healthInfoMap,recipeName,chosenCategory,String useremail)
  {
    FirebaseFirestore.instance.collection('foods')
    .doc(chosenCategory)
    .collection(recipeName)
    .doc('Health Information')
    .set(healthInfoMap);
    // FirebaseFirestore.instance.collection('recipeDetails').doc(recipeName)
    // .collection('healthInfo').add(ingredientsInfo);
    //  FirebaseFirestore.instance.collection('recipeDetails').doc(recipeName)
    // .collection('healthInfo').add(recipeInfo);

    
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
