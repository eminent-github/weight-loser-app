class DiscoverRecipeModel {
  String? cuisine;
  String? foodId;
  String? name;
  String? description;
  String? servingSize;
  double? fat;
  double? carbs;
  double? protein;
  int? calories;
  String? fileName;
  int? day;
  int? foodPlanId;
  int? favouriteSType;
  int? planId;
  String? mealType;
  String? planServingSize;
  String? ingredients;
  bool? isAllergic;
  bool? isFavourite;
  String? allergicFood;
  int? phase;

  DiscoverRecipeModel(
      {this.cuisine,
      this.foodId,
      this.name,
      this.description,
      this.servingSize,
      this.fat,
      this.carbs,
      this.protein,
      this.calories,
      this.fileName,
      this.day,
      this.foodPlanId,
      this.favouriteSType,
      this.planId,
      this.mealType,
      this.planServingSize,
      this.ingredients,
      this.isAllergic,
      this.isFavourite,
      this.allergicFood,
      this.phase});

  DiscoverRecipeModel.fromJson(Map<String, dynamic> json) {
    cuisine = json['cuisine'];
    foodId = json['foodId'];
    name = json['name'];
    description = json['description'];
    servingSize = json['servingSize'];
    fat = json['fat'];
    carbs = json['carbs'];
    protein = json['protein'];
    calories = json['calories'];
    fileName = json['fileName'];
    day = json['day'];
    foodPlanId = json['foodPlanId'];
    favouriteSType = json['favouriteSType'];
    planId = json['planId'];
    mealType = json['mealType'];
    planServingSize = json['planServingSize'];
    ingredients = json['ingredients'];
    isAllergic = json['isAllergic'];
    isFavourite = json['isFavourite'];
    allergicFood = json['allergicFood'];
    phase = json['phase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cuisine'] = cuisine;
    data['foodId'] = foodId;
    data['name'] = name;
    data['description'] = description;
    data['servingSize'] = servingSize;
    data['fat'] = fat;
    data['carbs'] = carbs;
    data['protein'] = protein;
    data['calories'] = calories;
    data['fileName'] = fileName;
    data['day'] = day;
    data['foodPlanId'] = foodPlanId;
    data['favouriteSType'] = favouriteSType;
    data['planId'] = planId;
    data['mealType'] = mealType;
    data['planServingSize'] = planServingSize;
    data['ingredients'] = ingredients;
    data['isAllergic'] = isAllergic;
    data['isFavourite'] = isFavourite;
    data['allergicFood'] = allergicFood;
    data['phase'] = phase;
    return data;
  }
}
