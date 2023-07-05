import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tourism/Utils/utils.dart';

class RegisterController extends GetxController {

  Future<bool?> Register(String email,String password,String name,String image) async{

    try {
      final result= await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if(result.user != null)
        {await result.user!.updateDisplayName(name);
         String img= await userImage(image,result.user!.uid,name);
         await result.user!.updatePhotoURL(img);
         await token(result.user!.uid);
         toast('done');
         return true;}
    }
    on FirebaseAuthException
    catch( e) {
      toast(e.code);
      return false;
    }
    return false;
  }

  Future<String> userImage(String path,String uid,String name2)
  async { String fileUrl='';
    int timestamp = new DateTime.now()
        .millisecondsSinceEpoch;
  String  name= 'users/img_' + timestamp.toString() + '.jpg';
  var storageReference = FirebaseStorage
        .instance
        .ref()
        .child(name);
    File f = File(path);
    var uploadTask =
    storageReference.putFile(f);
    await uploadTask.whenComplete(() async {
       fileUrl = await storageReference
          .getDownloadURL();
       await firestore.collection('/tokens').doc(uid).set({'image': name,
       "url":fileUrl,"name":name2});
    });
    return fileUrl;
  }
Future<void> token(String uid)
async {await firestore.collection('/tokens').doc(uid).update({'tokken':await messaging.getToken()
});}
}