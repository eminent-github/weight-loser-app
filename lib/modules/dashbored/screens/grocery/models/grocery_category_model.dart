// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'grocery_items_model.dart';

class GroceryCategoryModel {
  String? category;
  List<GroceryItemsModel>? items;
  String? imagePath;
  String? startDate;
  GroceryCategoryModel({
    this.category,
    this.items,
    this.imagePath,
    this.startDate,
  });

  GroceryCategoryModel copyWith({
    String? category,
    List<GroceryItemsModel>? items,
    String? imagePath,
    String? startDate,
  }) {
    return GroceryCategoryModel(
      category: category ?? this.category,
      items: items ?? this.items,
      imagePath: imagePath ?? this.imagePath,
      startDate: startDate ?? this.startDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'items': items!.map((x) => x.toMap()).toList(),
      'imagePath': imagePath,
      'startDate': startDate,
    };
  }

  factory GroceryCategoryModel.fromMap(Map<String, dynamic> map) {
    return GroceryCategoryModel(
      category: map['category'] != null ? map['category'] as String : null,
      items: map['items'] != null
          ? List<GroceryItemsModel>.from(
              (map['items'] as List<dynamic>).map<GroceryItemsModel?>(
                (x) => GroceryItemsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroceryCategoryModel.fromJson(String source) =>
      GroceryCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroceryCategoryModel(category: $category, items: $items, imagePath: $imagePath, startDate: $startDate)';
  }

  @override
  bool operator ==(covariant GroceryCategoryModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        listEquals(other.items, items) &&
        other.imagePath == imagePath &&
        other.startDate == startDate;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        items.hashCode ^
        imagePath.hashCode ^
        startDate.hashCode;
  }
}
