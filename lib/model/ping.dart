import 'dart:convert';

Ping pingFromJson(String str) => Ping.fromJson(json.decode(str));

String pingToJson(Ping data) => json.encode(data.toJson());

class Ping {

  Ping({
    required this.id,
    this.userId,
    this.location,
    this.dateTime,
  });

  dynamic id;
  dynamic userId;
  dynamic location;
  dynamic dateTime;

  factory Ping.fromJson(Map<String, dynamic> json) => Ping(
      id: json["id"].toString(),
      userId: json["userId"].toString(),
      location: json["location"].toString(),
      dateTime: json["dateTime"].toString(),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "location": location,
    "dateTime": dateTime,
  };

}

