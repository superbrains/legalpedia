import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Services{

  static Future<String> getOTP(String phone, String mac) async{
    String url =  'http://35.231.129.160/api/services/app/license/getotp?phoneNumber=$phone&systemId=$mac';

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
        String list = parseSuccess(response.body);
        return list;
      }else {
        return "Error";
      }
    }
    catch(e){
      return "Error";
    }
  }

  static String parseSuccess(String responseBody){

    final parsed = json.decode(responseBody)["result"];
    return parsed.toString();//.map<PhoneActivation>((json)=> PhoneActivation.fromJson(json)).toList();
  }


}