// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserRecipeModel {
  int? planId;
  List<UserCustomRecipeList>? userCustomRecipeList;
  UserRecipeModel({
    this.planId,
    this.userCustomRecipeList,
  });

  // UserRecipeModel.fromJson(Map<String, dynamic> json) {
  //   planId = json['planId'] as int;
  //   if (json['userCustomRecipeList'] != null) {
  //     userCustomRecipeList = <UserCustomRecipeList>[];
  //     var jsonList = json['userCustomRecipeList'] as List;
  //     jsonList.map((v) {
  //       userCustomRecipeList!.add(UserCustomRecipeList.fromJson(v));
  //     });
  //   }
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planId': planId,
      'userCustomRecipeList':
          userCustomRecipeList!.map((x) => x.toJson()).toList(),
    };
  }

  factory UserRecipeModel.fromMap(Map<String, dynamic> map) {
    return UserRecipeModel(
      planId: map['planId'] != null ? map['planId'] as int : 0,
      userCustomRecipeList: map['userCustomRecipeList'] != null
          ? List<UserCustomRecipeList>.from(
              (map['userCustomRecipeList'] as List<dynamic>)
                  .map<UserCustomRecipeList?>(
                (x) => UserCustomRecipeList.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRecipeModel.fromJson(String source) =>
      UserRecipeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserCustomRecipeList {
  int? id;
  String? name;
  String? description;
  String? foodId;
  dynamic fileName;
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
  int? planId;
  String? ingredients;
  String? procedure;
  String? grocery;
  String? items;
  String? allergicFood;
  bool? isAllergic;

  UserCustomRecipeList(
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
      this.category,
      this.planId,
      this.ingredients,
      this.procedure,
      this.grocery,
      this.items,
      this.allergicFood,
      this.isAllergic});

  UserCustomRecipeList.fromJson(Map<String, dynamic> json) {
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
    planId = json['planId'];
    ingredients = json['ingredients'];
    procedure = json['procedure'];
    grocery = json['grocery'];
    items = json['items'];
    allergicFood = json['allergicFood'];
    isAllergic = json['isAllergic'];
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
    data['planId'] = planId;
    data['ingredients'] = ingredients;
    data['procedure'] = procedure;
    data['grocery'] = grocery;
    data['items'] = items;
    data['allergicFood'] = allergicFood;
    data['isAllergic'] = isAllergic;
    return data;
  }
}
