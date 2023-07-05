import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tourism/Utils/utils.dart';

class ForgetPasswordController extends GetxController {

  Future<bool?> ForgetPassword(String email) async{
    try {
   await auth.sendPasswordResetEmail(email: email).whenComplete(() {
     toast('done3');
   });
   return true;
      }
    on FirebaseAuthException catch( e) {
      toast(e.code);
      return false;
    }
  }
} //method of changing password