class PhoneActivation{
  String result;
  String targetUrl;
  String success;
  String error;
  String unAuthorizedRequest;
  String  abp;


  PhoneActivation({this.result, this.targetUrl, this.success, this.error, this.unAuthorizedRequest, this.abp});

  factory PhoneActivation.fromJson(Map<String, dynamic> json){

    return PhoneActivation(
      result: json["result"] as String,
      targetUrl: json["targetUrl"] as String,
      success: json["success"] as String,
      error: json["error"] as String,
      unAuthorizedRequest: json["unAuthorizedRequest"] as String,
      abp: json["__abp"] as String,
         );
  }


}