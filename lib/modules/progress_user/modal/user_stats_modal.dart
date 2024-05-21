class UserStatsModal {
  int? goalCalCount;
  double? goalProteinCount;
  double? goalCarbCount;
  double? goalFatCount;
  double? totalAvgCal;
  double? weekAverageWater;
  double? weekAvgExer;
  double? weekAvgMind;
  History? history;
  double? currentWeight;
  String? weightUnit;
  List<UpdateWeight>? updateWeight;
  AverageSleepHours? averageSleepHours;
  double? dietCompliance;
  double? mindCompliance;
  double? exerciseCompliance;
  double? totalCompliance;
  double? goalSodiumCount;
  double? sumOfSodium;
  double? sumOfProtein;
  double? sumOfFat;
  double? sumOfCarbs;
  int? age;
  String? imageUrl;
  String? userName;

  UserStatsModal({
    this.goalCalCount,
    this.goalProteinCount,
    this.goalCarbCount,
    this.goalFatCount,
    this.totalAvgCal,
    this.weekAverageWater,
    this.weekAvgExer,
    this.weekAvgMind,
    this.history,
    this.currentWeight,
    this.updateWeight,
    this.averageSleepHours,
    this.dietCompliance,
    this.exerciseCompliance,
    this.goalSodiumCount,
    this.mindCompliance,
    this.totalCompliance,
    this.weightUnit,
    this.sumOfSodium,
    this.sumOfProtein,
    this.sumOfFat,
    this.sumOfCarbs,
    this.age,
    this.imageUrl,
    this.userName,
  });

  UserStatsModal.fromJson(Map<String, dynamic> json) {
    goalCalCount = json['goalCalCount'];
    goalProteinCount = json['goalProteinCount'];
    goalCarbCount = json['goalCarbCount'];
    goalFatCount = json['goalFatCount'];
    totalAvgCal = json['totalAvgCal'];
    weekAverageWater = json['weekAverageWater'];
    weekAvgExer = json['weekAvgExer'];
    weekAvgMind = json['weekAvgMind'];
    weekAvgMind = json['weekAvgMind'];
    history =
        json['history'] != null ? History.fromJson(json['history']) : null;
    currentWeight = json['currentWeight'];
    averageSleepHours = json['averageSleepHours'] != null
        ? AverageSleepHours.fromJson(json['averageSleepHours'])
        : null;
    dietCompliance = json['dietCompliance'];
    exerciseCompliance = json['exerciseCompliance'];
    goalSodiumCount = json['goalSodiumCount'];
    mindCompliance = json['mindCompliance'];
    totalCompliance = json['totalCompliance'];
    weightUnit = json['weightUnit'];
    sumOfSodium = json['sumOfSodium'];
    sumOfProtein = json['sumOfProtein'];
    sumOfFat = json['sumOfFat'];
    sumOfCarbs = json['sumOfCarbs'];
    if (json['updateWeight'] != null) {
      updateWeight = <UpdateWeight>[];
      json['updateWeight'].forEach((v) {
        updateWeight!.add(UpdateWeight.fromJson(v));
      });
    }

    age = json['age'];
    imageUrl = json['imageUrl'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goalCalCount'] = goalCalCount;
    data['goalProteinCount'] = goalProteinCount;
    data['goalCarbCount'] = goalCarbCount;
    data['goalFatCount'] = goalFatCount;
    data['totalAvgCal'] = totalAvgCal;
    data['weekAverageWater'] = weekAverageWater;
    data['weekAvgExer'] = weekAvgExer;
    data['weekAvgMind'] = weekAvgMind;
    if (history != null) {
      data['history'] = history!.toJson();
    }
    data['currentWeight'] = currentWeight;
    data['weightUnit'] = weightUnit;
    data['updateWeight'] = updateWeight;
    if (averageSleepHours != null) {
      data['averageSleepHours'] = averageSleepHours!.toJson();
    }
    data['age'] = age;
    data['imageUrl'] = imageUrl;
    data['userName'] = userName;
    return data;
  }
}

class History {
  List<Water>? water;
  List<ProgressExercise>? exerciseCalories;
  List<Mind>? mind;
  dynamic foods;

  History({this.water, this.exerciseCalories, this.mind, this.foods});

  History.fromJson(Map<String, dynamic> json) {
    if (json['water'] != null) {
      water = <Water>[];
      json['water'].forEach((v) {
        water!.add(Water.fromJson(v));
      });
    }
    if (json['exerciseCalories'] != null) {
      exerciseCalories = <ProgressExercise>[];
      json['exerciseCalories'].forEach((v) {
        exerciseCalories!.add(ProgressExercise.fromJson(v));
      });
    }

    foods = json['foods'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (water != null) {
      data['water'] = water!.map((v) => v.toJson()).toList();
    }
    if (exerciseCalories != null) {
      data['exerciseCalories'] =
          exerciseCalories!.map((v) => v.toJson()).toList();
    }
    if (mind != null) {
      data['mind'] = mind!.map((v) => v.toJson()).toList();
    }
    data['foods'] = foods;
    return data;
  }
}

class Water {
  int? id;
  int? serving;
  int? calories;
  String? date;

  String? createdAt;

  Water({
    this.id,
    this.serving,
    this.calories,
    this.date,
    this.createdAt,
  });

  Water.fromJson(Map<String, dynamic> json) {
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

class Mind {
  int? id;
  int? planId;
  dynamic exerciseId;
  int? vedioId;
  String? duration;

  Mind({this.id, this.planId, this.exerciseId, this.vedioId, this.duration});

  Mind.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['planId'];
    exerciseId = json['exerciseId'];
    vedioId = json['vedioId'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['planId'] = planId;
    data['exerciseId'] = exerciseId;
    data['vedioId'] = vedioId;
    data['duration'] = duration;
    return data;
  }
}

class ProgressExercise {
  double? calories;
  String? date;

  ProgressExercise({this.calories, this.date});

  ProgressExercise.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['calories'] = calories;
    data['date'] = date;
    return data;
  }
}

class AverageSleepHours {
  int? hours;
  int? minutes;
  int? seconds;

  AverageSleepHours({this.hours, this.minutes, this.seconds});

  AverageSleepHours.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hours'] = hours;
    data['minutes'] = minutes;
    data['seconds'] = seconds;
    return data;
  }
}

class UpdateWeight {
  String? date;
  num? weight;

  UpdateWeight({this.date, this.weight});

  UpdateWeight.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['weight'] = weight;
    return data;
  }
}
