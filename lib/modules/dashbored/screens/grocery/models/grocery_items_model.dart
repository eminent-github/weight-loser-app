// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroceryItemsModel {
  String? category;
  String? item;
  int? planId;
  int? listId;
  bool? purchased;
  GroceryItemsModel({
    this.category,
    this.item,
    this.planId,
    this.listId,
    this.purchased,
  });

  GroceryItemsModel copyWith({
    String? category,
    String? item,
    int? planId,
    int? listId,
    bool? purchased,
  }) {
    return GroceryItemsModel(
      category: category ?? this.category,
      item: item ?? this.item,
      planId: planId ?? this.planId,
      listId: listId ?? this.listId,
      purchased: purchased ?? this.purchased,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'item': item,
      'planId': planId,
      'listId': listId,
      'purchased': purchased,
    };
  }

  factory GroceryItemsModel.fromMap(Map<String, dynamic> map) {
    return GroceryItemsModel(
      category: map['category'] != null ? map['category'] as String : null,
      item: map['item'] != null ? map['item'] as String : null,
      planId: map['planId'] != null ? map['planId'] as int : null,
      listId: map['listId'] != null ? map['listId'] as int : null,
      purchased: map['purchased'] != null ? map['purchased'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroceryItemsModel.fromJson(String source) => GroceryItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroceryItemsModel(category: $category, item: $item, planId: $planId, listId: $listId, purchased: $purchased)';
  }

  @override
  bool operator ==(covariant GroceryItemsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.category == category &&
      other.item == item &&
      other.planId == planId &&
      other.listId == listId &&
      other.purchased == purchased;
  }

  @override
  int get hashCode {
    return category.hashCode ^
      item.hashCode ^
      planId.hashCode ^
      listId.hashCode ^
      purchased.hashCode;
  }
}
