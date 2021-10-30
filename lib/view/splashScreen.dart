import 'package:api_test/controllers/AccountController.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../models/Networking.dart';
import 'homePage.dart';
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AccountController accountController=Get.put(AccountController());
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_){
      loadDomains();
    });
  }
  void loadDomains()async{
    Networking networking=Networking();
    accountController.domains=await networking.getDomains();
    accountController.selectedValue=accountController.domains[0];
    print(accountController.domains);
    Get.off(HomePage());
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        Text("Welcome",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/img2.jpg"),
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(child: Container()),
              Text("A temporary Mail API",style: TextStyle(fontSize: 20,fontFamily: "Kalpurush"),),
              Align(
                alignment: Alignment.bottomCenter,
                child: SpinKitThreeBounce(
                  size: 20,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
