class SendTechnicalChatModel {
  int? id;
  int? roboChatId;
  String? roboId;
  String? userId;
  String? userName;
  String? posterText;
  String? roboText;

  SendTechnicalChatModel(
      {this.id,
      this.roboChatId,
      this.roboId,
      this.userId,
      this.userName,
      this.posterText,
      this.roboText});

  SendTechnicalChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roboChatId = json['roboChatId'];
    roboId = json['roboId'];
    userId = json['userId'];
    userName = json['userName'];
    posterText = json['posterText'];
    roboText = json['roboText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roboChatId'] = roboChatId;
    data['roboId'] = roboId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['posterText'] = posterText;
    data['roboText'] = roboText;
    return data;
  }
}
