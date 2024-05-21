class MindItemDetailModel {
  int? vidId;
  String? title;
  String? description;
  String? videoFile;
  int? duration;
  int? day;
  String? planTitle;
  String? imageFile;
  int? planId;
  int? mindPlanId;
  int? watchedVideoDuration;

  MindItemDetailModel(
      {this.vidId,
      this.title,
      this.description,
      this.videoFile,
      this.duration,
      this.day,
      this.planTitle,
      this.imageFile,
      this.planId,
      this.mindPlanId,
      this.watchedVideoDuration});

  MindItemDetailModel.fromJson(Map<String, dynamic> json) {
    vidId = json['vidId'];
    title = json['title'];
    description = json['description'];
    videoFile = json['videoFile'];
    duration = json['duration'];
    day = json['day'];
    planTitle = json['planTitle'];
    imageFile = json['imageFile'];
    planId = json['planId'];
    mindPlanId = json['mindPlanId'];
    watchedVideoDuration = json['watchedVideoDuration'];
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
    data['imageFile'] = imageFile;
    data['planId'] = planId;
    data['mindPlanId'] = mindPlanId;
    data['watchedVideoDuration'] = watchedVideoDuration;
    return data;
  }
}