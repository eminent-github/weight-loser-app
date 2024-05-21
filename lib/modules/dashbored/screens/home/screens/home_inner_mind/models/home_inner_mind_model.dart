class HomeInnerMindModel {
  List<FavouritePlanList>? favouritePlanList;
  ResponseDto? responseDto;
  bool? valid;
  String? imagePath;

  HomeInnerMindModel(
      {this.favouritePlanList, this.responseDto, this.valid, this.imagePath});

  HomeInnerMindModel.fromJson(Map<String, dynamic> json) {
    if (json['favouritePlanList'] != null) {
      favouritePlanList = <FavouritePlanList>[];
      json['favouritePlanList'].forEach((v) {
        favouritePlanList!.add(FavouritePlanList.fromJson(v));
      });
    }
    responseDto = json['responseDto'] != null
        ? ResponseDto.fromJson(json['responseDto'])
        : null;
    valid = json['valid'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favouritePlanList != null) {
      data['favouritePlanList'] =
          favouritePlanList!.map((v) => v.toJson()).toList();
    }
    if (responseDto != null) {
      data['responseDto'] = responseDto!.toJson();
    }
    data['valid'] = valid;
    data['imagePath'] = imagePath;
    return data;
  }
}

class FavouritePlanList {
  PlanData? planData;
  bool? isFavourte;
  bool? isPlanActive;

  FavouritePlanList({this.planData, this.isFavourte});

  FavouritePlanList.fromJson(Map<String, dynamic> json) {
    planData =
        json['planData'] != null ? PlanData.fromJson(json['planData']) : null;
    isFavourte = json['isFavourte'];
    isPlanActive = json['isPlanActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (planData != null) {
      data['planData'] = planData!.toJson();
    }
    data['isPlanActive'] = isPlanActive;
    data['isFavourte'] = isFavourte;
    return data;
  }
}

class PlanData {
  int? id;
  String? planType;
  String? title;
  String? category;
  dynamic details;
  String? fileName;
  int? duration;
  double? calories;
  String? cuisine;
  int? sets;
  bool? active;
  bool? custom;
  String? userId;

  dynamic createdBy;
  String? createdAt;
  dynamic modifiedBy;
  String? modifiedAt;

  PlanData(
      {this.id,
      this.planType,
      this.title,
      this.category,
      this.details,
      this.fileName,
      this.duration,
      this.calories,
      this.cuisine,
      this.sets,
      this.active,
      this.custom,
      this.userId,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  PlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planType = json['planType'];
    title = json['title'];
    category = json['category'];
    details = json['details'];
    fileName = json['fileName'];
    duration = json['duration'];
    calories = json['calories'];
    cuisine = json['cuisine'];
    sets = json['sets'];
    active = json['active'];
    custom = json['custom'];
    userId = json['userId'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['planType'] = planType;
    data['title'] = title;
    data['category'] = category;
    data['details'] = details;
    data['fileName'] = fileName;
    data['duration'] = duration;
    data['calories'] = calories;
    data['cuisine'] = cuisine;
    data['sets'] = sets;
    data['active'] = active;
    data['custom'] = custom;
    data['userId'] = userId;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['modifiedBy'] = modifiedBy;
    data['modifiedAt'] = modifiedAt;
    return data;
  }
}

class ResponseDto {
  bool? status;
  String? message;
  int? id;
  String? userId;
  String? token;

  ResponseDto({this.status, this.message, this.id, this.userId, this.token});

  ResponseDto.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    userId = json['userId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['id'] = id;
    data['userId'] = userId;
    data['token'] = token;
    return data;
  }
}
