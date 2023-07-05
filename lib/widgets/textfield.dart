import 'package:flutter/material.dart';

class textfield extends StatelessWidget //description of the comment and sign up {
    {
  final TextEditingController currentController;
  final int maxLength;
  final bool obscureText;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final String labelText;
  final Widget prefixicon;
  final String? Function(String?) validator;

  textfield({ required this.currentController, required this.maxLength,
    required this.obscureText, required this.enableInteractiveSelection,
    required this.keyboardType, required this.labelText, required this.prefixicon,
   required this.validator });

  @override
  Widget build(BuildContext context) {
      return Padding(padding: EdgeInsets.symmetric(horizontal: 15),child:  TextFormField(
        textCapitalization:   TextCapitalization.words,
        controller: currentController,
        cursorColor: Colors.white,
        maxLines: 1,
        maxLength: maxLength,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style:  TextStyle(color: Colors.black,fontSize: 15,fontWeight:FontWeight.w900),
        enableInteractiveSelection: enableInteractiveSelection,
        decoration: InputDecoration(
          iconColor: Colors.black,
          prefixIcon:prefixicon==Text('')?null: prefixicon,
          prefixIconColor:Colors.black ,  disabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,width: 2),
        ),errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,width: 2),
        ),focusedErrorBorder:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,width: 2),
        ) , enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,width: 2),
        ), focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,width: 2),
        ), labelText: labelText,
          labelStyle:  TextStyle(color: Colors.black,fontSize: 15,fontWeight:FontWeight.w900 ),
          counterText: "",
        ),
        validator:validator,
      ));

  }
}