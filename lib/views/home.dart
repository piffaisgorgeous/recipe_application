import 'package:flutter/material.dart';
import 'package:recipe_application/widget/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController recipeName = TextEditingController();
  String chosenCategory, calories, fats, proteins, carbs;
  List _category = [
    'soup',
    'salad',
  ];
  List<Ingredients> ingredients = [];

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
        appBar: AppBar(title: Text('Home')),
        body: Expanded(
          child: Column(
            children: [
              Text('Publish Recipe', style: TextStyle(fontSize: 20.0)),
              Row(
                children: [
                  Text('Cateogory'),
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
              Text('Name of the Ingredients', style: TextStyle(fontSize: 20)),
              TextField(
                controller: recipeName,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration("Name"),
              ),
              Column(
                children: [
                  Text('Nutritional Informations'),
                  Row(
                    children: [
                      Text('Calories'),
                      TextField(),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Proteins'),
                      TextField(),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Fats'),
                      TextField(),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Carbs'),
                      TextField(),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Ingredients'),
                  ingredients.length == 0
                      ? Row(
                          children: [
                            TextField(
                              decoration: textFieldInputDecoration('Name of Ingredients'),
                            ),
                            TextField(
                              decoration: textFieldInputDecoration('Quantity'),
                            ),
                            TextField(
                              decoration: textFieldInputDecoration('Units'),
                            )
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
                  GestureDetector(
                    onTap: () {},
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
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Add Ingredients",
                        style: biggerTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class Ingredients {
  final String nameIngredients;
  final double qtyIngredients;
  final String units;
  Ingredients({this.nameIngredients, this.qtyIngredients, this.units});
}
