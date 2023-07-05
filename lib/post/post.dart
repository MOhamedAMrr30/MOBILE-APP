import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/login/login.dart';
import 'package:tourism/widgets/divider.dart';
import 'package:tourism/widgets/textfield.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:get/get.dart';

class Post extends StatefulWidget{
final String id;
  const Post({required this.id});
  @override
  State<Post> createState() => PostState();
}

class PostState extends State<Post>   {

  final comment_=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: Colors.transparent,elevation: 200,foregroundColor: Colors.black),
        body:
        StreamBuilder(stream:firestore.collection('/posts').doc(widget.id).snapshots() ,
            builder: (_,s){
              if(s.connectionState==ConnectionState.waiting)
                return Center(child: CircularProgressIndicator(color: fill_button));
              else if(!s.hasData)
                return Center(child: Text('No Notifications Found !',style: TextStyle(fontSize: 25,color: fill_button)  ));
              else if(s.hasError)
                return Center(child:errorHandler());
              return ListView.separated(itemBuilder: (_,i){
                Map<String,dynamic> map=s.data!.data()!;
                List<dynamic> images=map['images'] as  List<dynamic>;
                List<dynamic> comments=map['comments'] as  List<dynamic>;
                List<dynamic> likes=map['likes'] as  List<dynamic>;
                List<dynamic> dislikes=map['dislikes'] as  List<dynamic>;
                final like=false.obs;final dislike=false.obs;final comment=false.obs;
                if(auth.currentUser != null && likes.contains(auth.currentUser!.uid))
                  like.value=true;
                if(auth.currentUser != null && dislikes.contains(auth.currentUser!.uid))
                  dislike.value=true;
                double rate=(map['likes_num']/(map['likes_num']+map['dislikes_num']))*100;
                return Container(margin: EdgeInsets.only(top: 10),
                  height: ( (3*MediaQuery.of(context).size.height)/4)+(comments.length*(MediaQuery.of(context).size.height/8 )) ,
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
                            await firestore.collection('/posts').doc(s.data!.id).update({
                              "dislikes_num":FieldValue.increment(-1),
                              "dislikes":FieldValue.arrayRemove([auth.currentUser!.uid])
                            });
                          if(like.value)
                            await firestore.collection('/posts').doc(s.data!.id).update({
                              "likes_num":FieldValue.increment(-1),
                              "likes":FieldValue.arrayRemove([auth.currentUser!.uid])
                            });
                          else
                            await firestore.collection('/posts').doc(s.data!.id).update({
                              "likes_num":FieldValue.increment(1),
                              "likes":FieldValue.arrayUnion([auth.currentUser!.uid])
                            });
                          }
                          })),
                      ListTile(leading:Icon(Icons.comment_bank_outlined)  ,title:Text('comment'.tr),
                          onTap:(){
                            if(auth.currentUser ==null)
                              Get.to(()=>login(),transition: Transition.leftToRight);
                            else { comment.value=true;dialog(comment.value);}
                          }),
                      Obx(()=> ListTile(leading:dislike.value?Icon(TablerIcons.thumb_down_filled,color: Colors.blue):
                      Icon(TablerIcons.thumb_down_filled),title:Text('dislike'.tr),
                          onTap:() async {
                            if(auth.currentUser ==null)
                              Get.to(()=>login(),transition: Transition.leftToRight);
                            else
                            {if(like.value)
                              await firestore.collection('/posts').doc(s.data!.id).update({
                                "likes_num":FieldValue.increment(-1),
                                "likes":FieldValue.arrayRemove([auth.currentUser!.uid])
                              });
                            if(dislike.value)
                              await firestore.collection('/posts').doc(s.data!.id).update({
                                "dislikes_num":FieldValue.increment(-1),
                                "dislikes":FieldValue.arrayRemove([auth.currentUser!.uid])
                              });
                            else
                              await firestore.collection('/posts').doc(s.data!.id).update({
                                "dislikes_num":FieldValue.increment(1),
                                "dislikes":FieldValue.arrayUnion([auth.currentUser!.uid])
                              });
                            }}
                      ))
                    ])
                    ],border: TableBorder.all(color:Colors.grey.shade600,width: 1,style: BorderStyle.solid)),
                    Divider2(height: 5),
                    comments.length>0 ? Expanded(child:  Column( mainAxisSize:MainAxisSize.min ,children:comments.map((e)  {

                        Map<String,dynamic> data2=e as Map<String,dynamic>;
                        return FutureBuilder(future: firestore.collection('/tokens').doc(data2['id']).get(),
                            builder:(_,s1){
                              if(s1.connectionState==ConnectionState.waiting || !s1.hasData || s1.hasError)
                                return Container(height: 0,width: 0);
                              Map<String,dynamic> data3=s1.data!.data()!;
                              return Container(margin: EdgeInsets.symmetric(horizontal: 3.5,vertical: 2.5),
                                  width:MediaQuery.of(context).size.width-50 ,
                                  child:  Publisher(comment:data2['comment'] , name: data3['name'], url: data3['url'],context: context),
                                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(30),color: Colors.grey.shade500 ),
                                  constraints:BoxConstraints(minHeight:MediaQuery.of(context).size.height/10,maxHeight:MediaQuery.of(context).size.height/8 ));
                            } );
                    }).toList())  ):Container(height: 0,width: 0),Divider2(height: 10)
                ]
                )
                );}, separatorBuilder: (_,i){return Divider2(height: 5);},
                  itemCount: 1);
            })
    );}
void dialog(bool comment)
{Get.bottomSheet(
Container(height:(MediaQuery.of(context).size.height/9)+100 ,
    width: MediaQuery.of(context).size.width,color:Colors.white,child:
Column(children:[
  Stack(children: [
    Container(
      height:MediaQuery.of(context).size.height/10,
      width: double.infinity,
      color: fill_button ,
      alignment: Alignment.center,
      child: Text('comment'.tr,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
    ),
    Align(alignment: Alignment.topRight,child: IconButton(onPressed:(){
      Get.back(); }, icon: Icon(Icons.cancel_outlined,
        color: Colors.white)
    ))
  ]),Container(height:100 ,width: MediaQuery.of(context).size.width,
      child:     Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(()=>IconButton(icon:comment?Icon(Icons.send,color: Colors.blue,size:25):Icon(Icons.send,size:25),onPressed:comment? ()async{
              await   firestore.collection('/posts').doc(widget.id).update({
                "comments":FieldValue.arrayUnion([{"id":auth.currentUser!.uid, "comment":comment_.text}])
              });comment_.clear();Get.back();
            }:null)),
            Container(height: 80,width: (3*MediaQuery.of(context).size.width)/4,
                child:textfield(currentController: comment_, maxLength: 70, obscureText: false, enableInteractiveSelection: true,
                    keyboardType:TextInputType.text ,labelText: "comment2".tr, prefixicon: Text(''),validator: (i){
                      if(i!.isEmpty)
                        return 'error1'.tr;
                      return null;}
                ))
          ]))
]))
);}
}