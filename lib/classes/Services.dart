import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/SubjectMatter.dart';

class Services{

  static const String url =   'http://35.231.129.160/api/services/app/subjectmatters/getall';
  static Future<List<SubjectMatters>> getSubjectMatters() async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 65, 'SkipCount': 0}));
      if(response.statusCode==200){
        List<SubjectMatters> list = parseSubMatters(response.body);
        //list.sort();
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<SubjectMatters> parseSubMatters(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<SubjectMatters>((json)=> SubjectMatters.fromJson(json)).toList();
  }
}