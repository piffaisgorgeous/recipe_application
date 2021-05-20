import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_application/api/firebase_api.dart';
import 'package:recipe_application/views/profileIcon.dart';
import 'package:recipe_application/views/publishRecipe.dart';
import 'package:recipe_application/views/searchIcon.dart';
// import 'package:recipe_application/views/uploadimage.dart';
import 'package:recipe_application/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'feed.dart';
import 'feedDetails.dart';
import 'homeIcon.dart';

void main() => runApp(new BottomNav());

class BottomNav extends StatefulWidget {
  final String userName;
  final String userEmail;

  BottomNav({this.userName, this.userEmail});
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
      return Feed();
      case 1:
        return Home();
      case 2:
        return PublishRecipe(userName:widget.userName, userEmail: widget.userEmail,);
      case 3:
        return Search();
      case 4:
        return Profile();
        break;
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Recipe",
      home: Scaffold(
        body: callPage(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            _currentIndex = value;
            
            
            setState(() {});
          },
          items: [
             BottomNavigationBarItem(
                icon: Icon(Icons.feed, color: Colors.blue),
                title: Text(
                  'Feed',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.blue),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined, color: Colors.blue),
                title: Text(
                  'Upload',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                title: Text(
                  'Search',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box, color: Colors.blue),
                title: Text(
                  'Account',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: callPage(_currentIndex),
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: _currentIndex,
    //     onTap: (value) {
    //       _currentIndex = value;
    //       setState(() {});
    //     },
    //     items: [
    //       BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.add_box_outlined), title: Text('Upload')),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.search), title: Text('Search')),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.account_box), title: Text('Account'))
    //     ],
    //   ),
    // );
  }
}

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:Text('Home')),
//       body: Container(
//         child:RaisedButton(
//           onPressed: (){
//             Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => Upload()),
//   );
//           },
//           child: Text("upload"),)
//         ),

//     );
//   }
// }
