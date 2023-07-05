import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/login/login.dart';
import 'package:tourism/widgets/divider.dart';

class Setting extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        body:SingleChildScrollView(reverse: true,child: Column(
            children: [
              Divider2(height: 20),
              ListTile(leading:Icon(Icons.language,color: Colors.grey.shade500),onTap: (){changeLanguage(context);},
             title: Text('language'.tr) ),
              Divider2(height: 20),
              ListTile(leading:Icon(Icons.dark_mode_outlined,color: Colors.grey.shade500),onTap: (){changeMode(context);},
                  title: Text('mode'.tr) ),
              Divider2(height: 20),
              Visibility(visible: auth.currentUser !=null?true:false,
                  child: ListTile(leading:Icon(Icons.logout,color: Colors.grey.shade500),
                      onTap: () async {
                        await auth.signOut();
Get.offAll(()=>login(),transition: Transition.leftToRight); },
                  title: Text('logout'.tr) )),
            ]
        ))
        );
  }

void changeLanguage(BuildContext context)
{Get.dialog(  Dialog(child:
SizedBox(height:MediaQuery.of(context).size.height/3 ,
    width: MediaQuery.of(context).size.width/2,
    child: Column(
      children: [
        Stack(children: [
          Container(
            height:MediaQuery.of(context).size.height/10,
            width: double.infinity,
            color: fill_button ,
            alignment: Alignment.center,
            child: Text('choose'.tr,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          Align(alignment: Alignment.topRight,child: IconButton(onPressed:(){
            Get.back(); }, icon: Icon(Icons.cancel_outlined,
              color: Colors.white)
          ))
        ]),
        Divider(height: 10,color: Colors.white),
        ListTile(onTap: (){
          Get.updateLocale(Locale('ar'));
          language.val='ar';
          Get.back(); },
          title: Text('العربية',style:  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
        ),
        ListTile( onTap: (){
          Get.updateLocale(Locale('en'));
        language.val='en';
        Get.back(); },
          title: Text('English',style:  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
        )
      ],
    ))
));}

  void changeMode(BuildContext context)
  {Get.dialog(  Dialog(child:
  SizedBox(height:MediaQuery.of(context).size.height/3 ,
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        children: [
          Stack(children: [
            Container(
              height:MediaQuery.of(context).size.height/10,
              width: double.infinity,
              color: fill_button ,
              alignment: Alignment.center,
              child: Text('choose2'.tr,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            Align(alignment: Alignment.topRight,child: IconButton(onPressed:(){
              Get.back(); }, icon: Icon(Icons.cancel_outlined,
                color: Colors.white)
            ))
          ]),
          Divider(height: 10,color: Colors.white),
          ListTile(onTap: (){
            Get.changeTheme(ThemeData.light());
            dark.val=false;
            Get.back(); },
            title: Text('light'.tr,style:  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          ListTile( onTap: (){
            Get.changeTheme(ThemeData.dark());
            dark.val=true;
            Get.back(); },
            title: Text('dark'.tr,style:  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
          )
        ],
      ))
  ));}
}