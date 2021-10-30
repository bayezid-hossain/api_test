import 'package:api_test/controllers/AccountController.dart';
import 'package:api_test/view/emailTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Inbox extends StatelessWidget {
  final AccountController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Inbox",style: TextStyle(fontSize: 20,fontFamily: "Kalpurush",color: Colors.black)),backgroundColor: Colors.white,leading: Icon(Icons.email_outlined,color: Colors.red,),),
body:  SingleChildScrollView(
        physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          RefreshIndicator(
            onRefresh: () =>controller.account[0].getMessages(),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:controller.messages.length,
                itemBuilder: (context,index){
                  return  EmailTile(controller.messages[index]);
                }),
          )
        ],
      ),
    )
    ));
  }
}
