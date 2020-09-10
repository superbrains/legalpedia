import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Services{

  static Future<String> getOTP(String phone, String mac) async{
    String url =  'https://resources.legalpediaresources.com/api/services/app/license/getotp?phoneNumber=$phone&systemId=$mac';

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'});
      if(response.statusCode==200){
        String list = parseSuccess(response.body);
        return list;
      }else {
         String list = parseError(response.body);
        return 'Error: $list';
      }
    }
    catch(e){
      return e.toString();
    }
  }
//Activate Phone
  static Future<String> activatePhone(String otp, String mac) async{
    String url =  'https://resources.legalpediaresources.com/api/services/app/license/activate?code=$otp&systemId=$mac';

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

  static Future<String> getinfo(String result) async{
    String url =  'https://resources.legalpediaresources.com/api/services/app/license/getinfo';

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'key': result}));
      if(response.statusCode==200){
        String list = parseGetdays(response.body);
        return list;
      }else {
        String list = parseError(response.body);
        return 'Error: $list';
      }
    }
    catch(e){
      return 'Error: $e.toString()';
    }
  }

   static String parseGetdays(String responseBody){

    final parsed = json.decode(responseBody)["result"]["licensedDays"];
    return parsed.toString();//.map<PhoneActivation>((json)=> PhoneActivation.fromJson(json)).toList();
  }
  static String parseSuccess(String responseBody){

    final parsed = json.decode(responseBody)["result"];
    return parsed.toString();//.map<PhoneActivation>((json)=> PhoneActivation.fromJson(json)).toList();
  }
 static String parseError(String responseBody){

    final parsed = json.decode(responseBody)["error"]["message"];
    return parsed.toString();//.map<PhoneActivation>((json)=> PhoneActivation.fromJson(json)).toList();
  }


}