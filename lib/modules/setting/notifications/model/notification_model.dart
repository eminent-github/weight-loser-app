// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weight_loss_app/local_db/notification_db.dart';

class ReminderNotifyModel {
  String name;
  int isOn;
  String time;
  String remImgUrl;
  ReminderNotifyModel({
    required this.name,
    required this.isOn,
    required this.time,
    required this.remImgUrl,
  });

  ReminderNotifyModel copyWith({
    String? name,
    int? isOn,
    String? time,
    String? remImgUrl,
  }) {
    return ReminderNotifyModel(
      name: name ?? this.name,
      isOn: isOn ?? this.isOn,
      time: time ?? this.time,
      remImgUrl: remImgUrl ?? this.remImgUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      RemNotifyDBProvider.keyRemName: name,
      RemNotifyDBProvider.keyRemisOn: isOn,
      RemNotifyDBProvider.keyRemTime: time,
      RemNotifyDBProvider.keyRemImageUrl: remImgUrl,
    };
  }

  factory ReminderNotifyModel.fromMap(Map<String, dynamic> map) {
    return ReminderNotifyModel(
      name: map[RemNotifyDBProvider.keyRemName],
      isOn: map[RemNotifyDBProvider.keyRemisOn],
      time: map[RemNotifyDBProvider.keyRemTime],
      remImgUrl: map[RemNotifyDBProvider.keyRemImageUrl],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReminderNotifyModel.fromJson(String source) =>
      ReminderNotifyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReminderNotifyModel(name: $name, isOn: $isOn, time: $time, remImgUrl: $remImgUrl)';
  }

  @override
  bool operator ==(covariant ReminderNotifyModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.isOn == isOn &&
        other.time == time &&
        other.remImgUrl == remImgUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^ isOn.hashCode ^ time.hashCode ^ remImgUrl.hashCode;
  }
}
