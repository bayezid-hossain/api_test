import 'package:api_test/models/Message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'openEmail.dart';

class EmailTile extends StatelessWidget {
  final Message message;
  EmailTile(this.message);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print(message.text);
        Get.to(()=>OpenEmail(message));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.person),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(message.fromName, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(message.fromAddress, style: TextStyle(fontSize: 14),),
                          SizedBox(height: 6,),
                          Text("Subject: "+message.subject,style: TextStyle(fontSize: 13,color: Colors.grey.shade600,fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(message.date.substring(0,message.date.indexOf("T")),style: TextStyle(fontSize: 12,fontWeight:FontWeight.w400),),
          ],
        ),
      ),
    );
  }
}
