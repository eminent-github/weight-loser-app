class FoodItemDetailModel {
  Food? food;
  FoodDetailVM? foodDetailVM;
  ResponseDto? responseDto;

  FoodItemDetailModel({this.food, this.foodDetailVM, this.responseDto});

  FoodItemDetailModel.fromJson(Map<String, dynamic> json) {
    food = json['food'] != null ? Food.fromJson(json['food']) : null;

    foodDetailVM = json['foodDetailVM'] != null
        ? FoodDetailVM.fromJson(json['foodDetailVM'])
        : null;
    responseDto = json['responseDto'] != null
        ? ResponseDto.fromJson(json['responseDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (food != null) {
      data['food'] = food!.toJson();
    }

    if (foodDetailVM != null) {
      data['foodDetailVM'] = foodDetailVM!.toJson();
    }
    if (responseDto != null) {
      data['responseDto'] = responseDto!.toJson();
    }
    return data;
  }
}

class Food {
  int? id;
  String? name;
  String? description;
  String? foodId;
  String? fileName;
  int? servingSize;
  String? houseHoldServing;
  double? fat;
  double? protein;
  double? satFat;
  double? sodium;
  double? fiber;
  double? sugar;
  double? carbs;
  double? tc;
  double? sr;
  int? calories;
  String? unit;
  String? cuisine;
  String? category;
  String? userId;

  String? createdAt;

  Food({
    this.id,
    this.name,
    this.description,
    this.foodId,
    this.fileName,
    this.servingSize,
    this.houseHoldServing,
    this.fat,
    this.protein,
    this.satFat,
    this.sodium,
    this.fiber,
    this.sugar,
    this.carbs,
    this.tc,
    this.sr,
    this.calories,
    this.unit,
    this.cuisine,
    this.category,
    this.userId,
    this.createdAt,
  });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    foodId = json['foodId'];
    fileName = json['fileName'];
    servingSize = json['servingSize'];
    houseHoldServing = json['houseHoldServing'];
    fat = json['fat'];
    protein = json['protein'];
    satFat = json['satFat'];
    sodium = json['sodium'];
    fiber = json['fiber'];
    sugar = json['sugar'];
    carbs = json['carbs'];
    tc = json['tc'];
    sr = json['sr'];
    calories = json['calories'];
    unit = json['unit'];
    cuisine = json['cuisine'];
    category = json['category'];
    userId = json['userId'];

    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['foodId'] = foodId;
    data['fileName'] = fileName;
    data['servingSize'] = servingSize;
    data['houseHoldServing'] = houseHoldServing;
    data['fat'] = fat;
    data['protein'] = protein;
    data['satFat'] = satFat;
    data['sodium'] = sodium;
    data['fiber'] = fiber;
    data['sugar'] = sugar;
    data['carbs'] = carbs;
    data['tc'] = tc;
    data['sr'] = sr;
    data['calories'] = calories;
    data['unit'] = unit;
    data['cuisine'] = cuisine;
    data['category'] = category;
    data['userId'] = userId;

    data['createdAt'] = createdAt;

    return data;
  }
}

class FoodDetailVM {
  int? id;
  int? planId;
  dynamic foodId;
  List<String>? ingredients;
  String? procedure;

  FoodDetailVM({
    this.id,
    this.planId,
    this.foodId,
    this.ingredients,
    this.procedure,
  });

  FoodDetailVM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['planId'];
    foodId = json['foodId'];
    ingredients = List.castFrom<dynamic, String>(json['ingredients']);
    procedure = json['procedure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['planId'] = planId;
    data['foodId'] = foodId;
    data['ingredients'] = ingredients;
    data['procedure'] = procedure;

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
