class PrincipleList{
  String name;
  int sbjMatterIdxId;
  int id;

  PrincipleList({this.name, this.sbjMatterIdxId, this.id});

  factory PrincipleList.fromJson(Map<String, dynamic> json){

    return PrincipleList(
        name: json["name"] as String,
        sbjMatterIdxId: json["sbjMatterIdxId"] as int,
        id: json["id"] as int
    );
  }


}