import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/login/login.dart';
import 'package:tourism/post/post.dart';
import 'package:tourism/widgets/divider.dart';


class Home extends StatefulWidget{

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home>   {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:RefreshIndicator(onRefresh:()async{setState(() {});} ,child:
        StreamBuilder(stream:firestore.collection('/posts').snapshots()//take data from firebase posts is a schedule name,
              ,builder: (_,s){
          if(s.connectionState==ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(color: fill_button));
            else if(!s.hasData)
              return Center(child: Text('No Notifications Found !',style: TextStyle(fontSize: 25,color: fill_button)  ));
            else if(s.hasError)
              return Center(child:errorHandler());
      List<dynamic>  data=s.data!.docs;
          return ListView.separated(itemBuilder: (_,i){
            Map<String,dynamic> map=s.data!.docs[i].data();
            List<dynamic> images=map['images'] as  List<dynamic>;
            List<dynamic> comments=map['comments'] as  List<dynamic>;
            List<dynamic> likes=map['likes'] as  List<dynamic>;
            List<dynamic> dislikes=map['dislikes'] as  List<dynamic>;
            final like=false.obs;final dislike=false.obs;final comment=false.obs;
            if(auth.currentUser != null && likes.contains(auth.currentUser!.uid))
              like.value=true;//authenication method
            if(auth.currentUser != null && dislikes.contains(auth.currentUser!.uid))
              dislike.value=true;
            double rate=(map['likes_num']/(map['likes_num']+map['dislikes_num']))*100;
            return Container(margin: EdgeInsets.only(top: 10),
            constraints:BoxConstraints(maxHeight:(9*MediaQuery.of(context).size.height)/10 ,
            minHeight: MediaQuery.of(context).size.height/2 ) ,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:MainAxisSize.min ,
            children: [Publisher(name: map['user_name'],url: map['user_photo'],comment:'',context: context),
            Divider2(height: 5),Slider2(images,context),
            Divider2(height: 10),
            Text(' ${'name2'.tr}: ${map['name']}',style: TextStyle(fontWeight: FontWeight.bold)),
              Divider2(height: 10),
            Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
            Text(' ${'desc'.tr}: ${map['desc']}',style: TextStyle(fontWeight: FontWeight.bold)) ),
              Divider2(height: 10),
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                Text(' ${'rec'.tr}: ${map['rec']}',style: TextStyle(fontWeight: FontWeight.bold)) ),
          Divider2(height: 10),
              Text(' ${'like'.tr}: ${map['likes_num'].toString()}'),
              Text(' ${'dislike'.tr}: ${map['dislikes_num'].toString()}'),
              Text(' ${'rate'.tr}: ${rate.toStringAsFixed(1)} %'),Divider2(height: 5),
            Table(children: [TableRow(children: [
             Obx(()=>ListTile(leading:like.value?Icon(TablerIcons.thumb_up_filled,color: Colors.blue):
             Icon(TablerIcons.thumb_up_filled),title:Text('like'.tr) ,
                 onTap: ()async{if(auth.currentUser ==null)
                   Get.to(()=>login(),transition: Transition.leftToRight);
             else
               {if(dislike.value)
                 await firestore.collection('/posts').doc(s.data!.docs[i].id).update({
                   "dislikes_num":FieldValue.increment(-1),
                   "dislikes":FieldValue.arrayRemove([auth.currentUser!.uid])
                 });
                 if(like.value)
                   await firestore.collection('/posts').doc(s.data!.docs[i].id).update({
                     "likes_num":FieldValue.increment(-1),
                     "likes":FieldValue.arrayRemove([auth.currentUser!.uid])
                   });
                 else
                   await firestore.collection('/posts').doc(s.data!.docs[i].id).update({
                     "likes_num":FieldValue.increment(1),
                     "likes":FieldValue.arrayUnion([auth.currentUser!.uid])
                   });
               }
             })),
              ListTile(leading:Icon(Icons.comment_bank_outlined)  ,title:Text('comment'.tr),
              onTap:(){
                if(auth.currentUser ==null)
                  Get.to(()=>login(),transition: Transition.leftToRight);
                else { comment.value=true;
                Get.to(()=>Post(id:s.data!.docs[i].id),transition: Transition.leftToRight);
                }
              }),
              Obx(()=> ListTile(leading:dislike.value?Icon(TablerIcons.thumb_down_filled,color: Colors.blue):
            Icon(TablerIcons.thumb_down_filled),title:Text('dislike'.tr),
              onTap:() async {
                if(auth.currentUser ==null)
                  Get.to(()=>login(),transition: Transition.leftToRight);
                else
                {if(like.value)
                  await firestore.collection('/posts').doc(s.data!.docs[i].id).update({
                  "likes_num":FieldValue.increment(-1),
                  "likes":FieldValue.arrayRemove([auth.currentUser!.uid])
                });
                if(dislike.value)
                  await firestore.collection('/posts').doc(s.data!.docs[i].id).update({
                  "dislikes_num":FieldValue.increment(-1),
                  "dislikes":FieldValue.arrayRemove([auth.currentUser!.uid])
                });
                else
                await firestore.collection('/posts').doc(s.data!.docs[i].id).update({
                "dislikes_num":FieldValue.increment(1),
                "dislikes":FieldValue.arrayUnion([auth.currentUser!.uid])
                });
              }}
              ))
            ])
            ],border: TableBorder.all(color:Colors.grey.shade600,width: 1,style: BorderStyle.solid)),
           Divider2(height: 5),
           comments.length>0 ? Expanded(child:  Column( mainAxisSize:MainAxisSize.min ,children:comments.map((e)  {
             if(comments.indexOf(e)==0){
             Map<String,dynamic> data2=e as Map<String,dynamic>;
             return FutureBuilder(future: firestore.collection('/tokens').doc(data2['id']).get(),
                 builder:(_,s1){
             if(s1.connectionState==ConnectionState.waiting || !s1.hasData || s1.hasError)
               return Container(height: 0,width: 0);
             Map<String,dynamic> data3=s1.data!.data()!;
             return Container(margin: EdgeInsets.symmetric(horizontal: 3.5,vertical: 2.5),
             width:MediaQuery.of(context).size.width-50 ,
             child:  Publisher(comment:data2['comment'] , name: data3['name'], url: data3['url'],context: context
             ),decoration: BoxDecoration(borderRadius:BorderRadius.circular(30),color: Colors.grey.shade500 ),
             constraints:BoxConstraints(minHeight:MediaQuery.of(context).size.height/10,maxHeight:MediaQuery.of(context).size.height/8 ));
             } );}
             return Container(height: 0,width: 0);
           }).toList())  ):Container(height: 0,width: 0),comments.length>0?Text(' ${'more'.tr} ${comments.length-1} ${'comment'.tr}',style: TextStyle(fontWeight:FontWeight.bold,color: fill_button ))
                  :Container(height: 0,width: 0),Divider2(height: 10)]
            )
            );}, separatorBuilder: (_,i){return Divider2(height: 5);},//fasel ben posts
              itemCount: data.length);
        })
    ));
  }


}