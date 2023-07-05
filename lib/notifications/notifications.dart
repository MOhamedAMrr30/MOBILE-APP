import 'package:flutter/material.dart';
import 'package:tourism/Utils/Elements.dart';
import 'package:tourism/Utils/utils.dart';
import 'package:tourism/widgets/divider.dart';

  class Notifications extends StatefulWidget{

  @override
  State<Notifications> createState() => NotificationsState();
  }

  class NotificationsState extends State<Notifications>   {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: FutureBuilder(
        future: db.query()
        ,builder: (_,s){
          if(s.connectionState==ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(color: fill_button));
          else if(!s.hasData)
            return Center(child: Text('No Notifications Found !',style: TextStyle(fontSize: 25,color: fill_button)  ));
          else if(s.hasError)
          return Center(child:errorHandler());
        List<dynamic> data=s.data!;
        return ListView.separated(itemBuilder: (_,i){
          Map<String,dynamic> map=data[i] as  Map<String,dynamic>;
          return ListTile(title: Text(map['publisher']),
          onTap: (){curr_screen.value=screens.elementAt(0);},
          subtitle:Text(map['content'] ),trailing: IconButton(icon:Icon(Icons.delete,color: fill_button)
                  ,onPressed:()async{await db.delete(map['date']);setState(() {});
          }));
        }, separatorBuilder: (_,i){return Divider2(height: 5);},
            itemCount: data.length);
        })
        );
  }
}