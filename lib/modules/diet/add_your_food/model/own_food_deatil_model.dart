class OwnFoodDetailModel {
  String name;
  String? fileName;
  String servingSize;
  double fat;
  double protein;
  double carbs;
  int calories;
  String foodId;
  int day;
  String mealType;
  int phase;

  OwnFoodDetailModel({
    required this.name,
    this.fileName,
    required this.servingSize,
    required this.fat,
    required this.protein,
    required this.carbs,
    required this.calories,
    required this.foodId,
    required this.day,
    required this.mealType,
    required this.phase,
  });
}
