import 'dart:convert';

import 'package:api_test/controllers/AccountController.dart';
import 'package:api_test/models/Account.dart';
import 'package:api_test/view/autoAccountCreationPage.dart';
import 'package:api_test/view/createAccount.dart';
import 'package:api_test/view/highlightedText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Inbox.dart';
class HomePage extends StatelessWidget {
  final AccountController accountController=Get.find();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[

                SizedBox(width: 10,),
                Icon(Icons.email_outlined,color: Colors.blueAccent,),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Login",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(height: 150,width: 150,
          child: Image.asset("assets/mail_logo.png"),),
        ),
            Padding(padding:EdgeInsets.fromLTRB(30,20,30,20),child: SizedBox(child: Text("Mail.tm, A temporary email service provider!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),)),
            Padding(padding:EdgeInsets.fromLTRB(34,0,0,10),child: Align(alignment:Alignment.topLeft,child: Text("Email"))),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                onChanged: (text)
                {
                  // When user enter text in textfield getXHelper checktext method will get called
                },
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors.black
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  ),
                  isDense: true,                      // Added this
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(padding:EdgeInsets.fromLTRB(34,0,0,10),child: Align(alignment:Alignment.topLeft,child: Text("Password"))),
             Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextField(
                  controller: pass,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.black
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    isDense: true,                      // Added this
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  ),
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                ),
            ),
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () async{
                    // call login method
                    //getXHelper.login();
                    print(pass.text);
                    String emailAddress=email.text;
                    String password=pass.text;
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => new Dialog(
                          child: new Container(
                            alignment: FractionalOffset.center,
                            height: 80.0,
                            padding: const EdgeInsets.all(20.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                new CircularProgressIndicator(),
                                new Padding(
                                  padding: new EdgeInsets.only(left: 10.0),
                                  child: new Text("Entering your account"),
                                ),
                              ],
                            ),
                          ),
                        ));
                    // call login method
                    //getXHelper.login();
                    Account acc=Account();
                    var response= (await acc.login(emailAddress,password));
                    print(response.statusCode);
                    print(response.body);
                    if(response.statusCode==200){
                      acc.address=email.text;
                      acc.pass=pass.text;
                      acc.token=jsonDecode(response.body)['token'];
                      acc.id=jsonDecode(response.body)['id'];
                      accountController.account.clear();
                      accountController.account.add(acc);
                      accountController.messages=await accountController.account[0].getMessages();
                      Navigator.pop(context);
                      email.clear();
                      pass.clear();
                      Get.off(()=>Inbox());
                    }
                    else{
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (_) => new Dialog(
                            child: new Container(
                              alignment: FractionalOffset.center,
                              height: 80.0,
                              padding: const EdgeInsets.all(20.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  new Padding(
                                    padding: new EdgeInsets.only(left: 10.0),
                                    child: new Text(jsonDecode(response.body)['message']+""),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }
                  },
                  child: Text("LOGIN",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () async {
                    Get.to(()=>CreateAccount());
                  },
                  child: Text("Create Account",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blueGrey,
                  onPressed: ()async {
                    // call login method
                    //getXHelper.login();
                    Get.to(()=>AutoAccountScreen());
                  },
                  child: Text("Continue with Random Account",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
