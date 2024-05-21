class CheatFoodModel {
  bool? isCheatFoodTaken;
  List<CheatFoodVM>? cheatFoodVM;

  CheatFoodModel({this.isCheatFoodTaken, this.cheatFoodVM});

  CheatFoodModel.fromJson(Map<String, dynamic> json) {
    isCheatFoodTaken = json['isCheatFoodTaken'];
    if (json['cheatFoodVM'] != null) {
      cheatFoodVM = <CheatFoodVM>[];
      json['cheatFoodVM'].forEach((v) {
        cheatFoodVM!.add(CheatFoodVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isCheatFoodTaken'] = isCheatFoodTaken;
    if (cheatFoodVM != null) {
      data['cheatFoodVM'] = cheatFoodVM!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheatFoodVM {
  int? id;
  String? foddTakenDate;
  double? totalCalories;

  CheatFoodVM({this.id, this.foddTakenDate, this.totalCalories});

  CheatFoodVM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foddTakenDate = json['foddTakenDate'];
    totalCalories = json['totalCalories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['foddTakenDate'] = foddTakenDate;
    data['totalCalories'] = totalCalories;
    return data;
  }
}
