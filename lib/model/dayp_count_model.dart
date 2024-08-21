// To parse this JSON data, do
//
//     final daypCountModel = daypCountModelFromJson(jsonString);

import 'dart:convert';

DaypCountModel daypCountModelFromJson(String str) => DaypCountModel.fromJson(json.decode(str));

String daypCountModelToJson(DaypCountModel data) => json.encode(data.toJson());

class DaypCountModel {
    Map<String, List<Datum>> data;

    DaypCountModel({
        required this.data,
    });

    factory DaypCountModel.fromJson(Map<String, dynamic> json) => DaypCountModel(
        data: Map.from(json["data"]).map((k, v) => MapEntry<String, List<Datum>>(k, List<Datum>.from(v.map((x) => Datum.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    };
}

class Datum {
    int eventId;
    int selected;
    int uploaded;
    int confirmed;
    int bided;

    Datum({
        required this.eventId,
        required this.selected,
        required this.uploaded,
        required this.confirmed,
        required this.bided,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eventId: json["event_id"],
        selected: json["selected"],
        uploaded: json["uploaded"],
        confirmed: json["confirmed"],
        bided: json["bided"],
    );

    Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "selected": selected,
        "uploaded": uploaded,
        "confirmed": confirmed,
        "bided": bided,
    };
}
