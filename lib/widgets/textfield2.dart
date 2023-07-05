import 'package:flutter/material.dart';

class textField2 extends StatelessWidget //description of the post{
    {
  final TextEditingController currentController;
  final int maxLength;
  final int lines;
  final bool obscureText;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final String labelText;
  final Icon prefixicon;
  final String? Function(String?) validator;

  textField2({ required this.currentController, required this.maxLength,
    required this.obscureText, required this.enableInteractiveSelection,
    required this.keyboardType, required this.labelText, required this.prefixicon,
    required this.validator, required this.lines });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15),child:  TextFormField(
      textCapitalization:   TextCapitalization.words,
      controller: currentController,
      cursorColor: Colors.white,
      maxLines: lines,
      minLines: lines,
      maxLength: maxLength,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style:  TextStyle(color: Colors.black,fontSize: 15,fontWeight:FontWeight.w900),
      enableInteractiveSelection: enableInteractiveSelection,
      decoration: InputDecoration(
        iconColor: Colors.black,
        prefixIcon: prefixicon,
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