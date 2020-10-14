import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/summaryclass.dart';

class SummaryUpdateService{

  static const String url =   'https://resources.legalpediaresources.com/api/services/app/updates/summariesformobile';
  static Future<List<SummaryList>> getSummary() async{
    String curdate;
    curdate = DateTime.now().toString();
    
    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'Version': curdate ,'MaxCount': 500, 'SkipCount': 0}));
      if(response.statusCode==200){
        List<SummaryList> list = parse(response.body);
       // print('Response Returned');
       // print(response.body);
        return list;
      }else {
        // print('error1');
        throw Exception("Error");
       
      }
    }
    catch(e){
      // print(e.toString());
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