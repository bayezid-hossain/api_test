import 'package:http/http.dart' as http;
import 'dart:convert';
class Networking{
  final String api="https://api.mail.tm";
  static final Networking _networking=Networking._internal();
  factory Networking(){
    return _networking;
  }
  Networking._internal();

  Future<List<String>> getDomains() async{
    List<String> domains=[];
    http.Response response = await http.get( Uri.parse(api+"/domains"));

    if (response.statusCode == 200) {
      String data = response.body;
      var decoded=jsonDecode(data);
      for(var domain in decoded['hydra:member']){
        domains.add(domain['domain']);
      }
      return domains;

    } else
      print(response.statusCode);

    return domains;
  }
  }

