class LegalArticlesClass{
  String uuid;
  String title;
  String content;
  String versionNo;
  
  int id;

//

  LegalArticlesClass({this.uuid, this.title, this.content, this.versionNo,  this.id});

  factory LegalArticlesClass.fromJson(Map<String, dynamic> json){

    return LegalArticlesClass(
      uuid: json["uuid"] as String,
      title: json["title"] as String,
      content: json["content"] as String,
       versionNo: json["versionNo"] as String,
      
     
      id: json["id"] as int,



    );
  }


}