// To parse this JSON data, do
//
//     final ruleDetails = ruleDetailsFromJson(jsonString);

import 'dart:convert';

class RuleDetails {
  Result result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  RuleDetails({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  factory RuleDetails.fromJson(String str) => RuleDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RuleDetails.fromMap(Map<String, dynamic> json) => new RuleDetails(
    result: Result.fromMap(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"],
    abp: json["__abp"],
  );

  Map<String, dynamic> toMap() => {
    "result": result.toMap(),
    "targetUrl": targetUrl,
    "success": success,
    "error": error,
    "unAuthorizedRequest": unAuthorizedRequest,
    "__abp": abp,
  };
}

class Result {
  int totalCount;
  List<Item> items;

  Result({
    this.totalCount,
    this.items,
  });

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => new Result(
    totalCount: json["totalCount"],
    items: new List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "totalCount": totalCount,
    "items": new List<dynamic>.from(items.map((x) => x.toMap())),
  };
}

class Item {
  String uuid;
  String name;
  String title;
  String section;
  String type;
  String content;

  Item({
    this.uuid,
    this.name,
    this.title,
    this.section,
    this.type,
    this.content,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => new Item(
    uuid: json["uuid"],
    name: json["name"],
    title: json["title"],
    section: json["section"],
    type: json["type"],
    content: json["content"],
  );

  Map<String, dynamic> toMap() => {
    "uuid": uuid,
    "name": name,
    "title": title,
    "section": section,
    "type": type,
    "content": content,
  };
}
