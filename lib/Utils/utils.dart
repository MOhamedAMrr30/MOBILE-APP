import 'dart:math';
import 'package:flutter_badger/flutter_badger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:locally/locally.dart';
import 'package:toast/toast.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/home/home.dart';
import 'package:tourism/notifications/notifications.dart';
import 'package:tourism/notifications/sqflite.dart';
import 'package:tourism/profile/profile.dart';
import 'package:tourism/setting/setting.dart';
import 'package:tourism/widgets/divider.dart';

final get=GetStorage();
List<IconData> icons=[Icons.home_outlined,Icons.notifications_none_outlined,Icons.account_circle_outlined,
Icons.settings];
List<Widget> screens=[Home(),Notifications(),Profile(),Setting()];
final dark=false.val('dark');
final get_image= DecorationImage(image:AssetImage('assets/download.png'),fit: BoxFit.fill ).obs;
final language='en'.val('language');
final badger=0.val('badge');
DB db=DB();
final rdn=Random();
late Locally locally;
final currentindex=0.obs;
final auth=FirebaseAuth.instance;
final messaging=FirebaseMessaging.instance;
final firestore=FirebaseFirestore.instance;
final  curr_screen=screens[0].obs;
final s_key='AAAAPqwtgSs:APA91bFoDuS8_'
    '27ZD7UIMzgx8fzilXpym-bBWhgGYGNBUSmG3ckNLcsNHzNO2PoWzqDa9W-'
    '9Ma5G9W_3gXabA0ISprLR379IebUWpdAMJrcss7'
    '-GymTJSr7684PzxdSviSOJzIrgplXW';

void toast(String text)
{Toast.show(text.tr,gravity: Toast.bottom,duration:Toast.lengthLong,backgroundColor:fill_button  );}

void internetChecker(){
  InternetConnectionChecker().onStatusChange.listen((status) async { //feature out of scope
    switch (status) {
      case InternetConnectionStatus.connected:
      await  Get.closeCurrentSnackbar();
        break;
      case InternetConnectionStatus.disconnected:
        Get.showSnackbar(GetSnackBar(backgroundColor: Colors.red,title:'disconnect'.tr ,titleText: Text('disconnect'.tr,style: TextStyle(color: foreground)),message: '',
            messageText: Text(''),mainButton:TextButton(onPressed:() async {      await  Get.closeCurrentSnackbar();
            },child: Text('ok'.tr,style: TextStyle(color: foreground))) ));
        break; }
  });
}

Widget errorHandler(){
    return Container(child: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Icon(Icons.error_outline,size: 25,color:Colors.red),
        Divider2(height:10),
        Text('error'.tr,style: TextStyle(fontSize:25,color: Colors.black ),)
      ],),),);

}

Future firebaseMessaging()async{
  var per=await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (per.authorizationStatus == AuthorizationStatus.authorized || per.authorizationStatus == AuthorizationStatus.provisional)
  { var gim=await messaging.getInitialMessage();
  if(gim != null)
  {
    await messaging.getInitialMessage().then((event)async {
      locally.show(title: event!.notification!.title, message: event.notification!.body);
      while(event!.notification!.title !=null)
     { await db.insertDB(rdn.nextInt(1000000).toString(), event.notification!.body!, event.notification!.title!);break;}
    });}
  else if(FirebaseMessaging.onMessageOpenedApp != null)
  { await FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    locally.show(title: event.notification!.title, message: event.notification!.body);
    while(event.notification!.title !=null)
    { badger.val=badger.val+1;
    FlutterBadger.updateBadgeCount(badger.val);
      await db.insertDB(rdn.nextInt(1000000).toString(), event.notification!.body!, event.notification!.title!);break;}  });}
  await   FirebaseMessaging.onMessage.listen((event)async {
    locally.show(title: event!.notification!.title, message: event.notification!.body);
    while(event.notification!.title !=null)
    { await db.insertDB(rdn.nextInt(1000000).toString(), event.notification!.body!, event.notification!.title!);break;}  });

  }
  else
    Toast.show("you don‘t have permission to send notifications",gravity: Toast.bottom,duration:Toast.lengthLong );
}
void local(BuildContext context) {
  locally = Locally(
    iosRequestAlertPermission: true,
    iosRequestBadgePermission: true,
    iosRequestSoundPermission: true,
    appIcon: 'ic_launcher',
    context: context,
    payload: 'test',
    pageRoute: MaterialPageRoute(builder: (_) => Notifications()),
  );}

Widget Publisher({required String comment,required String name,required String url,required BuildContext context})
{
  return ListTile(leading:  Container(height:(MediaQuery.of(context).size.height/10) ,width:  (MediaQuery.of(context).size.width/10)
      , decoration: BoxDecoration(color:Colors.redAccent ,shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(url),fit: BoxFit.fill),
      )),title:Text(name),subtitle:comment==''?null: Text(comment) );
}

Widget Slider2(List<dynamic> urls,BuildContext context)
{
  return Carousel(
      height:MediaQuery.of(context).size.height/5 ,
      autoScroll: true,
      stopAtEnd: true,
      indicatorBarColor: Colors.transparent,
      activateIndicatorColor: fill_button,
      unActivatedIndicatorColor: foreground,
      animationPageCurve: Curves.bounceInOut,
      indicatorHeight: 5,
      indicatorWidth: 10,
      items: urls.map((e) {
        return   Container(decoration: BoxDecoration(color:Colors.redAccent ,shape: BoxShape.rectangle,
            image: DecorationImage(image: NetworkImage(e.toString()),fit: BoxFit.fill)));
      }).toList()
  );
}