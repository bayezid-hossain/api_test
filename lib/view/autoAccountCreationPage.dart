import 'dart:convert';

import 'package:api_test/controllers/AccountController.dart';
import 'package:api_test/models/Account.dart';
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
      appBar: AppBar(title: Text("Inbox",style: TextStyle(fontSize: 20,fontFamily: "Kalpurush",color: Colors.black)),backgroundColor: Colors.white,leading: Icon(Icons.email_outlined,color: Colors.red,),),
      body: Column(  mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [FutureBuilder<String>(builder: (context,snapshot){
          if(snapshot.data=="" || snapshot.data==null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Obx(()=> Text("Your email address is : "+controller.account[0].address)),
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
    final AccountController accountController=Get.find();
    print(accountController.domains);
    String name=getRandomString(8)+"@"+accountController.domains[0];
    String pass=getRandomString(8);
    Account acc=Account();
    await acc.createAccount(name,pass);

    //http.Response response = await Account(Random().nextInt(9999999).toString()+"@"+accountController.domains[Random().nextInt(accountController.domains.length-1)+0],Random().nextInt(9999999).toString()).createAccount() as http.Response;
    accountController.account.clear();
    var response= (await acc.login(name,pass));
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      acc.address=name;
      acc.pass=pass;
      acc.token=jsonDecode(response.body)['token'];
      acc.id=jsonDecode(response.body)['id'];
      accountController.account.clear();
      accountController.account.add(acc);
      accountController.messages=await accountController.account[0].getMessages();
      Navigator.pop(context);
      Get.to(Inbox());
    }
    return "done";
  }
}
