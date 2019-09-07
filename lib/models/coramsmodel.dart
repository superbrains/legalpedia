class CoramModel {
  int _id;
  String _suitNo;
  String _coram;
  

  CoramModel(
      this._suitNo,
      this._coram,
     );

  CoramModel.withId(
      this._id,
      this._suitNo,
      this._coram);

  int get id => _id;
  String get suitNo => _suitNo;
  String get coram => _coram;
 

  set suitNo(String newsuitNo) {
    this._suitNo = newsuitNo;
  }

  set coram(String newcoram) {
    this._coram = newcoram;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map["id"] = _id;
    }
    map["suitNo"] = _suitNo;
    map["coram"] = _coram;
   
    return map;
  }

  CoramModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._suitNo = map["suitNo"];
    this._coram = map["coram"];
   
  }
}
