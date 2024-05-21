class RecipeDetialModel {
  String name;
  dynamic fileName;
  String servingSize;
  double fat;
  double protein;
  double carbs;
  int calories;
  String foodId;
  int planId;
  bool isFavourite;

  RecipeDetialModel({
    required this.name,
    required this.fileName,
    required this.servingSize,
    required this.fat,
    required this.protein,
    required this.carbs,
    required this.calories,
    required this.foodId,
    required this.planId,
    required this.isFavourite,
  });
}
