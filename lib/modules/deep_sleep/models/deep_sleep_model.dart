class DeepSleepModel {
  String? sleep;
  String? awake;
  String? mood;
  List<SleepVedios>? sleepVedios;
  List<BedTime>? bedTime;
  String? totalSleep;

  DeepSleepModel({this.sleep, this.awake, this.mood, this.sleepVedios});

  DeepSleepModel.fromJson(Map<String, dynamic> json) {
    sleep = json['sleep'];
    awake = json['awake'];
    totalSleep = json['totalSleep'];
    mood = json['mood'];
    if (json['sleepVedios'] != null) {
      sleepVedios = <SleepVedios>[];
      json['sleepVedios'].forEach((v) {
        sleepVedios!.add(SleepVedios.fromJson(v));
      });
    }
    if (json['bedTime'] != null) {
      bedTime = <BedTime>[];
      json['bedTime'].forEach((v) {
        bedTime!.add(BedTime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sleep'] = sleep;
    data['awake'] = awake;
    data['mood'] = mood;
    if (sleepVedios != null) {
      data['sleepVedios'] = sleepVedios!.map((v) => v.toJson()).toList();
    }
    if (bedTime != null) {
      data['bedTime'] = bedTime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SleepVedios {
  int? id;
  String? title;
  String? description;
  int? duration;
  String? videoFile;
  String? imageFile;
  bool? isFeatured;

  SleepVedios({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.videoFile,
    this.imageFile,
    this.isFeatured,
  });

  SleepVedios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    videoFile = json['videoFile'];
    imageFile = json['imageFile'];
    isFeatured = json['isFeatured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['videoFile'] = videoFile;
    data['imageFile'] = imageFile;
    data['isFeatured'] = isFeatured;

    return data;
  }
}

class BedTime {
  String? day;
  int? hours;

  BedTime({this.day, this.hours});

  BedTime.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['hours'] = hours;
    return data;
  }
}
