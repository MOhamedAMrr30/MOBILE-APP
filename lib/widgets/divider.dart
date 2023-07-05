import 'package:flutter/material.dart';

class Divider2 extends StatelessWidget //fasel bem ben el widgets{
    {
  final double height;
const  Divider2({ required this.height });

  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.transparent,height: this.height);
  }
}
