import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/summaryclass.dart';
import 'package:legalpedia/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class SummaryUpdateService{

  static const String url =   'https://resources.legalpediaresources.com/api/services/app/updates/summariesformobile';
  static Future<List<SummaryList>> getSummary() async{
    String curdate;

    // DateTime.now().toString();
     SharedPreferences.getInstance().then((ss){
           curdate =ss.getString('LastUpdate') ?? 'null';
    });

    if(curdate=='null' || curdate==null){
       curdate ="2018-01-01 08:37:28.059100";
    }

    try{
      int count;
      int skip = 0;
      List<SummaryList> list ;

      do { 
      
        final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'Version': curdate ,'MaxCount': 50, 'SkipCount': skip}));
        if(response.statusCode==200){
          
        if(list==null){
           list = parse(response.body);
           globals.lastUpdate = getdate(response.body);
           count = list.length;
        }else{
          list.addAll(parse(response.body));
          globals.lastUpdate = getdate(response.body);
          count = list.length;
        }

          }else{
             count = 0;
          }

        skip = skip + 50; 
     

      }
     
      while(count>=500);
              
       return list;

    }

    catch(e){
      // print(e.toString());
     // throw Exception(e.toString());
    }
  }

 static String getdate(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["maxId"].toString();
    return parsed;

  }

  static List<SummaryList> parse(String responseBody){
    Map data;
    data = json.decode(responseBody);

    final parsed = data["result"]["items"].cast<Map<String,dynamic>>();
    return parsed.map<SummaryList>((json)=> SummaryList.fromJson(json)).toList();

  }
}