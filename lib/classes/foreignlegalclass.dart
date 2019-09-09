class ForeignLegal{
  String url;
  String title;
  String description;
  
  int id;

//

  ForeignLegal({this.url, this.title, this.description,  this.id});

  factory ForeignLegal.fromJson(Map<String, dynamic> json){

    return ForeignLegal(
      url: json["url"] as String,
      title: json["title"] as String,
      description: json["description"] as String,

     
      id: json["id"] as int,



    );
  }


}