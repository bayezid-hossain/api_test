import 'dart:convert';

import 'package:api_test/controllers/AccountController.dart';
import 'package:api_test/models/Account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Inbox.dart';
class CreateAccount extends StatelessWidget {

  final AccountController controller = Get.find();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

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
                      Text("Create Account",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(padding: EdgeInsets.fromLTRB(34, 0, 0, 10),
              child: Align(alignment: Alignment.topLeft, child: Text("User Name"))),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
              onChanged: (text) {
                // When user enter text in textfield getXHelper checktext method will get called
              },
              controller: email,
              decoration: InputDecoration(
                hintText: 'Your Name',
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
                isDense: true,
                // Added this
                contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              ),
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Domain: "),
                DropdownButton<String>(
                    hint: Text('Domain'),
                    value: controller.selectedValue,
                    onChanged: (newValue) {
                      controller.onSelected(newValue!);
                    },
                    elevation: 10,
                    items:  controller.domains.map((selectedType) {
                      return DropdownMenuItem(
                        child: new Text(
                          selectedType,
                        ),
                        value: selectedType,
                      );
                    }).toList(),),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(padding: EdgeInsets.fromLTRB(34, 0, 0, 10),
              child: Align(
                  alignment: Alignment.topLeft, child: Text("Password"))),
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
                isDense: true,
                // Added this
                contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              ),
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(padding: EdgeInsets.fromLTRB(34, 0, 0, 10),
              child: Align(alignment: Alignment.topLeft,
                  child: Text("Confirm Password"))),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
              controller: confirmpass,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
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
                isDense: true,
                // Added this
                contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              ),
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
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
                color: Colors.amberAccent,
                onPressed: () async {
                    if(pass.text!=confirmpass.text){
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
                                    child: new Text("Passwords Do Not Match"),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }else{
                      Account acc=Account();
                      print(email.text+controller.selectedValue);
                      String wholeEmail=email.text+"@"+controller.selectedValue;
                      var creationResponse=await acc.createAccount(wholeEmail,pass.text);
                      if(creationResponse.statusCode==422){
                        showDialog(
                            barrierDismissible: true,
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
                                      child: new Text("Email Already Used"),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }
                      else if(creationResponse.statusCode==201){
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
                                    new Padding(
                                      padding: new EdgeInsets.only(left: 10.0),
                                      child: new Text("Creating Account"),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                     controller.account.clear();
                      var response= (await acc.login(wholeEmail,pass.text));
                      print(response.statusCode);
                      print(response.body);
                      if(response.statusCode==200){
                        acc.address=wholeEmail;
                        acc.pass=pass.text;
                        acc.token=jsonDecode(response.body)['token'];
                        acc.id=jsonDecode(response.body)['id'];
                        controller.account.clear();
                        controller.account.add(acc);
                        controller.messages=await controller.account[0].getMessages();
                        Navigator.pop(context);
                        Get.to(()=>Inbox());
                      }
                    }}
                },
                child: Text("Create Account"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}