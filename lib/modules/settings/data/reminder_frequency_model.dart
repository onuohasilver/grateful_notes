import 'dart:convert';

ReminderFrequencyModel reminderFrequencyModelFromJson(String str) =>
    ReminderFrequencyModel.fromJson(json.decode(str));

String reminderFrequencyModelToJson(ReminderFrequencyModel data) =>
    json.encode(data.toJson());

class ReminderFrequencyModel {
  ReminderFrequencyModel({
    required this.hour,
    required this.minute,
    required this.frequency,
  });

  final int hour;
  final int minute;
  final String frequency;

  ReminderFrequencyModel copyWith({
    int? hour,
    int? minute,
    String? frequency,
  }) =>
      ReminderFrequencyModel(
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        frequency: frequency ?? this.frequency,
      );

  factory ReminderFrequencyModel.fromJson(Map<String, dynamic> json) =>
      ReminderFrequencyModel(
        hour: json["hour"],
        minute: json["minute"],
        frequency: json["frequency"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "minute": minute,
        "frequency": frequency,
      };
  @override
  String toString() => toJson().toString();
}
