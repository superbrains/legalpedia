import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/legalarticleclass.dart';

class Services{

  static const String url =   'http://35.231.129.160/api/services/app/articles/Filter';
  static Future<List<LegalArticlesClass>> getArticles() async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'MaxResultCount': 53, 'SkipCount': 0}));
      if(response.statusCode==200){
        List<LegalArticlesClass> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<LegalArticlesClass> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<LegalArticlesClass>((json)=> LegalArticlesClass.fromJson(json)).toList();
  }
}