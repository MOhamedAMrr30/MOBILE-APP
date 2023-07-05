import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tourism/Utils/utils.dart';

class LoginController extends GetxController {

 Future<bool?> Login(String email,String password) async{

     try {
      final result= await auth.signInWithEmailAndPassword(
           email: email, password: password);
   if(result.user != null)
    { await token(result.user!.uid);
      toast('done2'); return true;}
     }
     on FirebaseAuthException
     catch( e) {
       toast(e.code);
       return false;
     }
     return false;
 }

 Future<void> token(String uid)
 async {await firestore.collection('/tokens').doc(uid).update({'tokken':await messaging.getToken()});}
}