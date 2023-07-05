import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/register/registercontroller.dart';
import 'package:tourism/widgets/Appbutton.dart';
import 'package:tourism/widgets/badge.dart';
import 'package:tourism/widgets/passwordtextfield.dart';
import 'package:tourism/widgets/textfield.dart';
import 'package:tourism/widgets/divider.dart';

class register extends StatelessWidget{

  String path='';
  final name=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final rePassword=TextEditingController();
  final GlobalKey<FormState> k=GlobalKey<FormState>();
  final  getRegister=Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    getReady();
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,elevation: 200,foregroundColor: Colors.black),
        body:Form(key: k,child:SingleChildScrollView(reverse: true,child: Column(
            children: [
              Divider2(height: 20),
        GestureDetector(onTap: () async {
          try{ final f=await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50);
          if(f !=null)
          {  path=f.path;
            final rul=await f.readAsBytes();
          get_image.value= DecorationImage(image:MemoryImage(rul),fit: BoxFit.fill);}
          }
          on Exception catch(e)
          { if (kDebugMode) {
            print(e);
          }}
        },child:Obx(()=>badge(child:Icons.add,image: get_image.value))
        ),
              Divider2(height: 20),
              Text('register'.tr,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              Divider2(height: 20),
              textfield(currentController: name, maxLength: 20,keyboardType: TextInputType.name,
                labelText: 'namelabel'.tr, obscureText: false,enableInteractiveSelection: true,
                prefixicon: Icon(FontAwesomeIcons.user), validator: (String? m) {
                  if(m!.isEmpty)
                    return 'error1'.tr;
                  return null;
                },
              ),
              Divider2(height: 20),
              textfield(currentController: email, maxLength: 30,keyboardType: TextInputType.emailAddress,
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
              ),Divider2(height: 20),
            passwordtextfield(currentController: rePassword, maxLength: 15, keyboardType: TextInputType.visiblePassword,
              enableInteractiveSelection: true, labelText: 'password2'.tr, prefixicon: Icon(Icons.password),
            ),
              Divider2(height: 20),Appbutton(pressed: () async {
                if(k.currentState!.validate())
                  {
                    if(path.length<2)
                      toast('addImage');
                    else if(password.text != rePassword.text)
                      toast('identical');
                    else
                      {
                      await  getRegister.Register(email.text,password.text,name.text,path);
                      getReady(); Get.back();
                      }
                  }
              }, child: 'register')
            ]
        ))
        ));
  }

void getReady()
{
  name.clear(); email.clear(); password.clear(); rePassword.clear(); path='';
  get_image.value=DecorationImage(image:AssetImage('assets/download.png'),fit: BoxFit.fill );
}
}