// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReplaceFoodRouteModel {
  String? planFoodId;
  String? repFoodId;
  int? planId;
  int? day;
  String? mealType;
  int? phase;
  int? servingSize;
  ReplaceFoodRouteModel({
    this.planFoodId,
    this.repFoodId,
    this.planId,
    this.day,
    this.mealType,
    this.phase,
    this.servingSize,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planFoodId': planFoodId,
      'repFoodId': repFoodId,
      'planId': planId,
      'day': day,
      'mealType': mealType,
      'phase': phase,
      'servingSize': servingSize,
    };
  }

  factory ReplaceFoodRouteModel.fromMap(Map<String, dynamic> map) {
    return ReplaceFoodRouteModel(
      planFoodId:
          map['planFoodId'] != null ? map['planFoodId'] as String : null,
      repFoodId: map['repFoodId'] != null ? map['repFoodId'] as String : null,
      planId: map['planId'] != null ? map['planId'] as int : null,
      day: map['day'] != null ? map['day'] as int : null,
      mealType: map['mealType'] != null ? map['mealType'] as String : null,
      phase: map['phase'] != null ? map['phase'] as int : null,
      servingSize:
          map['servingSize'] != null ? map['servingSize'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReplaceFoodRouteModel.fromJson(String source) =>
      ReplaceFoodRouteModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReplaceFoodRouteModel(planFoodId: $planFoodId, repFoodId: $repFoodId, planId: $planId, day: $day, mealType: $mealType, phase: $phase, servingSize: $servingSize)';
  }

  @override
  bool operator ==(covariant ReplaceFoodRouteModel other) {
    if (identical(this, other)) return true;

    return other.planFoodId == planFoodId &&
        other.repFoodId == repFoodId &&
        other.planId == planId &&
        other.day == day &&
        other.mealType == mealType &&
        other.phase == phase &&
        other.servingSize == servingSize;
  }

  @override
  int get hashCode {
    return planFoodId.hashCode ^
        repFoodId.hashCode ^
        planId.hashCode ^
        day.hashCode ^
        mealType.hashCode ^
        phase.hashCode ^
        servingSize.hashCode;
  }
}
