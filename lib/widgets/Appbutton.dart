import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/Utils/Elements.dart';

class Appbutton extends StatelessWidget{

  final String child;
  final Function() pressed;
  Appbutton({ required this.child, required this.pressed});

  @override
  Widget build(BuildContext context) {
   return   ElevatedButton( style: ElevatedButton.styleFrom(
   primary: fill_button,
       onPrimary: Colors.white, shape:  RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(30)),
    minimumSize: Size(MediaQuery.of(context).size.width/2,MediaQuery.of(context).size.width/7 ) //////// HERE
    ), onPressed:pressed ,
    child: Text(child.tr,style: TextStyle(fontSize: 15) ));
  }

}