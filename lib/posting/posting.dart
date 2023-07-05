import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/home/home.dart';
import 'package:tourism/posting/postingController.dart';
import 'package:tourism/widgets/Appbutton.dart';
import 'package:tourism/widgets/textfield.dart';
import 'package:tourism/widgets/divider.dart';
import 'package:tourism/widgets/textfield2.dart';

class Posting extends StatefulWidget{

  @override
  State<Posting> createState() => PostingState();
}

class PostingState extends State<Posting>   {

  final name=TextEditingController();
  final description=TextEditingController();
  final recommendations=TextEditingController();
  final GlobalKey<FormState> k=GlobalKey<FormState>();
  ValueNotifier<List<String>> paths=ValueNotifier<List<String>>([]);
  ValueNotifier<List<ImageProvider>> images=ValueNotifier<List<ImageProvider>>([]);
  final  getPosting=Get.put(PostingController());

  @override
  void dispose() {
     getReady();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        body:Form(key: k,child:SingleChildScrollView(reverse: true,child: Column(
            children: [
              Divider2(height: 20),
             GestureDetector(onTap: () async {
               if(paths.value.length<5)
                 {
                try{ final f=await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50);
                if(f !=null)
                {
                  paths.value.add(f.path);
                final rul=await f.readAsBytes();
                images.value.add(MemoryImage(rul));
                setState((){});
                } }
                on Exception catch(e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }}
               else
                 toast('max');
              },child:Container(
                height:MediaQuery.of(context).size.height/4 ,
                width: MediaQuery.of(context).size.width,
                color: foreground,
                child:Column(mainAxisAlignment: MainAxisAlignment.center
                ,mainAxisSize: MainAxisSize.min,children: [
                Container(height: MediaQuery.of(context).size.height/8,width:MediaQuery.of(context).size.width
                    ,child:  ListView.separated(scrollDirection:Axis.horizontal ,
                      itemBuilder: (_,i){return Container(margin: EdgeInsets.symmetric(horizontal: 5),
                          height: MediaQuery.of(context).size.height/8,width: 75,
                      decoration: BoxDecoration(image: DecorationImage(image:images.value[i] ,fit: BoxFit.fill))
                      );},
                      separatorBuilder:(_,i){return SizedBox(width: 5);},
                      itemCount: images.value.length)),
                  Divider2(height: 5),Icon(Icons.add_a_photo,size: 20,color: fill_button),
                  Divider2(height: 2.5),Text('addImage'.tr,style: TextStyle(fontSize: 20))
                ])
              )
              ), Divider2(height: 20),
              textfield(currentController: name, maxLength: 20,keyboardType: TextInputType.name,
                labelText: 'name2'.tr, obscureText: false,enableInteractiveSelection: true,
                prefixicon: Icon(Icons.hotel_outlined), validator: (String? m) {
                  if(m!.isEmpty)
                    return 'error1'.tr;
                  return null;
                },
              ), Divider2(height: 20),
          textField2(currentController: description, maxLength: 150,keyboardType: TextInputType.text,
            labelText: 'desc'.tr, obscureText: false,enableInteractiveSelection: true,
            prefixicon: Icon(Icons.description_outlined), validator: (String? m) {
              if(m!.isEmpty)
                return 'error1'.tr;
              else if(m.length<50)
                return 'error5'.tr;
              return null;
            },lines:5)
          , Divider2(height: 20),
              textField2(currentController: recommendations, maxLength: 100,keyboardType: TextInputType.text,
                  labelText: 'rec'.tr, obscureText: false,enableInteractiveSelection: true,
                  prefixicon: Icon(Icons.recommend_outlined), validator: (String? m) {
                    if(m!.isEmpty)
                      return 'error1'.tr;
                    else if(m.length<25)
                      return 'error6'.tr;
                    return null;
                  },lines:3),
              Divider2(height: 20),Appbutton(pressed: () async {
                if(k.currentState!.validate())
                {
                  if(paths.value.length<1)
                    toast('addImage');
                  else
                  {
                  bool? result=  await getPosting.Profile(name.text, description.text,recommendations.text, paths.value);
                if(result!)   {getReady(); curr_screen.value=Home();}
                  }}
              }, child: 'post')
            ]
        ))
        ));
  }

  void getReady()
  {name.clear(); description.clear(); recommendations.clear();paths.value.clear();images.value.clear();}
}