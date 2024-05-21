class GetQuestionWithAnswerModel {
  int? userQuestionOrder;
  Response? response;

  GetQuestionWithAnswerModel({this.userQuestionOrder, this.response});

  GetQuestionWithAnswerModel.fromJson(Map<String, dynamic> json) {
    userQuestionOrder = json['userQuestionOrder'];
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userQuestionOrder'] = userQuestionOrder;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  int? id;
  String? title;
  String? question;
  List<Option>? option;
  String? type;
  String? fileName;
  int? order;

  Response(
      {this.id,
      this.title,
      this.question,
      this.option,
      this.type,
      this.fileName,
      this.order});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    question = json['question'];
    if (json['option'] != null) {
      option = <Option>[];
      json['option'].forEach((v) {
        option!.add(Option.fromJson(v));
      });
    }
    type = json['type'];
    fileName = json['fileName'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['question'] = question;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['fileName'] = fileName;
    data['order'] = order;
    return data;
  }
}

class Option {
  dynamic id;
  String? option;
  dynamic correctAnswer;
  dynamic explanationAnswer;
  bool isSelected=false;

  Option({
    this.id,
    this.option,
    this.correctAnswer,
    this.explanationAnswer,
    this.isSelected = false,
  });

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    option = json['option'];
    correctAnswer = json['correctAnswer'];
    explanationAnswer = json['explanationAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['option'] = option;
    data['correctAnswer'] = correctAnswer;
    data['explanationAnswer'] = explanationAnswer;
    return data;
  }
}
