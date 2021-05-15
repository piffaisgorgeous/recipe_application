import 'package:flutter/material.dart';
import 'package:recipe_application/services/database.dart';
import 'package:recipe_application/widget/widget.dart';

class PublishRecipe extends StatefulWidget {
  final String userName;
  final String userEmail;
  PublishRecipe({this.userName, this.userEmail});
  @override
  _PublishRecipeState createState() => _PublishRecipeState();
}

class _PublishRecipeState extends State<PublishRecipe> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController recipeName = TextEditingController();
  TextEditingController start_name_ingredients = new TextEditingController();
  TextEditingController start_qty_ingredients = new TextEditingController();
  TextEditingController start_units_ingredients = new TextEditingController();
  String chosenCategory, calories, fats, proteins, carbs;
  List _category = [
    'soup',
    'salad',
  ];
  List<Ingredients> ingredients = [];

  publish() {
    Map<String, dynamic> userMap = {
      "email": widget.userEmail,
      "user_name": widget.userName
    };
    if (ingredients.length == 0) {
      ingredients.insert(
          0,
          Ingredients(
              nameIngredients: start_name_ingredients.text,
              qtyIngredients: double.parse(start_qty_ingredients.text),
              units: start_units_ingredients.text));
      databaseMethods.uploadRecipeInfo(
          chosenCategory, recipeName.text, userMap);
    }
    else{
       databaseMethods.uploadRecipeInfo(
          chosenCategory, recipeName.text, userMap);

    }
  }

  createDialog(BuildContext context) {
    TextEditingController name_ingredients = new TextEditingController();
    TextEditingController qty_ingredients = new TextEditingController();
    TextEditingController units_ingredients = new TextEditingController();
    int length;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingredients'),
            content: Column(
              children: [
                TextField(
                  controller: name_ingredients,
                ),
                Row(
                  children: [
                    TextField(controller: qty_ingredients),
                    TextField(
                      controller: units_ingredients,
                    ),
                  ],
                )
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Done'),
                  onPressed: () {
                    length = ingredients.length;
                    if (length != 0) {
                      ingredients.insert(
                          length,
                          Ingredients(
                              nameIngredients: name_ingredients.text,
                              qtyIngredients:
                                  double.parse(qty_ingredients.text),
                              units: units_ingredients.text));
                    } else {
                      ingredients.insert(
                          0,
                          Ingredients(
                              nameIngredients: name_ingredients.text,
                              qtyIngredients:
                                  double.parse(qty_ingredients.text),
                              units: units_ingredients.text));
                    }
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Home Shuffa')),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Publish Recipe', style: TextStyle(fontSize: 20.0)),
          Row(
            children: [
              Text('Cateogory', style: TextStyle(fontSize: 20)),
              SizedBox(width: 30.0),
              DropdownButton(
                  hint: Text('Choose Category'),
                  value: chosenCategory,
                  onChanged: (value) {
                    setState(() {
                      chosenCategory = value;
                    });
                  },
                  items: _category.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())
            ],
          ),
          Text('Name of the Recipe', style: TextStyle(fontSize: 20)),
          TextField(
            controller: recipeName,
          ),
          Text('Nutritional Informations', style: TextStyle(fontSize: 20)),
          Row(
            children: [
              Text('Calories', style: TextStyle(fontSize: 20)),
              SizedBox(width: 30.0),
              Container(width: 100.0, child: TextField()),
            ],
          ),
          Row(
            children: [
              Text('Proteins', style: TextStyle(fontSize: 20)),
              SizedBox(width: 30.0),
              Container(width: 100.0, child: TextField()),
            ],
          ),
          Row(
            children: [
              Text('Fats', style: TextStyle(fontSize: 20)),
              SizedBox(width: 30.0),
              Container(width: 100.0, child: TextField()),
            ],
          ),
          Row(
            children: [
              Text('Carbs', style: TextStyle(fontSize: 20)),
              SizedBox(width: 30.0),
              Container(width: 100.0, child: TextField()),
            ],
          ),
          Text('Ingredients', style: TextStyle(fontSize: 40)),
          ingredients.length == 0
              ? Row(
                  children: [
                    Container(
                        width: 100.0,
                        child: TextField(
                          controller: start_name_ingredients,
                          decoration: InputDecoration(hintText: 'Name'),
                        )),
                    Container(
                        width: 100.0,
                        child: TextField(
                            controller: start_qty_ingredients,
                            decoration: InputDecoration(hintText: 'Qty'))),
                    Container(
                        width: 100.0,
                        child: TextField(
                            controller: start_units_ingredients,
                            decoration: InputDecoration(hintText: 'Units'))),
                  ],
                )
              : ListView.builder(
                  itemCount: ingredients.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Row(
                        children: [
                          Text('${ingredients[index].nameIngredients}'),
                          Text('${ingredients[index].qtyIngredients}'),
                          Text('${ingredients[index].units}')
                        ],
                      ),
                    );
                  }),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: GestureDetector(
              onTap: () {
                createDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ],
                    )),
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  " Add Ingredients",
                  style: biggerTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: GestureDetector(
              onTap: () {
                publish();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ],
                    )),
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  " Add Recipe",
                  style: biggerTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ]),
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
