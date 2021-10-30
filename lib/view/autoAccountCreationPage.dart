import 'dart:convert';

import 'package:api_test/controllers/AccountController.dart';
import 'package:api_test/models/Account.dart';
import 'package:api_test/view/highlightedText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'Inbox.dart';
import 'emailTile.dart';
class AutoAccountScreen extends StatefulWidget {
static const _chars='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  @override
  _AutoAccountScreenState createState() => _AutoAccountScreenState();
}

class _AutoAccountScreenState extends State<AutoAccountScreen> {
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
      ),body: Column(  mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [FutureBuilder<String>(builder: (context,snapshot){
          if(snapshot.data=="" || snapshot.data==null){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else {
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Obx(()=> HighlightedText("Your Email : "+controller.account[0].address.toLowerCase(),Colors.redAccent,FontWeight.w500,20)),
                  GetBuilder<AccountController>(
                    builder: (ac) => ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:ac.messages.length,
                        itemBuilder: (context,index){
                          return  EmailTile(ac.messages[index]);
                        })
                  ),
                  // ListView.builder(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount:controller.messages.length,
                  //     itemBuilder: (context,index){
                  //       return  EmailTile(controller.messages[index]);
                  //     })
                ],
              ),
            );
          }
        },future: createAccount(),initialData: null,)],
      ),
    ));
  }

  String getRandomString(int len){
    var random=Random.secure();
    return String.fromCharCodes(Iterable.generate(len,(_)=>AutoAccountScreen._chars.codeUnitAt(random.nextInt(AutoAccountScreen._chars.length))));
  }

  Future<String> createAccount()async{
    String name=getRandomString(8)+"@"+controller.domains[0];
    String pass=getRandomString(8);
    Account acc=Account();
    await acc.createAccount(name,pass);

    //http.Response response = await Account(Random().nextInt(9999999).toString()+"@"+accountController.domains[Random().nextInt(accountController.domains.length-1)+0],Random().nextInt(9999999).toString()).createAccount() as http.Response;
    controller.account.clear();
    var response= (await acc.login(name,pass));
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      acc.address=name;
      acc.pass=pass;
      acc.token=jsonDecode(response.body)['token'];
      acc.id=jsonDecode(response.body)['id'];
      controller.account.clear();
      controller.account.add(acc);
      controller.messages=await controller.account[0].getMessages();
    }
    return "done";
  }
}
