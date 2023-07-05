import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tourism/Utils/utils.dart';

class PostingController extends GetxController {

  List<String> Url=[];

  Future<bool?> Profile(String name,String desc,String rec,List<String> images) async{
    try {
     List<String> Urls=await postImages(images);
     print(Urls);
     await firestore.collection('/posts').add({
       "user_id":auth.currentUser!.uid,
       "user_name":auth.currentUser!.displayName,
       "user_photo":auth.currentUser!.photoURL,
       "name":name,
       "desc":desc,
       "rec":rec,
       "images":FieldValue.arrayUnion(Urls),
       "comments":FieldValue.arrayUnion([]),
       "likes":FieldValue.arrayUnion([]),
       "dislikes":FieldValue.arrayUnion([]),
       "likes_num":0,
       "dislikes_num":0,
       "time":FieldValue.serverTimestamp()
     });
      send_fbm(1, desc, auth.currentUser!.displayName!+' added '+name);
      toast('done5');
      return true;
    }
    on FirebaseAuthException catch( e) {
      toast(e.code);
      return false;
    }
    return false;
  }

  Future<List<String>> postImages(List<String> paths)
  async {
    paths.forEach((element) async {
      int timestamp = new DateTime.now()
          .millisecondsSinceEpoch;
      String  name= 'posts/img_' + timestamp.toString() + '.jpg';
      var storageReference = FirebaseStorage
          .instance
          .ref()
          .child(name);
      File f = File(element);
      var uploadTask =
      storageReference.putFile(f);
      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((value) => Url.addAll([value]));
      });
    });
  return Url; }

  Future send_fbm(int id,String body,String Title)async{
    await firestore.collection('/tokens').snapshots().forEach((element) {
   element.docs.forEach((element) async {
     Map<String,dynamic> data= element.data();
     // delete it there is no need to send notification to the user who post

         await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
           headers: <String, String>{
             'Content-Type': 'application/json',
             'Authorization': 'key=$s_key',
           },
           body: jsonEncode (
             <String, dynamic>{
               'notification': <String, dynamic>{
                 'body': body,
                 'title':Title
               },
               'priority': 'high',
               'data': <String, dynamic>{
                 'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                 'id': id,
                 'status': 'done'
               },
               'to': data['tokken'],
             })
         );}
     );
    });
    }
}