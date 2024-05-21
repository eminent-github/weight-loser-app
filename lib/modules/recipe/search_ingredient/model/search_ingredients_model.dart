class SearchIngredientsModel {
  int? id;
  String? name;
  String? description;
  String? foodId;
  String? fileName;
  int? servingSize;
  dynamic houseHoldServing;
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
  dynamic unit;
  String? cuisine;
  String? category;

  SearchIngredientsModel(
      {this.id,
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
      this.category});

  SearchIngredientsModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
