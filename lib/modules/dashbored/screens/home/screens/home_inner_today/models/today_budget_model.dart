class TodayBudgetModel {
  double? cheatScore;
  String? customerPackageStatus;
  bool? customerPackageExpired;
  CustomerPackages? customerPackages;
  BudgetVM? budgetVM;

  TodayBudgetModel(
      {this.cheatScore,
      this.customerPackageStatus,
      this.customerPackageExpired,
      this.customerPackages,
      this.budgetVM});

  TodayBudgetModel.fromJson(Map<String, dynamic> json) {
    cheatScore = json['cheatScore'];
    customerPackageStatus = json['customerPackageStatus'];
    customerPackageExpired = json['customerPackageExpired'];
    customerPackages = json['customerPackages'] != null
        ? CustomerPackages.fromJson(json['customerPackages'])
        : null;
    budgetVM =
        json['budgetVM'] != null ? BudgetVM.fromJson(json['budgetVM']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cheatScore'] = cheatScore;
    data['customerPackageStatus'] = customerPackageStatus;
    data['customerPackageExpired'] = customerPackageExpired;
    if (customerPackages != null) {
      data['customerPackages'] = customerPackages!.toJson();
    }
    if (budgetVM != null) {
      data['budgetVM'] = budgetVM!.toJson();
    }
    return data;
  }
}

class CustomerPackages {
  int? id;
  int? packageId;
  String? userId;
  String? name;
  double? amount;
  double? discount;
  double? discountPrice;
  double? totalAmount;
  String? startDate;
  String? endDate;
  String? type;
  String? status;
  int? duration;

  CustomerPackages(
      {this.id,
      this.packageId,
      this.userId,
      this.name,
      this.amount,
      this.discount,
      this.discountPrice,
      this.totalAmount,
      this.startDate,
      this.endDate,
      this.type,
      this.status,
      this.duration});

  CustomerPackages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'];
    userId = json['userId'];
    name = json['name'];
    amount = json['amount'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    totalAmount = json['totalAmount'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    type = json['type'];
    status = json['status'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['packageId'] = packageId;
    data['userId'] = userId;
    data['name'] = name;
    data['amount'] = amount;
    data['discount'] = discount;
    data['discountPrice'] = discountPrice;
    data['totalAmount'] = totalAmount;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['type'] = type;
    data['status'] = status;
    data['duration'] = duration;
    return data;
  }
}

class BudgetVM {
  int? budgetId;
  int? targetCalId;
  int? burnCalories;
  int? consCalories;
  double? fat;
  double? sodium;
  double? carbs;
  double? protein;
  double? dietScore;
  String? userId;
  int? targetCalories;
  int? balanceCalories;
  String? createdAt;
  double? targetFat;
  double? targetCarbs;
  double? targetProtein;
  double? targetSodium;

  BudgetVM(
      {this.budgetId,
      this.targetCalId,
      this.burnCalories,
      this.consCalories,
      this.fat,
      this.sodium,
      this.carbs,
      this.protein,
      this.dietScore,
      this.userId,
      this.targetCalories,
      this.balanceCalories,
      this.createdAt,
      this.targetFat,
      this.targetCarbs,
      this.targetProtein,
      this.targetSodium});

  BudgetVM.fromJson(Map<String, dynamic> json) {
    budgetId = json['budget_Id'];
    targetCalId = json['target_cal_id'];
    burnCalories = json['burn_Calories'];
    consCalories = json['cons_Calories'];
    fat = json['fat'];
    sodium = json['sodium'];
    carbs = json['carbs'];
    protein = json['protein'];
    dietScore = json['dietScore'];
    userId = json['userId'];
    targetCalories = json['targetCalories'];
    balanceCalories = json['balanceCalories'];
    createdAt = json['createdAt'];
    targetFat = json['targetFat'];
    targetCarbs = json['targetCarbs'];
    targetProtein = json['targetProtein'];
    targetSodium = json['targetSodium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budget_Id'] = budgetId;
    data['target_cal_id'] = targetCalId;
    data['burn_Calories'] = burnCalories;
    data['cons_Calories'] = consCalories;
    data['fat'] = fat;
    data['sodium'] = sodium;
    data['carbs'] = carbs;
    data['protein'] = protein;
    data['dietScore'] = dietScore;
    data['userId'] = userId;
    data['targetCalories'] = targetCalories;
    data['balanceCalories'] = balanceCalories;
    data['createdAt'] = createdAt;
    data['targetFat'] = targetFat;
    data['targetCarbs'] = targetCarbs;
    data['targetProtein'] = targetProtein;
    data['targetSodium'] = targetSodium;
    return data;
  }
}
