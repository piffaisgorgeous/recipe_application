import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/views/feedDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream publishedRecipe;
  //String name = "Pif panget";

//  Widget _buildBody(BuildContext context, bool name) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('recipes')
//           .doc('recipes')
//           .collection('chats')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();

//         return _buildList(context, snapshot.data.docs, name);
//       },
//     );
//   }
  Widget RecipeList() {
    return StreamBuilder(
        stream: publishedRecipe,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return CardForRecipe(
                      name: snapshot.data.docs[index]
                          .data()['user_name']
                          .toString(),
                      image:
                          snapshot.data.docs[index].data()['upload'].toString(),
                      foodName: snapshot.data.docs[index]
                          .data()['recipe_name']
                          .toString(),
                    );
                  },
                )
              : Container();
        });
  }

  @override
  void initState() {
    databaseMethods.getRecipe().then((result) {
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
      onTap: (){
         Navigator.push(
              context, MaterialPageRoute(builder: (context) =>
               FeedDetail(name:name,image:image,foodName:foodName)));
              log(name.toString()) ;
               log(image.toString()) ;
                log(foodName.toString()) ;
      },
          child: Card(
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
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 25.0),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
