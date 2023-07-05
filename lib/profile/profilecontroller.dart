import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tourism/Utils/utils.dart';

class ProfileController extends GetxController {

  Future<bool?> Profile(String email,String name,String image) async{

    try {
      await auth.currentUser!.updateEmail(email);
      await auth.currentUser!.updateDisplayName(name);
    if(image !=''){  String img= await userImage(image,auth.currentUser!.uid);
      await auth.currentUser!.updatePhotoURL(img);}
      toast('done4');
      return true;
    }
    on FirebaseAuthException catch( e) {
      toast(e.code);
      return false;
    }
  }

  Future<String> userImage(String path,String uid)
  async { String fileUrl='';
await firestore.collection('/tokens').doc(uid).get().then((value) async {
 Map<String,dynamic> data= value.data()!;
 String  name= data['image'];
 var storageReference = FirebaseStorage
     .instance
     .ref()
     .child(name);
 File f = File(path);
 var Task =
 storageReference.delete();
 await Task;
 var uploadTask =
 storageReference.putFile(f);
 await uploadTask.whenComplete(() async {
   fileUrl = await storageReference
       .getDownloadURL();
   await firestore.collection('/tokens').doc(uid).update({'image': name,
     "url":fileUrl,"name":auth.currentUser!.displayName});
 });
});
  return fileUrl; }

}