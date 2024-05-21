class ExerciseItemDetailModel {
  String? name;
  double? calories;
  String? fileName;
  int? videoDuration;
  int? userExerciseDuration;
  int? day;
  int? exerciseId;
  String? title;
  int? exercisePlanId;
  int? planId;
  String? videoFile;
  bool? isRep;

  ExerciseItemDetailModel({
    this.name,
    this.calories,
    this.fileName,
    this.videoDuration,
    this.day,
    this.exerciseId,
    this.title,
    this.exercisePlanId,
    this.userExerciseDuration,
    this.planId,
    this.videoFile,
    this.isRep,
  });

  ExerciseItemDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    calories = json['calories'];
    fileName = json['fileName'];
    videoDuration = json['videoDuration'];
    userExerciseDuration = json['userExerciseDuration'];
    day = json['day'];
    exerciseId = json['exerciseId'];
    title = json['title'];
    exercisePlanId = json['exercisePlanId'];
    planId = json['planId'];
    videoFile = json['videoFile'];
    isRep = json['isRep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['calories'] = calories;
    data['fileName'] = fileName;
    data['videoDuration'] = videoDuration;
    data['userExerciseDuration'] = userExerciseDuration;
    data['day'] = day;
    data['exerciseId'] = exerciseId;
    data['title'] = title;
    data['exercisePlanId'] = exercisePlanId;
    data['planId'] = planId;
    data['videoFile'] = videoFile;
    data['isRep'] = isRep;
    return data;
  }
}
