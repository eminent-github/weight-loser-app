class MindActivePlansModel {
  List<ActivePlan>? activePlan;
  List<ActivePlan>? prevActivePlan;
  String? imagePath;
  String? videoPath;

  MindActivePlansModel(
      {this.activePlan, this.prevActivePlan, this.imagePath, this.videoPath});

  MindActivePlansModel.fromJson(Map<String, dynamic> json) {
    if (json['activePlan'] != null) {
      activePlan = <ActivePlan>[];
      json['activePlan'].forEach((v) {
        activePlan!.add(ActivePlan.fromJson(v));
      });
    }
    if (json['prevActivePlan'] != null) {
      prevActivePlan = <ActivePlan>[];
      json['prevActivePlan'].forEach((v) {
        prevActivePlan!.add(ActivePlan.fromJson(v));
      });
    }

    imagePath = json['imagePath'];
    videoPath = json['videoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activePlan != null) {
      data['activePlan'] = activePlan!.map((v) => v.toJson()).toList();
    }
    if (prevActivePlan != null) {
      data['prevActivePlan'] = prevActivePlan!.map((v) => v.toJson()).toList();
    }

    data['imagePath'] = imagePath;
    data['videoPath'] = videoPath;
    return data;
  }
}

class ActivePlan {
  int? planId;
  String? title;
  String? fileName;
  int? duration;
  String? description;
  String? planType;
  int? phase;
  int? day;

  ActivePlan({
    this.planId,
    this.title,
    this.fileName,
    this.duration,
    this.description,
    this.planType,
    this.phase,
    this.day,
  });

  ActivePlan.fromJson(Map<String, dynamic> json) {
    planId = json['planId'];
    title = json['title'];
    fileName = json['fileName'];
    duration = json['duration'];
    description = json['description'];
    planType = json['planType'];
    phase = json['phase'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['planId'] = planId;
    data['title'] = title;
    data['fileName'] = fileName;
    data['duration'] = duration;
    data['description'] = description;
    data['planType'] = planType;
    data['phase'] = phase;
    data['day'] = day;
    return data;
  }
}
