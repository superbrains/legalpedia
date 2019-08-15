class MaximList{
  String uuid;
  String title;
  String content;
  String versionNo;
  int id;


  MaximList({this.uuid, this.title, this.content, this.versionNo, this.id});

  factory MaximList.fromJson(Map<String, dynamic> json){

    return MaximList(
      uuid: json["uuid"] as String,
      title: json["title"] as String,
      content: json["content"] as String,

      versionNo: json["versionNo"] as String,
      id: json["id"] as int,



    );
  }


}