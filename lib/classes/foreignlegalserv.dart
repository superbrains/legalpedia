import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/foreignlegalclass.dart';

class Services{

  static const String url =   'http://35.231.129.160/api/services/app/foreignLegalResources/getall';
  static Future<List<ForeignLegal>> getForeign() async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 23, 'SkipCount': 0, 'Title': ''}));
      if(response.statusCode==200){
        List<ForeignLegal> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<ForeignLegal> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<ForeignLegal>((json)=> ForeignLegal.fromJson(json)).toList();
  }
}