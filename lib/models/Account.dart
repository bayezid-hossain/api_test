import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Message.dart';
class Account{
  late String address;
  late String pass;
  late String token;
  late String id;
  static final Account _networking=Account._internal();
  factory Account(){
    return _networking;
  }
  Account._internal();
  Future<dynamic> createAccount(String address,String password) async {
    //Uri.https("192.168.1.30:5000", "/api/data")
    //Uri.parse("your url");
    Map data={'address':address,'password':pass};
    var body =json.encode(data);
    final Uri uri = Uri.parse("https://api.mail.tm/accounts");
    final response = await http.post(
      uri,
      body: body,
      headers: {
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
    );
    return response;
  }

  Future<dynamic> login(String address,String pass) async {
    //Uri.https("192.168.1.30:5000", "/api/data")
    //Uri.parse("your url");
    Map data={'address':address.toLowerCase(),'password':pass};
    var body =json.encode(data);
    final Uri uri = Uri.parse("https://api.mail.tm/token");
    final response = await http.post(
      uri,
      body: body,
      headers: {
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
    );
    return response;
  }
  Future<List<Message>> getMessages()async{

    List<Message> messageList=[];
    final Uri uri = Uri.parse("https://api.mail.tm/messages?page=1");
    var response = await http.get(
      uri,
      headers: {
        "accept": "application/ld+json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    print(response.body);
    var messagesObject=jsonDecode(response.body)['hydra:member'];
    for(var message in messagesObject){
      response = await http.get(
        Uri.parse("https://api.mail.tm/messages/${message['id']}"),
        headers: {
          "accept": "application/ld+json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var text=jsonDecode(response.body)['text'];
      print(text);
      print(message['id']);
      print(message['intro']);
      print(message['from']['address']);
      print(message['from']['name']);
      print(message['to'][0]['address']);
      print(message['to'][0]['name']);
      print(message['subject']);
      messageList.add(Message(id: message['id'],fromAddress: message['from']['address'],fromName: message['from']['name'],intro: message['intro'],subject: message['subject'],text: text,toAddress: message['to'][0]['address'],toName: message['to'][0]['name'],date:message['createdAt']));
    }
    return messageList;
  }
}