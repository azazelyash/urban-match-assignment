class EventsModel {
  String? name;
  DateTime? time;

  EventsModel({this.name, this.time});

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
    name: json["name"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]).toLocal(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "time": time?.toIso8601String(),
  };
}
