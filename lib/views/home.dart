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
import 'package:recipe_application/views/uploadimage.dart';
// import 'package:recipe_application/views/video.dart';
import 'package:recipe_application/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:recipe_application/widget/video_player_widget.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
// import 'package:recipe_application/widget/other/floating_action_button_widget.dart';
// import 'package:recipe_application/widget/other/textfield_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Home')),
      body: Container(
        child:Column(
          children: [
            RaisedButton(
              onPressed: (){
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Uploads()),
  );
              },
              child: Text("upload"),),

  //             RaisedButton(
  //         onPressed: (){
  //           Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => NetworkPlayerWidget()),
  // );
  //         },
  //         child: Text("upload video"),)
          ],
        )
        ),

    );
  }
}


