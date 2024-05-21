class TodayMeditationModel {
  List<MindVideos>? mindVideos;
  Qoutes? qoutes;

  TodayMeditationModel({this.mindVideos, this.qoutes});

  TodayMeditationModel.fromJson(Map<String, dynamic> json) {
    if (json['mindVideos'] != null) {
      mindVideos = <MindVideos>[];
      json['mindVideos'].forEach((v) {
        mindVideos!.add(MindVideos.fromJson(v));
      });
    } else {
      mindVideos = <MindVideos>[];
    }
    qoutes = json['qoutes'] != null ? Qoutes.fromJson(json['qoutes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mindVideos != null) {
      data['mindVideos'] = mindVideos!.map((v) => v.toJson()).toList();
    }
    if (qoutes != null) {
      data['qoutes'] = qoutes!.toJson();
    }
    return data;
  }
}

class MindVideos {
  int? vidId;
  String? title;
  Null description;
  String? videoFile;
  int? duration;
  int? day;
  String? planTitle;
  int? mindPlanId;
  double? totalCalories;
  String? planDuration;
  String? planImage;
  String? imageFile;
  String? planType;

  MindVideos(
      {this.vidId,
      this.title,
      this.description,
      this.videoFile,
      this.duration,
      this.day,
      this.planTitle,
      this.mindPlanId,
      this.totalCalories,
      this.planDuration,
      this.planImage,
      this.imageFile,
      this.planType});

  MindVideos.fromJson(Map<String, dynamic> json) {
    vidId = json['vidId'];
    title = json['title'];
    description = json['description'];
    videoFile = json['videoFile'];
    duration = json['duration'];
    day = json['day'];
    planTitle = json['planTitle'];
    mindPlanId = json['mindPlanId'];
    totalCalories = json['totalCalories'];
    planDuration = json['planDuration'];
    planImage = json['planImage'];
    imageFile = json['imageFile'];
    planType = json['planType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vidId'] = vidId;
    data['title'] = title;
    data['description'] = description;
    data['videoFile'] = videoFile;
    data['duration'] = duration;
    data['day'] = day;
    data['planTitle'] = planTitle;
    data['mindPlanId'] = mindPlanId;
    data['totalCalories'] = totalCalories;
    data['planDuration'] = planDuration;
    data['planImage'] = planImage;
    data['imageFile'] = imageFile;
    data['planType'] = planType;
    return data;
  }
}

class Qoutes {
  int? id;
  String? qoute;
  String? type;
  bool? active;
  int? day;

  Qoutes({this.id, this.qoute, this.type, this.active, this.day});

  Qoutes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qoute = json['qoute'];
    type = json['type'] ?? "";
    active = json['active'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qoute'] = qoute;
    data['type'] = type;
    data['active'] = active;
    data['day'] = day;
    return data;
  }
}
