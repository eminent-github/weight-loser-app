class WaterModel {
  int? id;
  int? serving;
  int? calories;
  String? date;
  String? createdAt;

  WaterModel({this.id, this.serving, this.calories, this.date, this.createdAt});

  WaterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serving = json['serving'];
    calories = json['calories'];
    date = json['date'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serving'] = serving;
    data['calories'] = calories;
    data['date'] = date;
    data['createdAt'] = createdAt;
    return data;
  }
}
