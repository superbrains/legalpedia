import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/relatedCaseClass.dart';

class Services{

  static const String url =   'https://resources.legalpediaresources.com/api/services/app/summaries/getall';
  static Future<List<RelatedCaseList>> getSummary(int principleId) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 50, 'SkipCount': 0, 'PrincipleId': principleId}));
      if(response.statusCode==200){
        List<RelatedCaseList> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<RelatedCaseList> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<RelatedCaseList>((json)=> RelatedCaseList.fromJson(json)).toList();

  }
}