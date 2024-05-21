// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'grocery_category_model.dart';

class UserGroceryModel {
  List<GroceryCategoryModel>? groceryList;
  String? startDate;
  String? endDate;
  String? week;
  UserGroceryModel({
    this.groceryList,
    this.startDate,
    this.endDate,
    this.week,
  });

  UserGroceryModel copyWith({
    List<GroceryCategoryModel>? groceryList,
    String? startDate,
    String? endDate,
    String? week,
  }) {
    return UserGroceryModel(
      groceryList: groceryList ?? this.groceryList,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      week: week ?? this.week,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groceryList': groceryList!.map((x) => x.toMap()).toList(),
      'startDate': startDate,
      'endDate': endDate,
      'week': week,
    };
  }

  factory UserGroceryModel.fromMap(Map<String, dynamic> map) {
    return UserGroceryModel(
      groceryList: map['groceryList'] != null ? List<GroceryCategoryModel>.from((map['groceryList'] as List<dynamic>).map<GroceryCategoryModel?>((x) => GroceryCategoryModel.fromMap(x as Map<String,dynamic>),),) : [],
      startDate: map['startDate'] != null ? map['startDate'] as String : "",
      endDate: map['endDate'] != null ? map['endDate'] as String : "",
      week: map['week'] != null ? map['week'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGroceryModel.fromJson(String source) => UserGroceryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserGroceryModel(groceryList: $groceryList, startDate: $startDate, endDate: $endDate, week: $week)';
  }

  @override
  bool operator ==(covariant UserGroceryModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.groceryList, groceryList) &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.week == week;
  }

  @override
  int get hashCode {
    return groceryList.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      week.hashCode;
  }
}
