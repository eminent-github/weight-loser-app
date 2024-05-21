// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DiaryModel {
  BudgetVM? budgetVM;
  List<BreakfastList>? breakfastList;
  List<LuncheList>? luncheList;
  List<DinnerList>? dinnerList;
  List<SnackList>? snackList;
  List<WaterList>? waterList;
  double? breakFastCal;
  double? dinnerCal;
  double? lunchCal;
  double? snackCal;
  double? exerBurnCal;
  double? waterInTake;
  int? mindDuration;
  int? mindTotalDuration;
  DiaryModel({
    this.budgetVM,
    this.breakfastList,
    this.luncheList,
    this.dinnerList,
    this.snackList,
    this.waterList,
    this.breakFastCal,
    this.dinnerCal,
    this.lunchCal,
    this.snackCal,
    this.exerBurnCal,
    this.waterInTake,
    this.mindDuration,
    this.mindTotalDuration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'budgetVM': budgetVM?.toMap(),
      'breakfastList': breakfastList!.map((x) => x.toMap()).toList(),
      'luncheList': luncheList!.map((x) => x.toMap()).toList(),
      'dinnerList': dinnerList!.map((x) => x.toMap()).toList(),
      'snackList': snackList!.map((x) => x.toMap()).toList(),
      'waterList': waterList!.map((x) => x.toMap()).toList(),
      'breakFastCal': breakFastCal,
      'dinnerCal': dinnerCal,
      'lunchCal': lunchCal,
      'snackCal': snackCal,
      'exerBurnCal': exerBurnCal,
      'waterInTake': waterInTake,
      'mindDuration': mindDuration,
      'mindTotalDuration': mindTotalDuration,
    };
  }

  factory DiaryModel.fromMap(Map<String, dynamic> map) {
    return DiaryModel(
      budgetVM: map['budgetVM'] != null
          ? BudgetVM.fromMap(map['budgetVM'] as Map<String, dynamic>)
          : null,
      breakfastList: map['breakfastList'] != null
          ? List<BreakfastList>.from(
              (map['breakfastList'] as List<dynamic>).map<BreakfastList?>(
                (x) => BreakfastList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      luncheList: map['luncheList'] != null
          ? List<LuncheList>.from(
              (map['luncheList'] as List<dynamic>).map<LuncheList?>(
                (x) => LuncheList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      dinnerList: map['dinnerList'] != null
          ? List<DinnerList>.from(
              (map['dinnerList'] as List<dynamic>).map<DinnerList?>(
                (x) => DinnerList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      snackList: map['snackList'] != null
          ? List<SnackList>.from(
              (map['snackList'] as List<dynamic>).map<SnackList?>(
                (x) => SnackList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      waterList: map['waterList'] != null
          ? List<WaterList>.from(
              (map['waterList'] as List<dynamic>).map<WaterList?>(
                (x) => WaterList.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      breakFastCal:
          map['breakFastCal'] != null ? map['breakFastCal'] as double : null,
      dinnerCal: map['dinnerCal'] != null ? map['dinnerCal'] as double : null,
      lunchCal: map['lunchCal'] != null ? map['lunchCal'] as double : null,
      snackCal: map['snackCal'] != null ? map['snackCal'] as double : null,
      exerBurnCal:
          map['exerBurnCal'] != null ? map['exerBurnCal'] as double : null,
      waterInTake:
          map['waterInTake'] != null ? map['waterInTake'] as double : null,
      mindDuration:
          map['mindDuration'] != null ? map['mindDuration'] as int : 0,
      mindTotalDuration: map['mindTotalDuration'] != null
          ? map['mindTotalDuration'] as int
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryModel.fromJson(String source) =>
      DiaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiaryModel(budgetVM: $budgetVM, breakfastList: $breakfastList, luncheList: $luncheList, dinnerList: $dinnerList, snackList: $snackList, waterList: $waterList, breakFastCal: $breakFastCal, dinnerCal: $dinnerCal, lunchCal: $lunchCal, snackCal: $snackCal, exerBurnCal: $exerBurnCal, waterInTake: $waterInTake, mindDuration: $mindDuration)';
  }

  @override
  bool operator ==(covariant DiaryModel other) {
    if (identical(this, other)) return true;

    return other.budgetVM == budgetVM &&
        listEquals(other.breakfastList, breakfastList) &&
        listEquals(other.luncheList, luncheList) &&
        listEquals(other.dinnerList, dinnerList) &&
        listEquals(other.snackList, snackList) &&
        listEquals(other.waterList, waterList) &&
        other.breakFastCal == breakFastCal &&
        other.dinnerCal == dinnerCal &&
        other.lunchCal == lunchCal &&
        other.snackCal == snackCal &&
        other.exerBurnCal == exerBurnCal &&
        other.waterInTake == waterInTake &&
        other.mindDuration == mindDuration;
  }

  @override
  int get hashCode {
    return budgetVM.hashCode ^
        breakfastList.hashCode ^
        luncheList.hashCode ^
        dinnerList.hashCode ^
        snackList.hashCode ^
        waterList.hashCode ^
        breakFastCal.hashCode ^
        dinnerCal.hashCode ^
        lunchCal.hashCode ^
        snackCal.hashCode ^
        exerBurnCal.hashCode ^
        waterInTake.hashCode ^
        mindDuration.hashCode;
  }
}

class BudgetVM {
  int? budgetId;
  int? targetCalId;
  int? burnCalories;
  int? consCalories;
  double? fat;
  double? carbs;
  double? protein;
  double? dietScore;
  String? userId;
  String? userName;
  String? email;
  int? targetCalories;
  int? balanceCalories;
  String? createdAt;
  double? targetFat;
  double? targetCarbs;
  double? targetProtein;
  BudgetVM({
    this.budgetId,
    this.targetCalId,
    this.burnCalories,
    this.consCalories,
    this.fat,
    this.carbs,
    this.protein,
    this.dietScore,
    this.userId,
    this.userName,
    this.email,
    this.targetCalories,
    this.createdAt,
    this.targetFat,
    this.targetCarbs,
    this.targetProtein,
    this.balanceCalories,
  });

  BudgetVM copyWith({
    int? budgetId,
    int? targetCalId,
    int? burnCalories,
    int? consCalories,
    double? fat,
    double? carbs,
    double? protein,
    double? dietScore,
    String? userId,
    String? userName,
    String? email,
    int? targetCalories,
    String? createdAt,
    double? targetFat,
    double? targetCarbs,
    double? targetProtein,
  }) {
    return BudgetVM(
      budgetId: budgetId ?? this.budgetId,
      targetCalId: targetCalId ?? this.targetCalId,
      burnCalories: burnCalories ?? this.burnCalories,
      consCalories: consCalories ?? this.consCalories,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
      dietScore: dietScore ?? this.dietScore,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      targetCalories: targetCalories ?? this.targetCalories,
      createdAt: createdAt ?? this.createdAt,
      targetFat: targetFat ?? this.targetFat,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      targetProtein: targetProtein ?? this.targetProtein,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'budget_Id': budgetId,
      'target_cal_id': targetCalId,
      'burn_Calories': burnCalories,
      'cons_Calories': consCalories,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'dietScore': dietScore,
      'userId': userId,
      'userName': userName,
      'email': email,
      'targetCalories': targetCalories,
      'createdAt': createdAt,
      'targetFat': targetFat,
      'targetCarbs': targetCarbs,
      'targetProtein': targetProtein,
      'balanceCalories': balanceCalories,
    };
  }

  factory BudgetVM.fromMap(Map<String, dynamic> map) {
    return BudgetVM(
      budgetId: map['budget_Id'] != null ? map['budget_Id'] as int : null,
      targetCalId:
          map['target_cal_id'] != null ? map['target_cal_id'] as int : null,
      burnCalories:
          map['burn_Calories'] != null ? map['burn_Calories'] as int : null,
      consCalories:
          map['cons_Calories'] != null ? map['cons_Calories'] as int : null,
      fat: map['fat'] != null ? map['fat'] as double : null,
      carbs: map['carbs'] != null ? map['carbs'] as double : null,
      protein: map['protein'] != null ? map['protein'] as double : null,
      dietScore: map['dietScore'] != null ? map['dietScore'] as double : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      targetCalories:
          map['targetCalories'] != null ? map['targetCalories'] as int : null,
      balanceCalories:
          map['balanceCalories'] != null ? map['balanceCalories'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      targetFat: map['targetFat'] != null ? map['targetFat'] as double : null,
      targetCarbs:
          map['targetCarbs'] != null ? map['targetCarbs'] as double : null,
      targetProtein:
          map['targetProtein'] != null ? map['targetProtein'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetVM.fromJson(String source) =>
      BudgetVM.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BudgetVM(budgetId: $budgetId, targetCalId: $targetCalId, burnCalories: $burnCalories, consCalories: $consCalories, fat: $fat, carbs: $carbs, protein: $protein, dietScore: $dietScore, userId: $userId, userName: $userName, email: $email, targetCalories: $targetCalories, createdAt: $createdAt, targetFat: $targetFat, targetCarbs: $targetCarbs, targetProtein: $targetProtein)';
  }

  @override
  bool operator ==(covariant BudgetVM other) {
    if (identical(this, other)) return true;

    return other.budgetId == budgetId &&
        other.targetCalId == targetCalId &&
        other.burnCalories == burnCalories &&
        other.consCalories == consCalories &&
        other.fat == fat &&
        other.carbs == carbs &&
        other.protein == protein &&
        other.dietScore == dietScore &&
        other.userId == userId &&
        other.userName == userName &&
        other.email == email &&
        other.targetCalories == targetCalories &&
        other.createdAt == createdAt &&
        other.targetFat == targetFat &&
        other.targetCarbs == targetCarbs &&
        other.targetProtein == targetProtein;
  }

  @override
  int get hashCode {
    return budgetId.hashCode ^
        targetCalId.hashCode ^
        burnCalories.hashCode ^
        consCalories.hashCode ^
        fat.hashCode ^
        carbs.hashCode ^
        protein.hashCode ^
        dietScore.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        targetCalories.hashCode ^
        createdAt.hashCode ^
        targetFat.hashCode ^
        targetCarbs.hashCode ^
        targetProtein.hashCode;
  }
}

class BreakfastList {
  int? bfId;
  String? userId;
  int? consCalories;
  String? fName;
  String? imageName;
  String? bfDate;
  double? fat;
  double? protein;
  double? carbs;
  String? custom;
  BreakfastList({
    this.bfId,
    this.userId,
    this.consCalories,
    this.fName,
    this.imageName,
    this.bfDate,
    this.fat,
    this.protein,
    this.carbs,
    this.custom,
  });

  BreakfastList copyWith({
    int? bfId,
    String? userId,
    int? consCalories,
    String? fName,
    String? imageName,
    String? bfDate,
    double? fat,
    double? protein,
    double? carbs,
  }) {
    return BreakfastList(
      bfId: bfId ?? this.bfId,
      userId: userId ?? this.userId,
      consCalories: consCalories ?? this.consCalories,
      fName: fName ?? this.fName,
      imageName: imageName ?? this.imageName,
      bfDate: bfDate ?? this.bfDate,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bf_id': bfId,
      'userId': userId,
      'cons_calories': consCalories,
      'f_name': fName,
      'imageName': imageName,
      'bf_date': bfDate,
      'fat': fat,
      'protein': protein,
      'carbs': carbs,
    };
  }

  factory BreakfastList.fromMap(Map<String, dynamic> map) {
    return BreakfastList(
      bfId: map['bf_id'] != null ? map['bf_id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      consCalories:
          map['cons_calories'] != null ? map['cons_calories'] as int : null,
      fName: map['f_name'] != null ? map['f_name'] as String : null,
      imageName: map['imageName'] != null ? map['imageName'] as String : null,
      bfDate: map['bf_date'] != null ? map['bf_date'] as String : null,
      fat: map['fat'] != null ? map['fat'] as double : null,
      protein: map['protein'] != null ? map['protein'] as double : null,
      carbs: map['carbs'] != null ? map['carbs'] as double : null,
      custom: map['custom'] != null ? map['custom'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BreakfastList.fromJson(String source) =>
      BreakfastList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BreakfastList(bfId: $bfId, userId: $userId, consCalories: $consCalories, fName: $fName, imageName: $imageName, bfDate: $bfDate, fat: $fat, protein: $protein, carbs: $carbs)';
  }

  @override
  bool operator ==(covariant BreakfastList other) {
    if (identical(this, other)) return true;

    return other.bfId == bfId &&
        other.userId == userId &&
        other.consCalories == consCalories &&
        other.fName == fName &&
        other.imageName == imageName &&
        other.bfDate == bfDate &&
        other.fat == fat &&
        other.protein == protein &&
        other.carbs == carbs;
  }

  @override
  int get hashCode {
    return bfId.hashCode ^
        userId.hashCode ^
        consCalories.hashCode ^
        fName.hashCode ^
        imageName.hashCode ^
        bfDate.hashCode ^
        fat.hashCode ^
        protein.hashCode ^
        carbs.hashCode;
  }
}

class LuncheList {
  int? lId;
  String? userId;
  int? consCalories;
  String? fName;
  String? imageName;
  String? lDate;
  double? fat;
  double? protein;
  double? carbs;
  String? custom;
  LuncheList({
    this.lId,
    this.userId,
    this.consCalories,
    this.fName,
    this.imageName,
    this.lDate,
    this.fat,
    this.protein,
    this.carbs,
    this.custom,
  });

  LuncheList copyWith({
    int? lId,
    String? userId,
    int? consCalories,
    String? fName,
    String? imageName,
    String? lDate,
    double? fat,
    double? protein,
    double? carbs,
  }) {
    return LuncheList(
      lId: lId ?? this.lId,
      userId: userId ?? this.userId,
      consCalories: consCalories ?? this.consCalories,
      fName: fName ?? this.fName,
      imageName: imageName ?? this.imageName,
      lDate: lDate ?? this.lDate,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'l_id': lId,
      'userId': userId,
      'cons_calories': consCalories,
      'f_name': fName,
      'imageName': imageName,
      'l_date': lDate,
      'fat': fat,
      'protein': protein,
      'carbs': carbs,
    };
  }

  factory LuncheList.fromMap(Map<String, dynamic> map) {
    return LuncheList(
      lId: map['l_id'] != null ? map['l_id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      consCalories:
          map['cons_calories'] != null ? map['cons_calories'] as int : null,
      fName: map['f_name'] != null ? map['f_name'] as String : null,
      imageName: map['imageName'] != null ? map['imageName'] as String : null,
      lDate: map['l_date'] != null ? map['l_date'] as String : null,
      fat: map['fat'] != null ? map['fat'] as double : null,
      protein: map['protein'] != null ? map['protein'] as double : null,
      carbs: map['carbs'] != null ? map['carbs'] as double : null,
      custom: map['custom'] != null ? map['custom'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LuncheList.fromJson(String source) =>
      LuncheList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LuncheList(lId: $lId, userId: $userId, consCalories: $consCalories, fName: $fName, imageName: $imageName, lDate: $lDate, fat: $fat, protein: $protein, carbs: $carbs)';
  }

  @override
  bool operator ==(covariant LuncheList other) {
    if (identical(this, other)) return true;

    return other.lId == lId &&
        other.userId == userId &&
        other.consCalories == consCalories &&
        other.fName == fName &&
        other.imageName == imageName &&
        other.lDate == lDate &&
        other.fat == fat &&
        other.protein == protein &&
        other.carbs == carbs;
  }

  @override
  int get hashCode {
    return lId.hashCode ^
        userId.hashCode ^
        consCalories.hashCode ^
        fName.hashCode ^
        imageName.hashCode ^
        lDate.hashCode ^
        fat.hashCode ^
        protein.hashCode ^
        carbs.hashCode;
  }
}

class DinnerList {
  int? dId;
  String? userId;
  int? consCalories;
  String? fName;
  String? imageName;
  String? dDate;
  double? fat;
  double? protein;
  double? carbs;
  String? custom;
  DinnerList({
    this.dId,
    this.userId,
    this.consCalories,
    this.fName,
    this.imageName,
    this.dDate,
    this.fat,
    this.protein,
    this.carbs,
    this.custom,
  });

  DinnerList copyWith({
    int? dId,
    String? userId,
    int? consCalories,
    String? fName,
    String? imageName,
    String? dDate,
    double? fat,
    double? protein,
    double? carbs,
  }) {
    return DinnerList(
      dId: dId ?? this.dId,
      userId: userId ?? this.userId,
      consCalories: consCalories ?? this.consCalories,
      fName: fName ?? this.fName,
      imageName: imageName ?? this.imageName,
      dDate: dDate ?? this.dDate,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'd_id': dId,
      'userId': userId,
      'cons_calories': consCalories,
      'f_name': fName,
      'imageName': imageName,
      'd_date': dDate,
      'fat': fat,
      'protein': protein,
      'carbs': carbs,
    };
  }

  factory DinnerList.fromMap(Map<String, dynamic> map) {
    return DinnerList(
      dId: map['d_id'] != null ? map['d_id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      consCalories:
          map['cons_calories'] != null ? map['cons_calories'] as int : null,
      fName: map['f_name'] != null ? map['f_name'] as String : null,
      imageName: map['imageName'] != null ? map['imageName'] as String : null,
      dDate: map['d_date'] != null ? map['d_date'] as String : null,
      fat: map['fat'] != null ? map['fat'] as double : null,
      protein: map['protein'] != null ? map['protein'] as double : null,
      carbs: map['carbs'] != null ? map['carbs'] as double : null,
      custom: map['custom'] != null ? map['custom'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DinnerList.fromJson(String source) =>
      DinnerList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DinnerList(dId: $dId, userId: $userId, consCalories: $consCalories, fName: $fName, imageName: $imageName, dDate: $dDate, fat: $fat, protein: $protein, carbs: $carbs)';
  }

  @override
  bool operator ==(covariant DinnerList other) {
    if (identical(this, other)) return true;

    return other.dId == dId &&
        other.userId == userId &&
        other.consCalories == consCalories &&
        other.fName == fName &&
        other.imageName == imageName &&
        other.dDate == dDate &&
        other.fat == fat &&
        other.protein == protein &&
        other.carbs == carbs;
  }

  @override
  int get hashCode {
    return dId.hashCode ^
        userId.hashCode ^
        consCalories.hashCode ^
        fName.hashCode ^
        imageName.hashCode ^
        dDate.hashCode ^
        fat.hashCode ^
        protein.hashCode ^
        carbs.hashCode;
  }
}

class SnackList {
  int? snckId;
  String? userId;
  int? consCalories;
  String? fName;
  String? imageName;
  String? snckDate;
  double? fat;
  double? protein;
  double? carbs;
  String? custom;
  SnackList({
    this.snckId,
    this.userId,
    this.consCalories,
    this.fName,
    this.imageName,
    this.snckDate,
    this.fat,
    this.protein,
    this.carbs,
    this.custom,
  });

  SnackList copyWith({
    int? snckId,
    String? userId,
    int? consCalories,
    String? fName,
    String? imageName,
    String? snckDate,
    double? fat,
    double? protein,
    double? carbs,
  }) {
    return SnackList(
      snckId: snckId ?? this.snckId,
      userId: userId ?? this.userId,
      consCalories: consCalories ?? this.consCalories,
      fName: fName ?? this.fName,
      imageName: imageName ?? this.imageName,
      snckDate: snckDate ?? this.snckDate,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'snck_id': snckId,
      'userId': userId,
      'cons_calories': consCalories,
      'f_name': fName,
      'imageName': imageName,
      'snck_date': snckDate,
      'fat': fat,
      'protein': protein,
      'carbs': carbs,
    };
  }

  factory SnackList.fromMap(Map<String, dynamic> map) {
    return SnackList(
      snckId: map['snck_id'] != null ? map['snck_id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      consCalories:
          map['cons_calories'] != null ? map['cons_calories'] as int : null,
      fName: map['f_name'] != null ? map['f_name'] as String : null,
      imageName: map['imageName'] != null ? map['imageName'] as String : null,
      snckDate: map['snck_date'] != null ? map['snck_date'] as String : null,
      fat: map['fat'] != null ? map['fat'] as double : null,
      protein: map['protein'] != null ? map['protein'] as double : null,
      carbs: map['carbs'] != null ? map['carbs'] as double : null,
      custom: map['custom'] != null ? map['custom'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SnackList.fromJson(String source) =>
      SnackList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SnackList(snckId: $snckId, userId: $userId, consCalories: $consCalories, fName: $fName, imageName: $imageName, snckDate: $snckDate, fat: $fat, protein: $protein, carbs: $carbs)';
  }

  @override
  bool operator ==(covariant SnackList other) {
    if (identical(this, other)) return true;

    return other.snckId == snckId &&
        other.userId == userId &&
        other.consCalories == consCalories &&
        other.fName == fName &&
        other.imageName == imageName &&
        other.snckDate == snckDate &&
        other.fat == fat &&
        other.protein == protein &&
        other.carbs == carbs;
  }

  @override
  int get hashCode {
    return snckId.hashCode ^
        userId.hashCode ^
        consCalories.hashCode ^
        fName.hashCode ^
        imageName.hashCode ^
        snckDate.hashCode ^
        fat.hashCode ^
        protein.hashCode ^
        carbs.hashCode;
  }
}

class WaterList {
  int? id;
  int? serving;
  int? calories;
  String? date;
  WaterList({
    this.id,
    this.serving,
    this.calories,
    this.date,
  });

  WaterList copyWith({
    int? id,
    int? serving,
    int? calories,
    String? date,
  }) {
    return WaterList(
      id: id ?? this.id,
      serving: serving ?? this.serving,
      calories: calories ?? this.calories,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serving': serving,
      'calories': calories,
      'date': date,
    };
  }

  factory WaterList.fromMap(Map<String, dynamic> map) {
    return WaterList(
      id: map['id'] != null ? map['id'] as int : null,
      serving: map['serving'] != null ? map['serving'] as int : null,
      calories: map['calories'] != null ? map['calories'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WaterList.fromJson(String source) =>
      WaterList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WaterList(id: $id, serving: $serving, calories: $calories, date: $date)';
  }

  @override
  bool operator ==(covariant WaterList other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serving == serving &&
        other.calories == calories &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ serving.hashCode ^ calories.hashCode ^ date.hashCode;
  }
}
