import 'package:api_test/models/Account.dart';
import 'package:get/get.dart';

import '../models/Message.dart';

class AccountController extends GetxController{

  List<Message> messages=<Message>[].obs;
  List<String> domains=<String>[].obs;
  List<Account> account=<Account>[].obs;
  late String selectedValue;


  void onSelected(String value) {
    selectedValue = value;
  }

  void AddMessage(List<Message> messages){
    this.messages.clear();
    this.messages.addAll(messages);
    update();
  }

}