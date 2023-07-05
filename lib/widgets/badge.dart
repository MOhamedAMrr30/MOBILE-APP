import 'package:flutter/material.dart';
import 'package:tourism/Utils/Elements.dart';

class badge extends StatelessWidget //icon of app bet show 3adad el notification{
    {
  final IconData child;
  final DecorationImage image;
  badge({ required this.child, required this.image});

  @override
  Widget build(BuildContext context) {
    return  Stack(alignment: Alignment.center,
        children: [
          Container(height:(MediaQuery.of(context).size.height/8)+5 ,width:  (MediaQuery.of(context).size.width/8)+30
              ,decoration: BoxDecoration(color:Colors.redAccent ,shape: BoxShape.circle, image: image  ))
          , Positioned(bottom: 0,right: 0,child: Container(height:25 ,width: 25,decoration: BoxDecoration(color:fill_button ,shape: BoxShape.circle  ),child: Icon(child,color: foreground) )),
        ]);}
}