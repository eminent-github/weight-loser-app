class WeightStatsModel {
  List<UpdateWeight>? weightList;
  double? startingWeight;
  String? startingWeightDate;
  int? currentWeight;
  String? currentWeightDate;
  double? targetWeight;
  String? targetWeightDate;
  String? weightUnit;
  dynamic responseDto;

  WeightStatsModel(
      {this.weightList,
      this.startingWeight,
      this.startingWeightDate,
      this.currentWeight,
      this.currentWeightDate,
      this.targetWeight,
      this.targetWeightDate,
      this.weightUnit,
      this.responseDto});

  WeightStatsModel.fromJson(Map<String, dynamic> json) {
    if (json['weightList'] != null) {
      weightList = <UpdateWeight>[];
      json['weightList'].forEach((v) {
        weightList!.add(UpdateWeight.fromJson(v));
      });
    }
    startingWeight = json['startingWeight'];
    startingWeightDate = json['startingWeightDate'];
    currentWeight = json['currentWeight'];
    currentWeightDate = json['currentWeightDate'];
    targetWeight = json['targetWeight'];
    targetWeightDate = json['targetWeightDate'];
    responseDto = json['responseDto'];
    weightUnit = json['weightUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weightList != null) {
      data['weightList'] = weightList!.map((v) => v.toJson()).toList();
    }
    data['startingWeight'] = startingWeight;
    data['startingWeightDate'] = startingWeightDate;
    data['currentWeight'] = currentWeight;
    data['currentWeightDate'] = currentWeightDate;
    data['targetWeight'] = targetWeight;
    data['targetWeightDate'] = targetWeightDate;
    data['responseDto'] = responseDto;
    data['weightUnit'] = weightUnit;
    return data;
  }
}

class UpdateWeight {
  String? day;
  int? weight;

  UpdateWeight({this.day, this.weight});

  UpdateWeight.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['weight'] = weight;
    return data;
  }
}
