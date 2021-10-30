import 'package:api_test/controllers/AccountController.dart';
import 'package:api_test/view/emailTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Inbox extends StatelessWidget {
  final AccountController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  Icon(Icons.email_outlined,color: Colors.redAccent,),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Inbox",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),

                      ],
                    ),
                  ),
                  TextButton(onPressed: () async{
                    controller.AddMessage(await controller.account[0].getMessages());

                  }, child:Icon(Icons.refresh,color: Colors.redAccent,))
                ],
              ),
            ),
          ),
        ),body:  SingleChildScrollView(
        physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          GetBuilder<AccountController>(
              builder: (ac) => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:ac.messages.length,
                  itemBuilder: (context,index){
                    return  EmailTile(ac.messages[index]);
                  })
          ),
        ],
      ),
    )
    ));
  }
}
