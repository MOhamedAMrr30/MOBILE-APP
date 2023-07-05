import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/forgetpassword/forgetpassword.dart';
import 'package:tourism/login/logincontroller.dart';
import 'package:tourism/main.dart';
import 'package:tourism/register/register.dart';
import 'package:tourism/widgets/Appbutton.dart';
import 'package:tourism/widgets/passwordtextfield.dart';
import 'package:tourism/widgets/textfield.dart';
import 'package:tourism/widgets/divider.dart';

class login extends StatelessWidget{
  final phone=TextEditingController();
  final password=TextEditingController();
  final GlobalKey<FormState> k=GlobalKey<FormState>();
  final  getLogin=Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body:Form(key: k,child:SingleChildScrollView(reverse: true,child: Column(
        children: [
          Divider2(height: 50),
          SizedBox(height: MediaQuery.of(context).size.height/4, child: Image.asset('assets/image400.png')),
          Text('login'.tr,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
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
          ), Divider2(height: 20),
          passwordtextfield(currentController: password, maxLength: 15, keyboardType: TextInputType.visiblePassword,
            enableInteractiveSelection: true, labelText: 'password'.tr, prefixicon: Icon(Icons.password),
          ),Align(alignment: Get.locale!.languageCode=='ar'?
            Alignment.centerRight:Alignment.centerLeft,child:
          TextButton(onPressed: (){       Get.to(()=>forgetPassword(),transition: Transition.leftToRight);},
              child: Text(' '+'forget'.tr,style: TextStyle(fontSize: 20,color: fill_button))
          )), Divider2(height: 20),Appbutton(pressed: () async { if(k.currentState!.validate())
          {
            bool? result=await getLogin.Login(phone.text, password.text);
            if(result!)  Get.offAll(()=>MyApp(),transition: Transition.leftToRight);
          } },
          child: 'login'),
          TextButton(onPressed: (){       Get.offAll(()=>MyApp(),transition: Transition.leftToRight);},
              child: Text('visitor'.tr,style: TextStyle(fontSize: 20,color: fill_button))
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('noaccount'.tr,style:TextStyle(color: Colors.grey,fontSize: 14)),
                TextButton(onPressed: (){
                  Get.to(()=>register(),transition: Transition.leftToRight);
                }, child: Text(' '+'register'.tr,style: TextStyle(fontSize: 14,color: fill_button))
                ) ])
        ]
      ))
    ));
  }
}