import 'dart:ffi';

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
import 'package:recipe_application/widget/basic_overlay_widget.dart';
import 'package:recipe_application/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
// import 'package:recipe_application/widget/other/floating_action_button_widget.dart';
// import 'package:recipe_application/widget/other/textfield_widget.dart';
import 'package:recipe_application/widget/video_player_widget.dart';
import 'package:video_player/video_player.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:Text('Home')),

//     );
//   }
// }
String url;
String typeString;

class Uploads extends StatefulWidget {
  @override
  _UploadsState createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  UploadTask task;
  File file;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    //
    url = urlDownload;

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  TextEditingController textController;
  VideoPlayerController controller;
  // // var isMuted;
  // // isMuted = controller.value.volume == 0;

  // //static get urlLandscapeVideo => null;

  // @override
  // void initState() {
  //   super.initState();

  //   controller = VideoPlayerController.network(textController.text)
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..initialize().then((_) => controller.play());
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
 Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image/Video"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: 'Select File',
                  icon: Icons.attach_file,
                  onClicked: selectFile,
                ),
                SizedBox(height: 8),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 48),
                ButtonWidget(
                    text: 'Upload File',
                    icon: Icons.cloud_upload_outlined,
                    onClicked: () {
                      uploadFile();
                    }),
                SizedBox(height: 20),
                task != null ? buildUploadStatus(task) : Container(),
                GestureDetector(
                    onTap: () {
                      //                      Uri uri = Uri.parse(url);
                      // String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
                      //  if (typeString == "jpg" || typeString == "png"){

                      //  }
                      setState(() {
                        uploadFile();
                        Uri uri = Uri.parse(url);
                        typeString = uri.path
                            .substring(uri.path.length - 3)
                            .toLowerCase();
                        controller = VideoPlayerController.network(url)
                          ..addListener(() => setState(() {}))
                          ..setLooping(true)
                          ..initialize().then((_) => controller.play());
                        //  isMuted = controller.value.volume == 0;
                      });
                      typeString = null ;
                          url = null;
                          controller = null ;
                          textController = null;
                    },
                    child: Container(
                      color: Colors.green,
                      width: 100,
                      height: 50,
                      child: Text("show"),
                    )),
                SizedBox(height: 20),
                // GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => NetworkPlayerWidget()),
                //       );
                //     },
                //     child: Container(
                //       color: Colors.green,
                //       width: 100,
                //       height: 50,
                //       child: Text("show video"),
                //     )),
                // Container(
                //   //  height: MediaQuery.of(context).size.height,
                //   child: url == null ? Container() : Image.network(url),
                // ),

                Container(
                  //  height: MediaQuery.of(context).size.height,
                  child: typeString == null &&
                          url == null &&
                          controller == null &&
                          textController == null
                      ? Container()
                      : typeString == "jpg" || typeString == "png"
                          ? Image.network(url)
                          : Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                 Container(alignment: Alignment.topCenter, child: buildVideo()),
                                  // const SizedBox(height: 32),
                                  // if (controller != null &&
                                  //     controller.value.initialized)
                                  //   CircleAvatar(
                                  //     radius: 30,
                                  //     backgroundColor: Colors.red,
                                  //     child: IconButton(
                                  //       icon: Icon(
                                  //         isMuted
                                  //             ? Icons.volume_mute
                                  //             : Icons.volume_up,
                                  //         color: Colors.white,
                                  //       ),
                                  //       onPressed: () =>
                                  //           controller.setVolume(isMuted ? 1 : 0),
                                  //     ),
                                  //   )
                                ],
                              ),
                            ),
                ),

                //  Container(
                // //  height: MediaQuery.of(context).size.height,
                //   child: controller=="Empty"? Container() :
                //     VideoPlayerWidget(controller: controller),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//

class Record {
  final String location;
  final String url;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        location = map['location'],
        url = map['url'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$location:$url>";
}

class NetworkPlayerWidget extends StatefulWidget {
  @override
  _NetworkPlayerWidgetState createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  final textController = TextEditingController(text: url);
  VideoPlayerController controller;

  //static get urlLandscapeVideo => null;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(textController.text)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayerWidget(controller: controller)),
            const SizedBox(height: 32),
            if (controller != null && controller.value.initialized)
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: IconButton(
                  icon: Icon(
                    isMuted ? Icons.volume_mute : Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: () => controller.setVolume(isMuted ? 1 : 0),
                ),
              )
          ],
        ),
      ),
    );
  }
}
