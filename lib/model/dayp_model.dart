// To parse this JSON data, do
//
//     final DaypModel = DaypModelFromJson(jsonString);

import 'dart:convert';

List<DaypModel> daypFromJson(String str) => List<DaypModel>.from(json.decode(str).map((x) => DaypModel.fromJson(x)));

String daypToJson(List<DaypModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DaypModel {
    DateTime eventDate;
    dynamic timeframe;
    int stoneid;
    int eventId;
    String description;
    int selected;
    int uploaded;
    int bid;
    int confirm;

    DaypModel({
        required this.eventDate,
        required this.timeframe,
        required this.stoneid,
        required this.eventId,
        required this.description,
        required this.selected,
        required this.uploaded,
        required this.bid,
        required this.confirm,
    });

    factory DaypModel.fromJson(Map<String, dynamic> json) => DaypModel(
        eventDate: DateTime.parse(json["event_date"]),
        timeframe: json["timeframe"],
        stoneid: json["stoneid"],
        eventId: json["event_id"],
        description: (json["description"] ?? ' ').toString(),
        selected: (json["selected"] ?? 0),
        uploaded: (json["uploaded"]),
        bid: (json["bid"]),
        confirm: (json["confirm"]),
    );

    Map<String, dynamic> toJson() => {
        "event_date": eventDate.toIso8601String(),
        "timeframe": timeframe,
        "stoneid": stoneid,
        "event_id": eventId,
        "description": description,
        "selected": selected,
        "uploaded": uploaded,
        "bid": bid,
        "confirm": confirm,
    };
}
