import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/maximclass.dart';

class Services{

  static const String url =   'https://resources.legalpediaresources.com/api/services/app/maxims/getall';
  static Future<List<MaximList>> getMaxims() async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 635, 'SkipCount': 0, 'Title': ''}));
      if(response.statusCode==200){
        List<MaximList> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<MaximList> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<MaximList>((json)=> MaximList.fromJson(json)).toList();
  }
}