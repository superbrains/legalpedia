class RatioModel {
  int _id;
  String _suitNo;
  String _heading;
  String _coram;
  String _body;
  String _summary;

  RatioModel(
    this._id,
    this._suitNo,
    this._heading,
    this._coram,
    this._body,
    this._summary,
  );

  int get id => _id;
  String get suitNo => _suitNo;
  String get heading => _heading;
  String get coram => _coram;
  String get body => _body;
  String get summary => _summary;

  set id(int newId) {
    this._id = newId;
  }

  set suitNo(String newsuitNo) {
    this._suitNo = newsuitNo;
  }

  set heading(String newheading) {
    this._heading = newheading;
  }

  set coram(String newcoram) {
    this._coram = newcoram;
  }

  set body(String newbody) {
    this._body = newbody;
  }

  set summary(String newsummary) {
    this._summary = newsummary;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = _id;

    map["suitNo"] = _suitNo;
    map["heading"] = _heading;
    map["coram"] = _coram;
    map["body"] = _body;
    map["summary"] = _summary;

    return map;
  }

  RatioModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._suitNo = map["suitNo"];
    this._heading = map["heading"];
    this.coram = map["coram"];
    this._body = map["body"];

    this._summary = map["summary"];
  }
}
