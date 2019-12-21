import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/summaryclass.dart';

class SummaryUpdateService{

  static const String url =   'http://35.231.129.160/api/services/app/updates/summariesformobile';
  static Future<List<SummaryList>> getSummary() async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'Version': '2018-01-01 04:30:35' ,'MaxCount': 500, 'SkipCount': 0}));
      if(response.statusCode==200){
        List<SummaryList> list = parse(response.body);
     
        return list;
      }else {
       
        throw Exception("Error");
       
      }
    }
    catch(e){
    
      throw Exception(e.toString());
    }
  }

  static List<SummaryList> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<SummaryList>((json)=> SummaryList.fromJson(json)).toList();

  }
}