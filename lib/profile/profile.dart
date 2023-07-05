import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/profile/profilecontroller.dart';
import 'package:tourism/widgets/Appbutton.dart';
import 'package:tourism/widgets/badge.dart';
import 'package:tourism/widgets/textfield.dart';
import 'package:tourism/widgets/divider.dart';

class Profile extends StatelessWidget{

  String path='';
  final name=TextEditingController();
  final email=TextEditingController();
  final GlobalKey<FormState> k=GlobalKey<FormState>();
  final  getProfile=Get.put(ProfileController());

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
              },child:Obx(()=>badge(child:Icons.mode,image: get_image.value))
              ), Divider2(height: 20),
              textfield(currentController: name, maxLength: 20,keyboardType: TextInputType.name,
                labelText: 'name'.tr, obscureText: false,enableInteractiveSelection: true,
                prefixicon: Icon(FontAwesomeIcons.user), validator: (String? m) {
                  if(m!.isEmpty)
                    return 'error1'.tr;
                  return null;
                },
              ),
              Divider2(height: 20),
              textfield(currentController: email, maxLength: 30,keyboardType: TextInputType.emailAddress,
                labelText: 'email'.tr, obscureText: false,enableInteractiveSelection: true,
                prefixicon: Icon(Icons.email), validator: (String? m) {
                  if(m!.isEmpty)
                    return 'error1'.tr;
                  else if(!m.isEmail)
                    return 'error2'.tr;
                  return null;
                },
              ), Divider2(height: 20),Appbutton(pressed: () async {
                if(k.currentState!.validate())
                {
                 await getProfile.Profile(email.text, name.text, path);
                }
              }, child: 'update')
            ]
        ))
        ));
  }

  void getReady()
  {
    name.text=auth.currentUser!.displayName!; email.text=auth.currentUser!.email!; path='';
    get_image.value=DecorationImage(image:NetworkImage(auth.currentUser!.photoURL!),fit: BoxFit.fill );
  }
}