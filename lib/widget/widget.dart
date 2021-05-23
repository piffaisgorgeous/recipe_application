import 'package:flutter/material.dart';

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.indigo[800],
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 18,
      fontStyle: FontStyle.italic,
    ),
  );
}

Container containerDecoration(String text) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [Colors.indigoAccent[100], Colors.indigo],
        )),
    width: 160,
    height: 50,
    child: Center(
        child: Text(
      text,
      style: TextStyle(fontSize: 15),
    )),
  );
}



Padding rowFeedHealth(String cal_val, carb_val, fat_val, prot_val) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        children: [
          Text(
            "Calories",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            cal_val,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Carbs",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            carb_val,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Fats",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            fat_val,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "Proteins",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            prot_val,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ]),
  );
}




     