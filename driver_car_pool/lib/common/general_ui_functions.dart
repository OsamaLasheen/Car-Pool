
import 'package:flutter/material.dart';

class GeneralUIFunctions {
  static AppBar gradientAppBar(String title) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration( 
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 79, 141),
              Color.fromARGB(255, 4, 117, 209),
              Color.fromARGB(255, 69, 167, 247),
              Color.fromARGB(255, 126, 190, 242),
            ] )
        ),
      ),
      centerTitle: true, 
      title: Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),     
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////

  static ElevatedButton gradientElevatedButton(
    Widget ? child, 
    Function()? onPressed,
    double height,
    double width,
    double radius,
    ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        minimumSize: Size(width, height),
        elevation: 25,
       // shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.transparent,
            width: width,
            ),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      ),
      onPressed: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration( 
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 79, 141),
              Color.fromARGB(255, 4, 117, 209),
              Color.fromARGB(255, 69, 167, 247),
            ] )
        ),
        child: child,
      )
    );
  }

}

