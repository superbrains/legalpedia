import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/rules.dart';

class Services{

  static const String url =   'http://35.231.129.160/api/services/app/rulesofcort/State';
  static Future<List<Rules>> getRules() async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 65, 'SkipCount': 0, 'StateName': 'NIGER', 'Section': 'APPENDIX' }));
      if(response.statusCode==200){
        List<Rules> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<Rules> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<Rules>((json)=> Rules.fromJson(json)).toList();
  }
}