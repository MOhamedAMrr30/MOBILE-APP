import 'package:get/get.dart';

class Languages implements Translations{
  @override
  Map<String, Map<String, String>> get keys =>{
    "ar":{"title":"فيستور","login":"تسجيل الدخول", "register":"تسجيل حساب","language":"تغيير اللغة","choose":"أختر اللغة",
     "logout":"تسجيل الخروج", "error1": "هذا الحقل مطلوب",'addImage':"من فضلك أضف الصورة","done5":"تم النشر",
  "done2":"تم تسجيل الدخول بنجاح", "uppercase":"يجب أن يكون 8 حروف عالاقل ,مكون من حروف ,أرقام  ورموز",
      'done':"تم تسجيل الحساب بنجاح",'identical':"كلمتي المرور ليست متطابقة","visitor":"الدخول كمتصفح",
      "reset":"تعديل رمز المرور","done3":"تم إرسال بريد تعديل رمز المرور إليك","choose2":"أختر الوضع",
      "phonelabel":"أدخل رقم الهاتف","1":"رقم الهاتف غير صحيح","password":"أدخل رمز المرور","ok":"موافق",
      "light":"وضع السطوع","dark":"وضع مظلم","mode":"تغيير الوضع","done4":"تم التعديل بنجاح",
   "forget":"نسيت كلمة المرور ؟","noaccount":"ليس لديك حساب هنا ؟","namelabel":"أدخل الاسم بالكامل",
      "name":"الاسم بالكامل","email": "البريد الالكتروني","update":"تعديل الحساب","disconnect":"تم قطع الاتصال بالشبكة",
      "emaillabel":"أدخل البريد الالكتروني","error2":"بريد ألكترونى خطأ","password2":"أعد أدخال رمز المرور",
    "error":"حدث خطأ ما", "name2":"أسم المكان","desc":"الوصف","rec":"التوصيات",
      'error5':"الوصف يجب الا يقل عن 50 حرف","error6":"التوصيات يجب الا تقل عن 20 حرف",'post':"أنشر",
        "max":"أقصي حد 5 صور","like":"أعجبني","dislike":"لم يعجبني","comment":"تعليق",'rate':"معدل الاعجاب","comment2":"أضف تعليق",
      "more":"وأكثر من"},
    "en":{"title":"facetour","login":"Log in","addImage":"Please Add Image","done":"Account Created Successfully",
    "register":"Register Account","language":"Change Language","choose":"Choose Language",
      "logout":"Log out", "error1": "This field needed","forget":"Forget Password ?","done5":"Posted",
      "name2":"Place Name","desc":"Description","rec":"Recommendations","post":"Post",
      'error5':"Description must be more than 50 characters","error6":"recommendation must be more than 20 characters",
      "light":"Light Mode","dark":"Dark Mode","mode":"Change Mode","update":"Update Account",
      "done2":"Logged In Successfully","done3":"Reset Password Email Sent","visitor":"Login As Visitor",
      "identical":"Password Fields Not Identical","reset":"Reset Password","choose2":"Choose Mode",
      "uppercase": "Password must be at least 8 characters, include an uppercase letter, number and symbol"
   ,"phonelabel":'Enter Phone Number' ,"1":"Invalid Phone Number","password":"Enter Password","ok":"Ok",
      "name":"Full Name","email":"Your Email","done4":"Updated Successfully","disconnect":"Internet Connection Disconnected",
    "noaccount":"Don’t Have Account Here ?","namelabel":"Enter Full Name","emaillabel":"Enter Your Email",
    "error2":"Invalid Email Address","password2":"Re-enter Password","error":"SomeThing Went Error !",
    "max":"Maximum 5 Images","like":"Like","dislike":"disLike","comment":"Comment",'rate':"Rate","comment2":"Add Comment",
    "more":"And more than another"}
  };
}