import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_badger/flutter_badger.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/home/home.dart';
import 'package:tourism/languages/languages.dart';
import 'package:tourism/login/login.dart';
import 'package:tourism/posting/posting.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  badger.val=0;
  internetChecker();
  await GetStorage.init();
  FlutterBadger.removeBadge();
  await  Firebase.initializeApp();
  ErrorWidget.builder=(FlutterErrorDetails D)=>errorHandler();
  runApp(GetMaterialApp(
      theme:dark.val? ThemeData.dark():ThemeData.light(),
      debugShowCheckedModeBanner: false,
      locale:Locale(language.val),
      fallbackLocale:Locale("en") ,
      translations:Languages() ,home:auth.currentUser ==null? login():MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    local(context);
    firebaseMessaging();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fill_button,
        title:Text('title'.tr),
      ),
      body:Obx(() => curr_screen.value),
        floatingActionButton:  FloatingActionButton(
          backgroundColor: fill_button,
          onPressed: () {
            if(auth.currentUser ==null)
              Get.to(()=>login(),transition: Transition.leftToRight);
            else
              curr_screen.value=Posting();
            },
          child:Icon(Icons.add) ,
        ),
        floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:Obx(()=> AnimatedBottomNavigationBar(
          backgroundColor:foreground ,
          icons: icons,
          inactiveColor:border ,
          activeColor:fill_button ,
          activeIndex:currentindex.value,
          gapLocation: GapLocation.center,
          borderColor: border,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index)  { currentindex.value = index;
            if(index==2 && auth.currentUser==null)
              Get.to(()=>login(),transition: Transition.leftToRight);
else
          curr_screen.value=screens.elementAt(index);
          },
          //other params
        ))
    );
  }
}