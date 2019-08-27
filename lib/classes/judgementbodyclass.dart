// To parse this JSON data, do
//
//     final judgementFullBody = judgementFullBodyFromJson(jsonString);

import 'dart:convert';

class JudgementFullBody {
    Result result;
    dynamic targetUrl;
    bool success;
    dynamic error;
    bool unAuthorizedRequest;
    bool abp;

    JudgementFullBody({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    factory JudgementFullBody.fromJson(String str) => JudgementFullBody.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory JudgementFullBody.fromMap(Map<String, dynamic> json) => new JudgementFullBody(
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
    String suitNo;
    String title;
    String summaryOfFacts;
    String held;
    String issues;
    String casesCited;
    String statusCited;
    String legalpediaCitation;
    DateTime judgementDate;
    dynamic otherCitations;
    String court;
    dynamic category;
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

    Result({
        this.suitNo,
        this.title,
        this.summaryOfFacts,
        this.held,
        this.issues,
        this.casesCited,
        this.statusCited,
        this.legalpediaCitation,
        this.judgementDate,
        this.otherCitations,
        this.court,
        this.category,
        this.corams,
        this.areasOfLaw,
        this.counsels,
        this.holdenAt,
        this.partyAType,
        this.partyBType,
        this.partiesA,
        this.partiesB,
        this.ratios,
        this.judgementBody,
    });

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => new Result(
        suitNo: json["suitNo"],
        title: json["title"],
        summaryOfFacts: json["summaryOfFacts"],
        held: json["held"],
        issues: json["issues"],
        casesCited: json["casesCited"],
        statusCited: json["statusCited"],
        legalpediaCitation: json["legalpediaCitation"],
        judgementDate: DateTime.parse(json["judgementDate"]),
        otherCitations: json["otherCitations"],
        court: json["court"],
        category: json["category"],
        corams: new List<String>.from(json["corams"].map((x) => x)),
        areasOfLaw: new List<String>.from(json["areasOfLaw"].map((x) => x)),
        counsels: json["counsels"],
        holdenAt: json["holdenAt"],
        partyAType: json["partyAType"],
        partyBType: json["partyBType"],
        partiesA: json["partiesA"],
        partiesB: json["partiesB"],
        ratios: new List<Ratio>.from(json["ratios"].map((x) => Ratio.fromMap(x))),
        judgementBody: json["judgementBody"],
    );

    Map<String, dynamic> toMap() => {
        "suitNo": suitNo,
        "title": title,
        "summaryOfFacts": summaryOfFacts,
        "held": held,
        "issues": issues,
        "casesCited": casesCited,
        "statusCited": statusCited,
        "legalpediaCitation": legalpediaCitation,
        "judgementDate": judgementDate.toIso8601String(),
        "otherCitations": otherCitations,
        "court": court,
        "category": category,
        "corams": new List<dynamic>.from(corams.map((x) => x)),
        "areasOfLaw": new List<dynamic>.from(areasOfLaw.map((x) => x)),
        "counsels": counsels,
        "holdenAt": holdenAt,
        "partyAType": partyAType,
        "partyBType": partyBType,
        "partiesA": partiesA,
        "partiesB": partiesB,
        "ratios": new List<dynamic>.from(ratios.map((x) => x.toMap())),
        "judgementBody": judgementBody,
    };
}

class Ratio {
    String heading;
    String coram;
    String body;
    String suitNo;
    dynamic summary;
    dynamic id;

    Ratio({
        this.heading,
        this.coram,
        this.body,
        this.suitNo,
        this.summary,
        this.id,
    });

    factory Ratio.fromJson(String str) => Ratio.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ratio.fromMap(Map<String, dynamic> json) => new Ratio(
        heading: json["heading"],
        coram: json["coram"],
        body: json["body"],
        suitNo: json["suitNo"],
        summary: json["summary"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "heading": heading,
        "coram": coram,
        "body": body,
        "suitNo": suitNo,
        "summary": summary,
        "id": id,
    };
}
