import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/widget/basic_overlay_widget.dart';
import 'package:recipe_application/widget/button_widget.dart';
import 'package:recipe_application/widget/widget.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_application/api/firebase_api.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class PublishRecipe extends StatefulWidget {
  final String userName;
  final String userEmail;
  PublishRecipe({this.userName, this.userEmail});
  @override
  _PublishRecipeState createState() => _PublishRecipeState();
}

String url = null;
String typeString = null;

class _PublishRecipeState extends State<PublishRecipe> {
  UploadTask task;
  File file;

  TextEditingController textController;
  VideoPlayerController controller;

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController recipeName = TextEditingController();
  TextEditingController start_name_ingredients = new TextEditingController();
  TextEditingController start_qty_ingredients = new TextEditingController();
  TextEditingController start_units_ingredients = new TextEditingController();
  TextEditingController tfcalories = new TextEditingController();
  TextEditingController tfproteins = new TextEditingController();
  TextEditingController tffats = new TextEditingController();
  TextEditingController tfcarbs = new TextEditingController();

  String chosenCategory, calories, fats, proteins, carbs;
  List _category = [
    'soup',
    'salad',
  ];
  List<Ingredients> ingredients = [];
  List<String> ingr = [];
  List<String> recipe = [];

  TextEditingController start_name_recipe = new TextEditingController();

  publish() {
    String recipe_name = recipeName.text;
    Map<String, dynamic> userMap = {
      "email": widget.userEmail,
      "user_name": widget.userName
    };
    Map<String, dynamic> healthInfoMap = {
      "calories": tfcalories.text,
      "proteins": tfproteins.text,
      "fats": tffats.text,
      "carbs": tfcarbs.text
    };
    Map<String, dynamic> ingredientsMap = {"ing": ingr};
    Map<String, dynamic> recipeMap = {"rec": recipe};
    // if (ingredients.length == 0) {
    //   ingredients.insert(
    //       0,
    //       Ingredients(
    //           nameIngredients: start_name_ingredients.text,
    //           qtyIngredients: double.parse(start_qty_ingredients.text),
    //           units: start_units_ingredients.text));
    //           databaseMethods.uploadRecipeInfo(chosenCategory, recipe_name, userMap);
    // databaseMethods.uploadDetailsofRecipe(ingredientsMap, healthInfoMap,
    //     recipe_name, chosenCategory, widget.userEmail);
    // }
//mao ni
    log('check');
    databaseMethods.uploadRecipeInfo(chosenCategory, recipe_name, userMap);
    databaseMethods.uploadDetailsofRecipe(ingredientsMap, recipeMap,
        healthInfoMap, recipe_name, chosenCategory, widget.userEmail);
    log('amen');
  }

  createDialog(BuildContext context) {
    log(ingredients.length.toString());

    TextEditingController name_ingredients = new TextEditingController();
    TextEditingController qty_ingredients = new TextEditingController();
    TextEditingController units_ingredients = new TextEditingController();
    int length;
    return showDialog(
        context: context,
        builder: (context) {
          log("third");

          return AlertDialog(
            title: Text('Ingredients'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: name_ingredients,
                    decoration: textFieldInputDecoration("name"),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: qty_ingredients,
                    decoration: textFieldInputDecoration("quantity"),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: units_ingredients,
                    decoration: textFieldInputDecoration("units"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text('Done'),
                  onPressed: () {
                    if (name_ingredients.text == null ||
                        name_ingredients.text == "") {
                      Navigator.pop(context);
                      log("chuchu");
                    } else {
                      length = ingr.length;
                      String ingred = name_ingredients.text;
                      ingr.add(ingred);

                      Navigator.pop(context);
                      setState(() {});
                    }
                    log("chuchu1");
                  })
            ],
          );
        });
  }

  createDialogRecipe(BuildContext context) {
    TextEditingController recipeSteps = new TextEditingController();
    int length;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Recipe'),
            content: Column(
              children: [
                TextField(
                  controller: recipeSteps,
                  decoration: textFieldInputDecoration("recipe"),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                  // elevation: 5.0,
                  child: Text('Done'),
                  onPressed: () {
                    if (recipeSteps.text == null || recipeSteps.text == "") {
                      Navigator.pop(context);
                    } else {
                      length = recipe.length;

                      String rSteps = recipeSteps.text;
                      recipe.add(rSteps);

                      Navigator.pop(context);
                      setState(() {});
                    }
                  })
            ],
          );
        });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
    uploadFile();
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

    setState(() {
      //uploadFile();
      Uri uri = Uri.parse(url);
      typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
      controller = VideoPlayerController.network(url)
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) => controller.play());
      //  isMuted = controller.value.volume == 0;
    });
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }
//kani  piifff

  ///need

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : 'No File Selected';
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.indigo[400],
          title: Text(
            'Publish Recipe',
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(children: [
            Text('Category', style: TextStyle(fontSize: 25)),
            SizedBox(height: 5),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  elevation: 10,
                  autofocus: true,
                  hint: Text('Choose Category'),
                  value: chosenCategory,
                  onChanged: (value) {
                    setState(() {
                      chosenCategory = value;
                    });
                  },
                  dropdownColor: Colors.indigo[100],
                  items: _category.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      typeString = null;
                      url = null;
                      controller = null;
                      textController = null;
                      selectFile();
                    },
                    child: containerDecoration("Upload Image/Video")),
                task != null ? buildUploadStatus(task) : Container(),
                Container(
                  child: typeString == null &&
                          url == null &&
                          controller == null &&
                          textController == null
                      ? Container()
                      : typeString == "jpg" || typeString == "png"
                          ? AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: Image.network(url))
                          : Container(
                              // color: Colors.green,
                              alignment: Alignment.topCenter,
                              child: buildVideo()),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  controller: recipeName,
                  decoration: textFieldInputDecoration("Name of the Recipe")),
            ),
            Text('Nutritional Informations', style: TextStyle(fontSize: 25)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Calories', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(width: 50.0),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: tfcalories,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Proteins', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(width: 50.0),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: tfproteins,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Fats', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(width: 85.0),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: tffats,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Carbs', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(width: 75.0),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: tfcarbs,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Ingredients', style: TextStyle(fontSize: 25)),
            ),
            ingr.length == 0
                ? Text(
                    'NO INGREDIENTS ADDED',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                // ? Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Container(
                //         width: 150,
                //         height: 70,
                //         child: Padding(
                //           padding: const EdgeInsets.all(10),
                //           child: TextField(
                //               controller: start_name_ingredients,
                //               decoration: textFieldInputDecoration("Name")),
                //         ),
                //       ),
                //       Container(
                //         width: 100,
                //         height: 70,
                //         child: Padding(
                //           padding: const EdgeInsets.all(10),
                //           child: TextField(
                //               keyboardType: TextInputType.number,
                //               controller: start_qty_ingredients,
                //               decoration: textFieldInputDecoration("Qty")),
                //         ),
                //       ),
                //       Container(
                //         width: 100,
                //         height: 70,
                //         child: Padding(
                //           padding: const EdgeInsets.all(10),
                //           child: TextField(
                //               // keyboardType: TextInputType.number,
                //               controller: start_units_ingredients,
                //               decoration: textFieldInputDecoration("Units")),
                //         ),
                //       ),
                //     ],
                //   )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingr.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${ingr[index]}',
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic)),
                          ),
                          // Text('${ingredients[index].qtyIngredients}'),
                          // Text('${ingredients[index].units}')
                        ),
                      );
                    }),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                //splashColor: Colors.red,
                child: GestureDetector(
                    onTap: () {
                      log("first");
                      createDialog(context);
                    },
                    child: containerDecoration("Add Ingredients")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recipe', style: TextStyle(fontSize: 25)),
            ),
            recipe.length == 0
                ? Text(
                    'NO RECIPE ADDED',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipe.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${recipe[index]}',
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic)),
                          ),
                          // Text('${ingredients[index].qtyIngredients}'),
                          // Text('${ingredients[index].units}')
                        ),
                      );
                    }),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                //splashColor: Colors.red,
                child: GestureDetector(
                    onTap: () {
                      // log("first");
                      createDialogRecipe(context);
                    },
                    child: containerDecoration("Add Recipe/Steps")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                  onTap: () {
                    publish();
                  },
                  child: containerDecoration("Publish")),
            ),
          ]),
        ),
      ),
    );
  }
}

class Ingredients {
  final String nameIngredients;
  final double qtyIngredients;
  final String units;
  Ingredients({this.nameIngredients, this.qtyIngredients, this.units});
}
