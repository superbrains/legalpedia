class RelatedCaseList{
  String suitNo;
  String title;
  String summaryOfFacts;
  String held;
  String issues;
  String casesCited;
  String statusCited;
  String legalpediaCitation;
  String judgementDate;
  String otherCitations;
  String court;
  String category;
  List<String> corams;
  List<String> areasOfLaw;
  String counsels;
  String holdenAt;
  String partyAType;
  String partyBType;
  String partiesA;
  String partiesB;
  List<Ratio> ratios;
  String judgementBody;


  RelatedCaseList({this.suitNo, this.title, this.summaryOfFacts, this.held, this.issues, this.casesCited, this.statusCited, this.legalpediaCitation, this.judgementDate,
    this.otherCitations, this.court, this.category, this.corams, this.areasOfLaw, this.counsels, this.holdenAt, this.partyAType, this.partyBType,
    this.partiesA,this.partiesB, this.ratios,this.judgementBody});

  factory RelatedCaseList.fromJson(Map<String, dynamic> json){

    return RelatedCaseList(
        suitNo: json["suitNo"] as String,
        title: json["title"] as String,
        summaryOfFacts: json["summaryOfFacts"] as String,
        held: json["held"] as String,
        issues: json["issues"] as String,
        casesCited: json["casesCited"] as String,
        statusCited: json["statusCited"] as String,
        legalpediaCitation: json["legalpediaCitation"] as String,
        judgementDate: json["judgementDate"] as String,
        otherCitations: json["otherCitations"] as String,
        court: json["court"] as String,
        category: json["category"] as String,
        corams: parseCorams(json['corams']),
        areasOfLaw: parseareasofLaw(json['areasOfLaw']),
        counsels: json["counsels"] as String,
        holdenAt: json["holdenAt"] as String,
        partyAType: json["partyAType"] as String,
        partyBType: json["partyBType"] as String,
        partiesA: json["partiesA"] as String,
        partiesB: json["partiesB"] as String,
        ratios:  parseRatio(json),
        judgementBody:  json["judgementBody"] as String
    );
  }


  static List<Ratio> parseRatio(ratios){
    var list = ratios['ratios'] as List;
    List<Ratio> ratioList = list.map((data)=> Ratio.fromJson(data)).toList();

    return ratioList;
  }

  static List<String> parseCorams(corams){
    List<String> coramlist = new List<String>.from(corams);
    return coramlist;
  }

  static List<String> parseareasofLaw(areas){
    List<String> areasList = new List<String>.from(areas);
    return areasList;
  }

}

class Ratio{
  String heading;
  String coram;
  String body;
  String suitNo;
  String summary;
  String id;

  Ratio({this.heading, this.coram, this.body,this.suitNo, this.summary,this.id});

  factory Ratio.fromJson(Map<String, dynamic> json){

    return Ratio(
        heading: json["heading"] as String,
        coram: json["coram"] as String,
        body: json["body"] as String,
        suitNo: json["suitNo"] as String,
        summary: json["summary"] as String,
        id: json["id"] as String
    );
  }
}

