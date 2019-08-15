class SubjectMatters{
  String submatter;
  int id;

  SubjectMatters({this.submatter, this.id});

  factory SubjectMatters.fromJson(Map<String, dynamic> json){

    return SubjectMatters(
      submatter: json["subjectMatterIndex"] as String,
      id: json["id"] as int
    );
  }


}