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
