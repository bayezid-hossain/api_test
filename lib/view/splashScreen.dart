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
    print(accountController.domains);
    Get.off(HomePage());
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Mail.tm",style: TextStyle(fontSize: 25,fontFamily: "Kalpurush",color: Colors.black)),centerTitle: true,backgroundColor: Colors.white,),
        backgroundColor: Colors.transparent,
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
