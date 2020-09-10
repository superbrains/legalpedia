import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/lawclass.dart';

class Services{

  static const String url =   'https://resources.legalpediaresources.com/api/services/app/lawsoffederation/getall';
  static Future<List<LawList>> getLaws() async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 621, 'SkipCount': 0, 'Title': ''}));
      if(response.statusCode==200){
        List<LawList> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<LawList> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<LawList>((json)=> LawList.fromJson(json)).toList();
  }
}