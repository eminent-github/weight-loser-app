class UltimateSelfieModel {
  List<SelfieList>? selfieList;
  UserDto? userDto;
  UltimateSelfieModel({
    this.selfieList,
    this.userDto,
  });

  UltimateSelfieModel.fromJson(Map<String, dynamic> json) {
    userDto =
        json['userDto'] != null ? UserDto.fromJson(json['userDto']) : null;
    if (json['selfieList'] != null) {
      selfieList = <SelfieList>[];
      json['selfieList'].forEach((v) {
        selfieList!.add(SelfieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDto != null) {
      data['userDto'] = userDto!.toJson();
    }
    if (selfieList != null) {
      data['selfieList'] = selfieList!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class UserDto {
  String? name;
  String? email;
  String? gender;
  double? weight;
  double? targetWeight;
  double? height;
  String? weightUnit;
  String? targetDate;

  UserDto(
      {this.name,
      this.email,
      this.gender,
      this.weight,
      this.targetWeight,
      this.height,
      this.weightUnit,
      this.targetDate});

  UserDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    weight = json['weight'];
    targetWeight = json['targetWeight'];
    height = json['height'];
    weightUnit = json['weightUnit'];
    targetDate = json['targetDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['weight'] = weight;
    data['targetWeight'] = targetWeight;
    data['height'] = height;
    data['weightUnit'] = weightUnit;
    data['targetDate'] = targetDate;
    return data;
  }
}

class SelfieList {
  int? id;
  String? userId;
  int? weight;
  double? waist;
  String? dated;
  String? fileName;

  SelfieList({
    this.id,
    this.userId,
    this.weight,
    this.waist,
    this.dated,
    this.fileName,
  });

  SelfieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    weight = json['weight'];
    waist = json['waist'];
    dated = json['dated'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['weight'] = weight;
    data['waist'] = waist;
    data['dated'] = dated;
    data['fileName'] = fileName;
    return data;
  }
}
