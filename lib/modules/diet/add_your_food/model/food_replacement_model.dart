class FoodList {
  String? foodId;
  String? name;
  dynamic cuisine;
  dynamic description;
  String? servingSize;
  double? fat;
  double? carbs;
  double? protein;
  int? calories;
  String? fileName;
  int? day;
  int? foodPlanId;
  int? planId;
  String? mealType;
  String? planServingSize;
  String? ingredients;
  bool? isAllergic;
  String? allergicFood;
  int? phase;

  FoodList(
      {this.foodId,
      this.name,
      this.cuisine,
      this.description,
      this.servingSize,
      this.fat,
      this.carbs,
      this.protein,
      this.calories,
      this.fileName,
      this.day,
      this.foodPlanId,
      this.planId,
      this.mealType,
      this.planServingSize,
      this.ingredients,
      this.isAllergic,
      this.allergicFood,
      this.phase});

  FoodList.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    name = json['name'];
    cuisine = json['cuisine'];
    description = json['description'];
    servingSize = json['servingSize'];
    fat = json['fat'];
    carbs = json['carbs'];
    protein = json['protein'];
    calories = json['calories'];
    fileName = json['fileName'];
    day = json['day'];
    foodPlanId = json['foodPlanId'];
    planId = json['planId'];
    mealType = json['mealType'];
    planServingSize = json['planServingSize'];
    ingredients = json['ingredients'];
    isAllergic = json['isAllergic'];
    allergicFood = json['allergicFood'];
    phase = json['phase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foodId'] = foodId;
    data['name'] = name;
    data['cuisine'] = cuisine;
    data['description'] = description;
    data['servingSize'] = servingSize;
    data['fat'] = fat;
    data['carbs'] = carbs;
    data['protein'] = protein;
    data['calories'] = calories;
    data['fileName'] = fileName;
    data['day'] = day;
    data['foodPlanId'] = foodPlanId;
    data['planId'] = planId;
    data['mealType'] = mealType;
    data['planServingSize'] = planServingSize;
    data['ingredients'] = ingredients;
    data['isAllergic'] = isAllergic;
    data['allergicFood'] = allergicFood;
    data['phase'] = phase;
    return data;
  }
}
