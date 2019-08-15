class LawList{
  String catId;
  String lawNo;
  String title;
  String lawDate;
  String descr;
  String subsidiaryLegislation;
  String tags;
  int id;


  LawList({this.catId, this.lawNo, this.title, this.lawDate, this.descr, this.subsidiaryLegislation, this.id});

  factory LawList.fromJson(Map<String, dynamic> json){

    return LawList(
      catId: json["catId"] as String,
      lawNo: json["lawNo"] as String,
      title: json["title"] as String,
      lawDate: json["lawDate"] as String,
      descr: json["descr"] as String,
      subsidiaryLegislation: json["subsidiaryLegislation"] as String,
      id: json["id"] as int,



    );
  }


}