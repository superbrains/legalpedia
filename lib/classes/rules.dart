class Rules{
  String uuid;
  String name;
  String title;
  String section;
  String type;
  String content;

  Rules({this.uuid, this.name, this.title, this.section, this.type, this.content});

  factory Rules.fromJson(Map<String, dynamic> json){

    return Rules(
        uuid: json["uuid"] as String,
        name: json["name"] as String,
        title: json["title"] as String,
        section: json["section"] as String,
        type: json["type"] as String,
        content: json["content"] as String,

    );
  }


}