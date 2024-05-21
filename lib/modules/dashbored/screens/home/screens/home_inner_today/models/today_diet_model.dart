class UserTodayQuotaModel {
  double? cheatScore;
  String? cbtTitle;
  String? customerPackageStatus;
  bool? customerPackageExpired;
  BudgetVM? budgetVM;
  Qoutes? qoutes;
  List<ActiveFoodPlanVM>? activeFoodPlanVM;
  List<ActiveExercisePlanVM>? activeExercisePlanVM;
  List<ActiveMindPlanVM>? activeMindPlanVM;
  List<Todos>? todos;

  UserTodayQuotaModel({
    this.cheatScore,
    this.cbtTitle,
    this.budgetVM,
    this.activeFoodPlanVM,
    this.activeExercisePlanVM,
    this.activeMindPlanVM,
    this.todos,
    this.customerPackageStatus,
    this.customerPackageExpired,
  });

  UserTodayQuotaModel.fromJson(Map<String, dynamic> json) {
    cheatScore = json['cheatScore'];
    cbtTitle = json['cbtTitle'];
    customerPackageStatus = json['customerPackageStatus'];
    customerPackageExpired = json['customerPackageExpired'];
    budgetVM =
        json['budgetVM'] != null ? BudgetVM.fromJson(json['budgetVM']) : null;
    qoutes = json['qoutes'] != null ? Qoutes.fromJson(json['qoutes']) : null;
    if (json['activeFoodPlanVM'] != null) {
      activeFoodPlanVM = <ActiveFoodPlanVM>[];
      json['activeFoodPlanVM'].forEach((v) {
        activeFoodPlanVM!.add(ActiveFoodPlanVM.fromJson(v));
      });
    }
    if (json['activeExercisePlanVM'] != null) {
      activeExercisePlanVM = <ActiveExercisePlanVM>[];
      json['activeExercisePlanVM'].forEach((v) {
        activeExercisePlanVM!.add(ActiveExercisePlanVM.fromJson(v));
      });
    }
    if (json['activeMindPlanVM'] != null) {
      activeMindPlanVM = <ActiveMindPlanVM>[];
      json['activeMindPlanVM'].forEach((v) {
        activeMindPlanVM!.add(ActiveMindPlanVM.fromJson(v));
      });
    }
    if (json['todos'] != null) {
      todos = <Todos>[];
      json['todos'].forEach((v) {
        todos!.add(Todos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cheatScore'] = cheatScore;
    data['cbtTitle'] = cbtTitle;
    data['customerPackageStatus'] = customerPackageStatus;
    data['customerPackageExpired'] = customerPackageExpired;
    if (budgetVM != null) {
      data['budgetVM'] = budgetVM!.toJson();
    }
    if (qoutes != null) {
      data['qoutes'] = qoutes!.toJson();
    }
    if (activeFoodPlanVM != null) {
      data['activeFoodPlanVM'] =
          activeFoodPlanVM!.map((v) => v.toJson()).toList();
    }
    if (activeExercisePlanVM != null) {
      data['activeExercisePlanVM'] =
          activeExercisePlanVM!.map((v) => v.toJson()).toList();
    }
    if (activeMindPlanVM != null) {
      data['activeMindPlanVM'] =
          activeMindPlanVM!.map((v) => v.toJson()).toList();
    }
    if (todos != null) {
      data['todos'] = todos!.map((v) => v.toJson()).toList();
    }
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
  String? userName;
  String? email;
  int? targetCalories;
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
      this.userName,
      this.email,
      this.targetCalories,
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
    userName = json['userName'];
    email = json['email'];
    targetCalories = json['targetCalories'];
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
    data['userName'] = userName;
    data['email'] = email;
    data['targetCalories'] = targetCalories;
    data['createdAt'] = createdAt;
    data['targetFat'] = targetFat;
    data['targetCarbs'] = targetCarbs;
    data['targetProtein'] = targetProtein;
    data['targetSodium'] = targetSodium;
    return data;
  }
}

class ActiveFoodPlanVM {
  String? foodId;
  String? name;
  String? description;
  String? servingSize;
  double? fat;
  double? carbs;
  double? protein;
  double? sodium;
  int? calories;
  String? foodImage;
  int? day;
  int? planId;
  String? mealType;
  String? projectTitle;
  String? projectDuration;
  String? planImage;
  String? planType;
  int? phase;
  bool? isAllergic;
  bool? isTaken;
  String? allergicFood;
  String? custom;

  ActiveFoodPlanVM(
      {this.foodId,
      this.name,
      this.description,
      this.servingSize,
      this.fat,
      this.carbs,
      this.protein,
      this.sodium,
      this.calories,
      this.foodImage,
      this.day,
      this.planId,
      this.mealType,
      this.projectTitle,
      this.projectDuration,
      this.planImage,
      this.planType,
      this.phase,
      this.isAllergic,
      this.isTaken,
      this.custom,
      this.allergicFood});

  ActiveFoodPlanVM.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    name = json['name'];
    description = json['description'];
    servingSize = json['servingSize'];
    fat = json['fat'];
    carbs = json['carbs'];
    protein = json['protein'];
    sodium = json['sodium'];
    calories = json['calories'];
    foodImage = json['foodImage'];
    day = json['day'];
    planId = json['planId'];
    mealType = json['mealType'];
    projectTitle = json['projectTitle'];
    projectDuration = json['projectDuration'];
    planImage = json['planImage'];
    planType = json['planType'];
    phase = json['phase'];
    isAllergic = json['isAllergic'];
    isTaken = json['isTaken'];
    allergicFood = json['allergicFood'];
    custom = json['custom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foodId'] = foodId;
    data['name'] = name;
    data['description'] = description;
    data['servingSize'] = servingSize;
    data['fat'] = fat;
    data['carbs'] = carbs;
    data['protein'] = protein;
    data['sodium'] = sodium;
    data['calories'] = calories;
    data['foodImage'] = foodImage;
    data['day'] = day;
    data['planId'] = planId;
    data['mealType'] = mealType;
    data['projectTitle'] = projectTitle;
    data['projectDuration'] = projectDuration;
    data['planImage'] = planImage;
    data['planType'] = planType;
    data['phase'] = phase;
    data['isAllergic'] = isAllergic;
    data['isTaken'] = isTaken;
    data['allergicFood'] = allergicFood;
    data['custom'] = custom;
    return data;
  }
}

class ActiveExercisePlanVM {
  String? name;
  double? calories;
  String? exerciseImage;
  int? exerciseDuration;
  int? day;
  int? exerciseId;
  int? planId;
  String? title;
  double? totalCalories;
  String? planTitle;
  String? planDuration;
  String? planImage;
  String? planType;
  String? videoFile;
  int? durationCompleted;
  bool? isRep;

  ActiveExercisePlanVM({
    this.name,
    this.calories,
    this.exerciseImage,
    this.exerciseDuration,
    this.day,
    this.exerciseId,
    this.planId,
    this.title,
    this.totalCalories,
    this.planTitle,
    this.planDuration,
    this.planImage,
    this.planType,
    this.videoFile,
    this.durationCompleted,
    this.isRep,
  });

  ActiveExercisePlanVM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    calories = json['calories'];
    exerciseImage = json['exerciseImage'];
    exerciseDuration = json['exerciseDuration'];
    day = json['day'];
    exerciseId = json['exerciseId'];
    planId = json['planId'];
    title = json['title'];
    totalCalories = json['totalCalories'];
    planTitle = json['planTitle'];
    planDuration = json['planDuration'];
    planImage = json['planImage'];
    planType = json['planType'];
    videoFile = json['videoFile'];
    durationCompleted = json['durationCompleted'];
    isRep = json['isRep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['calories'] = calories;
    data['exerciseImage'] = exerciseImage;
    data['exerciseDuration'] = exerciseDuration;
    data['day'] = day;
    data['exerciseId'] = exerciseId;
    data['planId'] = planId;
    data['title'] = title;
    data['totalCalories'] = totalCalories;
    data['planTitle'] = planTitle;
    data['planDuration'] = planDuration;
    data['planImage'] = planImage;
    data['planType'] = planType;
    data['videoFile'] = videoFile;
    data['durationCompleted'] = durationCompleted;
    data['isRep'] = isRep;
    return data;
  }
}

class ActiveMindPlanVM {
  int? vidId;
  String? title;
  String? description;
  String? videoFile;
  int? duration;
  int? day;
  String? planTitle;
  int? mindPlanId;
  double? totalCalories;
  String? planDuration;
  String? planImage;
  String? imageFile;
  String? planType;

  ActiveMindPlanVM(
      {this.vidId,
      this.title,
      this.description,
      this.videoFile,
      this.duration,
      this.day,
      this.planTitle,
      this.mindPlanId,
      this.totalCalories,
      this.planDuration,
      this.planImage,
      this.imageFile,
      this.planType});

  ActiveMindPlanVM.fromJson(Map<String, dynamic> json) {
    vidId = json['vidId'];
    title = json['title'];
    description = json['description'];
    videoFile = json['videoFile'];
    duration = json['duration'];
    day = json['day'];
    planTitle = json['planTitle'];
    mindPlanId = json['mindPlanId'];
    totalCalories = json['totalCalories'];
    planDuration = json['planDuration'];
    planImage = json['planImage'];
    imageFile = json['imageFile'];
    planType = json['planType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vidId'] = vidId;
    data['title'] = title;
    data['description'] = description;
    data['videoFile'] = videoFile;
    data['duration'] = duration;
    data['day'] = day;
    data['planTitle'] = planTitle;
    data['mindPlanId'] = mindPlanId;
    data['totalCalories'] = totalCalories;
    data['planDuration'] = planDuration;
    data['planImage'] = planImage;
    data['imageFile'] = imageFile;
    data['planType'] = planType;
    return data;
  }
}

class Todos {
  int? id;
  int? todosId;
  bool? completed;
  String? title;
  String? description;
  int? duration;
  String? image;

  Todos(
      {this.id,
      this.todosId,
      this.completed,
      this.title,
      this.description,
      this.duration,
      this.image});

  Todos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todosId = json['todosId'];
    completed = json['completed'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['todosId'] = todosId;
    data['completed'] = completed;
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['image'] = image;
    return data;
  }
}

class Qoutes {
  int? id;
  String? qoute;
  String? type;
  bool? active;
  int? day;

  Qoutes({this.id, this.qoute, this.type, this.active, this.day});

  Qoutes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qoute = json['qoute'];
    type = json['type'];
    active = json['active'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qoute'] = qoute;
    data['type'] = type;
    data['active'] = active;
    data['day'] = day;
    return data;
  }
}
