class GetMessageModelForTechnicalSupport {
  dynamic technicalSupport;
  dynamic technicalSupportList;
  List<TechnicalSupportChatList>? technicalSupportChatList;
  dynamic responseDto;

  GetMessageModelForTechnicalSupport(
      {this.technicalSupport,
      this.technicalSupportList,
      this.technicalSupportChatList,
      this.responseDto});

  GetMessageModelForTechnicalSupport.fromJson(Map<String, dynamic> json) {
    technicalSupport = json['technicalSupport'];
    technicalSupportList = json['technicalSupportList'];
    if (json['technicalSupportChatList'] != null) {
      technicalSupportChatList = <TechnicalSupportChatList>[];
      json['technicalSupportChatList'].forEach((v) {
        technicalSupportChatList!.add(TechnicalSupportChatList.fromJson(v));
      });
    }
    responseDto = json['responseDto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['technicalSupport'] = technicalSupport;
    data['technicalSupportList'] = technicalSupportList;
    if (technicalSupportChatList != null) {
      data['technicalSupportChatList'] =
          technicalSupportChatList!.map((v) => v.toJson()).toList();
    }
    data['responseDto'] = responseDto;
    return data;
  }
}

class TechnicalSupportChatList {
  int? id;
  String? userId;
  dynamic staffId;
  String? text;
  String? fileName;

  TechnicalSupportChatList(
      {this.id, this.userId, this.staffId, this.text, this.fileName});

  TechnicalSupportChatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    staffId = json['staffId'];
    text = json['text'];
    fileName = json['fileName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['staffId'] = staffId;
    data['text'] = text;
    data['fileName'] = fileName;
    return data;
  }
}
