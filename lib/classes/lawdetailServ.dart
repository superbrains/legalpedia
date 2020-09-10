import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:legalpedia/classes/lawdetailClassTwo.dart';

class Services{

  static const String url =   'https://resources.legalpediaresources.com/api/services/app/lawsoffederation/detail';
  static Future<List<LawDetailList>> getLawDetail(int id) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'id': id}));
      if(response.statusCode==200){
        List<LawDetailList> list = parse(response.body);
        return list;
      }else {
        throw Exception("Error");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  static List<LawDetailList> parse(String responseBody){

   final lawDetailList = LawDetailList.fromJson(responseBody);

    print(lawDetailList.result.title.toString());

   print(lawDetailList.result.parts[0].partHeader);

  //  var data = json.decode(responseBody);
   // var rest = data as List;

  //  return rest.map<LawDetailList>((json) => LawDetailList.fromJson(json)).toList();

   // print(lawDetailList.result.title);

   // Map data;
   // data = json.decode(responseBody);
   // print(responseBody);

    //final parsed = data["result"].cast<Map<String,dynamic>>();
   // return parsed.map<LawDetailList>((json)=> LawDetailList.fromJson(json)).toList();
  }
}