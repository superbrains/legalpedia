// To parse this JSON data, do
//
//     final lawDetailList = lawDetailListFromJson(jsonString);

import 'dart:convert';

class LawDetailList {
   Result result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  LawDetailList({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  factory LawDetailList.fromJson(String str) => LawDetailList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LawDetailList.fromMap(Map<String, dynamic> json) => new LawDetailList(
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
  dynamic catId;
  String lawNo;
  String title;
  DateTime lawDate;
  String descr;
  dynamic subsidiaryLegislation;
  dynamic tags;
  dynamic createdAt;
  dynamic updatedAt;
  List<Part> parts;
  List<Schedule> schedules;
  int id;

  Result({
    this.catId,
    this.lawNo,
    this.title,
    this.lawDate,
    this.descr,
    this.subsidiaryLegislation,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.parts,
    this.schedules,
    this.id,
  });

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => new Result(
    catId: json["catId"],
    lawNo: json["lawNo"],
    title: json["title"],
    lawDate: DateTime.parse(json["lawDate"]),
    descr: json["descr"],
    subsidiaryLegislation: json["subsidiaryLegislation"],
    tags: json["tags"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    parts: new List<Part>.from(json["parts"].map((x) => Part.fromMap(x))),
    schedules: new List<Schedule>.from(json["schedules"].map((x) => Schedule.fromMap(x))),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "catId": catId,
    "lawNo": lawNo,
    "title": title,
    "lawDate": lawDate.toIso8601String(),
    "descr": descr,
    "subsidiaryLegislation": subsidiaryLegislation,
    "tags": tags,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "parts": new List<dynamic>.from(parts.map((x) => x.toMap())),
    "schedules": new List<dynamic>.from(schedules.map((x) => x.toMap())),
    "id": id,
  };
}

class Part {
  int lawId;
  String partHeader;
  List<Section> sections;
  int id;

  Part({
    this.lawId,
    this.partHeader,
    this.sections,
    this.id,
  });

  factory Part.fromJson(String str) => Part.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Part.fromMap(Map<String, dynamic> json) => new Part(
    lawId: json["lawId"],
    partHeader: json["partHeader"],
    sections: new List<Section>.from(json["sections"].map((x) => Section.fromMap(x))),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "lawId": lawId,
    "partHeader": partHeader,
    "sections": new List<dynamic>.from(sections.map((x) => x.toMap())),
    "id": id,
  };
}

class Section {
  String sectionHeader;
  String sectionBody;
  int lawId;
  int partId;
  int id;

  Section({
    this.sectionHeader,
    this.sectionBody,
    this.lawId,
    this.partId,
    this.id,
  });

  factory Section.fromJson(String str) => Section.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Section.fromMap(Map<String, dynamic> json) => new Section(
    sectionHeader: json["sectionHeader"],
    sectionBody: json["sectionBody"],
    lawId: json["lawId"],
    partId: json["partId"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "sectionHeader": sectionHeader,
    "sectionBody": sectionBody,
    "lawId": lawId,
    "partId": partId,
    "id": id,
  };
}

class Schedule {
  String schedHeader;
  String schedBody;
  int lawId;
  int id;

  Schedule({
    this.schedHeader,
    this.schedBody,
    this.lawId,
    this.id,
  });

  factory Schedule.fromJson(String str) => Schedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Schedule.fromMap(Map<String, dynamic> json) => new Schedule(
    schedHeader: json["schedHeader"],
    schedBody: json["schedBody"],
    lawId: json["lawId"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "schedHeader": schedHeader,
    "schedBody": schedBody,
    "lawId": lawId,
    "id": id,
  };
}
