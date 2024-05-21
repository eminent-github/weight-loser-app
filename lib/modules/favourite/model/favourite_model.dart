class FavouriteModel {
  int? favouriteId;
  int? planId;
  int? subTypeId;
  String? planName;
  String? filname;
  int? duration;
  int? calories;
  String? catagory;
  String? mealType;

  FavouriteModel({
    this.favouriteId,
    this.planId,
    this.subTypeId,
    this.planName,
    this.filname,
    this.duration,
    this.calories,
    this.catagory,
    this.mealType,
  });

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    favouriteId = json['favouriteId'];
    planId = json['planId'];
    subTypeId = json['subTypeId'];
    planName = json['planName'];
    filname = json['filname'];
    duration = json['duration'];
    calories = json['calories'];
    catagory = json['catagory'];
    mealType = json['mealType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favouriteId'] = favouriteId;
    data['planId'] = planId;
    data['subTypeId'] = subTypeId;
    data['planName'] = planName;
    data['filname'] = filname;
    data['duration'] = duration;
    data['calories'] = calories;
    data['catagory'] = catagory;
    data['mealType'] = mealType;
    return data;
  }
}
