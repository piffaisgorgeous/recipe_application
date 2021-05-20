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

Card cardFeedDetails(BuildContext context, food, String name, String image) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Center(
      child: Container(
        child: Center(
          child: Column(children: <Widget>[
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
                  food,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
                ),
              ),
            ),
          ]),
        ),
      ),
    ),
  );
}

Padding rowFeed(String name, String numb) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        name,
        style: TextStyle(fontSize: 18),
      ),
      Text(
        numb,
        style: TextStyle(fontSize: 18),
      ),
    ]),
  );
}

Padding rowFeedHealth(int cal_val, carb_val, fat_val, prot_val) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        children: [
          Text(
            "cal",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            cal_val.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "carb",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            carb_val.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "fat",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            fat_val.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            "prot",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            prot_val.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ]),
  );
}
