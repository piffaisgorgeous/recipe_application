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
  final String
      userName; 
  final String userEmail;
  PublishRecipe({this.userName, this.userEmail});
  @override
  _PublishRecipeState createState() => _PublishRecipeState();
}

List<String> choice = [];
String sampleChoice;

class _PublishRecipeState extends State<PublishRecipe> {
  UploadTask task;
  File file;

  TextEditingController textController = null;
  VideoPlayerController controller;
  String url = null;
  String typeString = null;

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController recipeName = TextEditingController();
  TextEditingController tfcalories = new TextEditingController();
  TextEditingController tfproteins = new TextEditingController();
  TextEditingController tffats = new TextEditingController();
  TextEditingController tfcarbs = new TextEditingController();
  TextEditingController name_ingredients = new TextEditingController();
  TextEditingController qty_ingredients = new TextEditingController();
  TextEditingController units_ingredients = new TextEditingController();

  String chosenCategory;
  List<Ingredients> ingredients = [];
  List<String> ingr = [];
  List<String> recipe = [];

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
    url = urlDownload; //mao ni ang link

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

// clearimage() {
//     setState(() {
//     typeString = null;
//       url = null;
//       controller = null;
//       textController = null;
//     });
//   }
  publish() {
    String recipe_name = recipeName.text;
    Map<String, dynamic> userMap = {
      "recipe_name": recipe_name,
      "email": widget.userEmail,
      "user_name": widget.userName,
      "upload": url,
      "cat": choice
    };
    Map<String, dynamic> healthInfoMap = {
      "calories": tfcalories.text,
      "proteins": tfproteins.text,
      "fats": tffats.text,
      "carbs": tfcarbs.text,
    };
    Map<String, dynamic> ingredientsMap = {"ing": ingr};
    Map<String, dynamic> recipeMap = {"rec": recipe};
    log('check');
    databaseMethods.uploadRecipeInfo(recipe_name, userMap);
    databaseMethods.uploadDetailsofRecipe(ingredientsMap, recipeMap,
        healthInfoMap, recipe_name, widget.userEmail);
    // log('amen');

    // chosenCategory = null;
    setState(() {
      log("pak");
      ingr.length = 0;
      recipe.length = 0;
//imageCache.clear();
      // textController.text="";
      // controller="";
      // typeString = "";

      // textController.text = "";
    });

    recipeName.text = "";
    name_ingredients.text = "";
    qty_ingredients.text = "";
    units_ingredients.text = "";
    tfcalories.text = "";
    tfproteins.text = "";
    tffats.text = "";
    tfcarbs.text = "";

    // ingr.removeAll();
    // recipe.removeAll();

    log('done');
  }

  trappingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.indigo[200],
              title: Text('Kindly input please'),
              actions: <Widget>[
                MaterialButton(
                    // elevation: 5.0,
                    child: Text('Done',
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }

  createDialog(BuildContext context) {
    log(ingredients.length.toString());

    int length;
    return showDialog(
        context: context,
        builder: (context) {
          log("third");

          return AlertDialog(
            backgroundColor: Colors.indigo[100],
            title: Text('Ingredients',
            style: TextStyle(
              fontSize: 20
            ),),
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
                  child: Text('Done',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  onPressed: () {
                    if (name_ingredients.text == null ||
                        name_ingredients.text == "") {
                      setState(() {
                        Navigator.pop(context);
                        log("chuchu");
                      });
                    } else {
                      length = ingr.length;
                      String ingred = name_ingredients.text +
                          " " +
                          qty_ingredients.text +
                          " " +
                          units_ingredients.text;
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

////hakdog
  ///

  createDialogCategory(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.indigo[100],
            title: Text('Categories'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Categories(cat: 'Pastries and desserts'),
                  Categories(cat: 'Main dishes'),
                  Categories(cat: 'Salad'),
                  Categories(cat: 'Bouillons'),
                  Categories(cat: 'Snacks'),
                  Categories(cat: 'Sauces'),
                  Categories(cat: 'Beverage'),
                  Categories(cat: 'Breakfast Food'),
                  Categories(cat: 'Lunch Cuisine'),
                  Categories(cat: 'Dinner Style'),
                  Categories(cat: 'Sandwiches'),
                  Categories(cat: 'Finger Food'),
                  Categories(cat: 'Vegetarian Cuisine'),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  // elevation: 5.0,
                  child: Text('Done'),
                  onPressed: () {
                    // log(choice);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

///////hakdog
  createDialogRecipe(BuildContext context) {
    TextEditingController recipeSteps = new TextEditingController();
    int length;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.indigo[100],
            title: Text('Recipe',
            style: TextStyle(
              fontSize: 20,
            ),),
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
                  child: Text('Done',
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold,
                  ),),
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
            //hakdog
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    createDialogCategory(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey[400],
                            Colors.indigoAccent[100],
                            Colors.grey[400],
                          ],
                        )),
                    width: 160,
                    height: 50,
                    child: Center(
                        child: Text(
                      "Choose Category",
                      style: TextStyle(fontSize: 15),
                    )),
                  )),
            ),

            ///hakdog
            SizedBox(height: 5),
            // DropdownButtonHideUnderline(

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

            SizedBox(
              height: 8
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Ingredients', style: TextStyle(fontSize: 25)),
            ),
            ingr.length == 0
                ? Text(
                    'NO INGREDIENTS ADDED',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
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
                    if (choice == null ||
                        url == null ||
                        recipeName.text.isEmpty ||
                        name_ingredients.text.isEmpty ||
                        qty_ingredients.text.isEmpty ||
                        units_ingredients.text.isEmpty ||
                        tfcalories.text.isEmpty ||
                        tfproteins.text.isEmpty ||
                        tffats.text.isEmpty ||
                        tfcarbs.text.isEmpty) {
                      log("please lang gawas");
                      trappingDialog(context);
                      log(chosenCategory);
                      log(url);
                      log(recipeName.text);
                      log(tfcalories.text);
                      log(tfproteins.text);
                      log(tffats.text);
                      log(tfcarbs.text);
                      log("please lang gawas2");
                    } else {
                      publish();
                      log("chuy");
                    }
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

class Categories extends StatefulWidget {
  final String cat;
  Categories({this.cat});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            checkColor: Colors.amber,
            activeColor: Colors.red,
            value: valuefirst,
            onChanged: (bool value) {
              setState(() {
                log("bah oakg abab");
                sampleChoice = widget.cat.toLowerCase();
                valuefirst = value;

                if (value == true) {
                  choice.add(widget.cat.toLowerCase());
                }

                log(valuefirst.toString());
                log("humot kag baba");
              });
            }),
        Text(widget.cat.toUpperCase())
      ],
    );
  }
}
