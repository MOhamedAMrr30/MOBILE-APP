import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class passwordtextfield extends StatelessWidget {

  final TextEditingController currentController;
  final int maxLength;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final String labelText;
  final Icon prefixicon;

  passwordtextfield({ required this.currentController, required this.maxLength,
    required this.enableInteractiveSelection, required this.keyboardType, required this.labelText,
    required this.prefixicon });

  final obscuse=true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Padding(padding: EdgeInsets.symmetric(horizontal: 15),child:TextFormField(
      textCapitalization:   TextCapitalization.words,
      controller: currentController,
      cursorColor: Colors.white,
      maxLines: 1,
      maxLength: maxLength,
      obscureText: obscuse.value,
      keyboardType: keyboardType,
      style:  TextStyle(color: Colors.black,fontSize: 15,fontWeight:FontWeight.w900),
      enableInteractiveSelection: enableInteractiveSelection,
      decoration: InputDecoration(
        iconColor: Colors.black,
        prefixIcon: prefixicon,
        suffixIcon: IconButton(icon: Icon(obscuse.value?Icons.remove_red_eye_rounded:
            FontAwesomeIcons.eyeSlash,color: Colors.black),
        onPressed: (){
          if(obscuse.value)
        obscuse.value=false;
          else
          obscuse.value=true;
        }),
        prefixIconColor:Colors.black ,
          disabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 2),
          ),errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 2),
      ),focusedErrorBorder:OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 2),
      ) , enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,width: 2),
        ), focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,width: 2),
        ),
        labelText: labelText,
        labelStyle:  TextStyle(color: Colors.black,fontSize: 15,fontWeight:FontWeight.w900 ),
        counterText: "",
      ),
      validator:(i){
        String v= r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp S=new RegExp(v);
        if(i!.isEmpty)
          return "error1".tr;
        else if(!S.hasMatch(v) )
          return   "uppercase".tr;
      },
    ))
    );
  }
}