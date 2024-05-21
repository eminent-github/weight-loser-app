class QuestionHistoryModel {
  int? userQuestionOrder;
  String? pageName;
  bool? isCompleted;
  bool? packageValid;

  QuestionHistoryModel(
      {this.userQuestionOrder,
      this.pageName,
      this.isCompleted,
      this.packageValid});

  QuestionHistoryModel.fromJson(Map<String, dynamic> json) {
    userQuestionOrder = json['userQuestionOrder'];
    pageName = json['pageName'];
    isCompleted = json['isCompleted'];
    packageValid = json['packageValid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userQuestionOrder'] = userQuestionOrder;
    data['pageName'] = pageName;
    data['isCompleted'] = isCompleted;
    data['packageValid'] = packageValid;
    return data;
  }
}
