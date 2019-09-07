class AreaModel {
  int _id;
  String _suitNo;
  String _area;
  

  AreaModel(
      this._suitNo,
      this._area,
     );

  AreaModel.withId(
      this._id,
      this._suitNo,
      this._area);

  int get id => _id;
  String get suitNo => _suitNo;
  String get area => _area;
 

  set suitNo(String newsuitNo) {
    this._suitNo = newsuitNo;
  }

  set area(String newarea) {
    this._area = newarea;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map["id"] = _id;
    }
    map["suitNo"] = _suitNo;
    map["area"] = _area;
   
    return map;
  }

  AreaModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._suitNo = map["suitNo"];
    this._area = map["area"];
   
  }
}
