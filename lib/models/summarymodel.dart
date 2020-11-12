class SummaryModel {
  int _id;
  String _suitNo;
  String _title;
  String _summaryOfFacts;
  String _held;
  String _issues;
  String _casesCited;
  String _statusCited;
  String _legalpediaCitation;
  String _judgementDate;
  String _otherCitations;
  String _court;
  String _category;
  String _counsels;
  String _holdenAt;
  String _partyAType;
  String _partyBType;
  String _partiesA;
  String _partiesB;

  SummaryModel(
      this._suitNo,
      this._title,
      this._summaryOfFacts,
      this._held,
      this._issues,
      this._casesCited,
      this._statusCited,
      this._legalpediaCitation,
      this._judgementDate,
      this._otherCitations,
      this._court,
      this._category,
      this._counsels,
      this._holdenAt,
      this._partyAType,
      this._partyBType,
      this._partiesA,
      this._partiesB);

  SummaryModel.withId(
      this._id,
      this._suitNo,
      this._title,
      this._summaryOfFacts,
      this._held,
      this._issues,
      this._casesCited,
      this._statusCited,
      this._legalpediaCitation,
      this._judgementDate,
      this._otherCitations,
      this._court,
      this._category,
      this._counsels,
      this._holdenAt,
      this._partyAType,
      this._partyBType,
      this._partiesA,
      this._partiesB);

  int get id => _id;
  String get suitNo => _suitNo;
  String get title => _title;
  String get summaryOfFacts => _summaryOfFacts;
  String get held => _held;
  String get issues => _issues;
  String get casesCited => _casesCited;
  String get statusCited => _statusCited;
  String get legalpediaCitation => _legalpediaCitation;
  String get judgementDate => _judgementDate;
  String get otherCitations => _otherCitations;
  String get court => _court;
  String get category => _category;
  String get counsels => _counsels;
  String get holdenAt => _holdenAt;
  String get partyAType => _partyAType;
  String get partyBType => _partyBType;
  String get partiesA => _partiesA;
  String get partiesB => _partiesB;


 set id(int newId) {
    this._id = newId;
  }

  set suitNo(String newsuitNo) {
    this._suitNo = newsuitNo;
  }

  set title(String newtitle) {
    this._title = newtitle;
  }

  set summaryOfFacts(String newsummaryOfFacts) {
    this._summaryOfFacts = newsummaryOfFacts;
  }

  set held(String newheld) {
    this._held = newheld;
  }

  set issues(String newissues) {
    this._issues = newissues;
  }

  set casesCited(String newcasesCited) {
    this._casesCited = newcasesCited;
  }

  set statusCited(String newstatusCited) {
    this._statusCited = newstatusCited;
  }

  set legalpediaCitation(String newlegalpediaCitation) {
    this._legalpediaCitation = newlegalpediaCitation;
  }

  set judgementDate(String newjudgementDate) {
    this._judgementDate = newjudgementDate;
  }

  set otherCitations(String newotherCitations) {
    this._otherCitations = newotherCitations;
  }

  set court(String newcourt) {
    this._court = newcourt;
  }

  set category(String newcategory) {
    this._category = newcategory;
  }

  set counsels(String newcounsels) {
    this._counsels = newcounsels;
  }

  set holdenAt(String newholdenAt) {
    this._holdenAt = newholdenAt;
  }

  set partyAType(String newpartyAType) {
    this._partyAType = newpartyAType;
  }

  set partyBType(String newpartyBType) {
    this._partyBType = newpartyBType;
  }

  set partiesA(String newpartiesA) {
    this._partiesA = newpartiesA;
  }

  set partiesB(String newpartiesB) {
    this._partiesB = newpartiesB;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map["id"] = _id;
    }
    map["suitNo"] = _suitNo;
    map["title"] = _title;
    map["summaryOfFacts"] = _summaryOfFacts;
    map["held"] = _held;
    map["issues"] = _issues;
    map["casesCited"] = _casesCited;
    map["statusCited"] = _statusCited;
    map["legalpediaCitation"] = _legalpediaCitation;
    map["judgementDate"] = _judgementDate;
    map["otherCitations"] = _otherCitations;
    map["court"] = _court;
    map["category"] = _category;
    map["counsels"] = _counsels;
    map["holdenAt"] = _holdenAt;
    map["partyAType"] = _partyAType;
    map["partyBType"] = _partyBType;
    map["partiesA"] = _partiesA;
    map["partiesB"] = _partiesB;

    return map;
  }

  SummaryModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._suitNo = map["suitNo"];
    this._title = map["title"];
    this._summaryOfFacts = map["summaryOfFacts"];
    this._held = map["held"];

    this._issues = map["issues"];
    this._casesCited = map["casesCited"];
    this._statusCited = map["statusCited"];
    this._legalpediaCitation = map["legalpediaCitation"];
    this._judgementDate = map["judgementDate"];
    this._otherCitations = map["otherCitations"];
    this._court = map["court"];
    this._category = map["category"];
    this._counsels = map["counsels"];
    this._holdenAt = map["holdenAt"];
    this._partyAType = map["partyAType"];
    this._partyBType = map["partyBType"];
    this._partiesA = map["partiesA"];
    this._partiesB = map["partiesB"];
  }
}
