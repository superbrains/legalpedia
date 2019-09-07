import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/principleClass.dart';

class Services{

  static const String url =   'http://35.231.129.160/api/services/app/subjectmatters/getprinciples';
  static Future<List<PrincipleList>> getPrinciple(int id) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 65, 'SkipCount': 0, 'SubjectMatterId': id}));
      if(response.statusCode==200){
        List<PrincipleList> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<PrincipleList> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data['result']['items'].cast<Map<String,dynamic>>();

    return parsed.map<PrincipleList>((json)=> PrincipleList.fromJson(json)).toList();

  }
}