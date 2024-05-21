class CBTQuestionsModel {
  int? id;
  CbtSummary? title;
  String? question;
  List<Option>? option;
  String? type;
  bool? isRandom;
  CbtSummary? randomOption;
  int? order;

  CBTQuestionsModel(
      {this.id,
      this.title,
      this.question,
      this.option,
      this.type,
      this.isRandom,
      this.randomOption,
      this.order});

  CBTQuestionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? CbtSummary.fromJson(json['title']) : null;
    question = json['question'];
    if (json['option'] != null) {
      option = <Option>[];
      json['option'].forEach((v) {
        option!.add(Option.fromJson(v));
      });
    }
    type = json['type'];
    isRandom = json['isRandom'];
    randomOption = json['randomOption'] != null
        ? CbtSummary.fromJson(json['randomOption'])
        : null;
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['question'] = question;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['isRandom'] = isRandom;
    if (randomOption != null) {
      data['randomOption'] = randomOption!.toJson();
    }
    data['order'] = order;
    return data;
  }
}

class CbtSummary {
  String? title;
  String? summary;
  String? image;

  CbtSummary({this.title, this.summary, this.image});

  CbtSummary.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    summary = json['summary'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['summary'] = summary;
    data['image'] = image;
    return data;
  }
}

class Option {
  dynamic id;
  String? options;
  String? cbtAnswer;
  String? explanation;

  Option({this.id, this.options, this.cbtAnswer, this.explanation});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    options = json['options'];
    cbtAnswer = json['cbtAnswer'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['options'] = options;
    data['cbtAnswer'] = cbtAnswer;
    data['explanation'] = explanation;
    return data;
  }
}