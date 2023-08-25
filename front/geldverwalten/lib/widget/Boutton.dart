
import 'package:flutter/material.dart';



Widget buildButton(String text, Color color, VoidCallback onPressed) {
  return SizedBox(
    //width: double.infinity,
    height: 70,
    child: ElevatedButton(
        style: ButtonStyle(
         // backgroundColor: MaterialStateProperty.all(color),
            minimumSize: MaterialStateProperty.all(const Size(80, 80)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60)))
        ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle()),
    ),
  );
}
