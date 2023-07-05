import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:tourism/forgetpassword/forgetpasswordcontroller.dart';
import 'package:tourism/widgets/Appbutton.dart';
import 'package:tourism/widgets/textfield.dart';
import 'package:tourism/widgets/divider.dart';

class forgetPassword extends StatelessWidget{
  final phone=TextEditingController();
  final GlobalKey<FormState> k=GlobalKey<FormState>();
  final  getReset=Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,elevation: 200,foregroundColor: Colors.black),
        body:Form(key: k,child:SingleChildScrollView(reverse: true,child: Column(
            children: [
              Divider2(height: 50),
              SizedBox(height: MediaQuery.of(context).size.height/4, child: Image.asset('assets/image400.png')),
              Divider2(height: 20),
              textfield(currentController: phone, maxLength: 30,keyboardType: TextInputType.emailAddress,
                labelText: 'emaillabel'.tr, obscureText: false,enableInteractiveSelection: true,
                prefixicon: Icon(Icons.email), validator: (String? m) {
                  if(m!.isEmpty)
                    return 'error1'.tr;
                  else if(!m.isEmail)
                    return 'error2'.tr;
                  return null;
                },
              ),  Divider2(height: 20),
              Appbutton(pressed: () async { if(k.currentState!.validate())
              { bool? result =await getReset.ForgetPassword(phone.text);//getrest -> method
                if(result!) {phone.clear(); Get.back();}
              } }, child: 'reset')
            ]
        ))
        ));
  }
}