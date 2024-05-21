class SavedPostModel {
  int? counterLikes;
  List<ChatDetailModeList>? chatDetailModeList;

  SavedPostModel({this.counterLikes, this.chatDetailModeList});

  SavedPostModel.fromJson(Map<String, dynamic> json) {
    counterLikes = json['counterLikes'];
    if (json['chatDetailModeList'] != null) {
      chatDetailModeList = <ChatDetailModeList>[];
      json['chatDetailModeList'].forEach((v) {
        chatDetailModeList!.add(new ChatDetailModeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counterLikes'] = this.counterLikes;
    if (this.chatDetailModeList != null) {
      data['chatDetailModeList'] =
          this.chatDetailModeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatDetailModeList {
  int? id;
  String? userId;
  String? commenterId;
  int? fileId;
  String? text;
  String? filename;
  List<String>? comment;
  bool? likes;
  bool? isActive;
  bool? commenterActive;

  ChatDetailModeList(
      {this.id,
      this.userId,
      this.commenterId,
      this.fileId,
      this.text,
      this.filename,
      this.comment,
      this.likes,
      this.isActive,
      this.commenterActive});

  ChatDetailModeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    commenterId = json['commenterId'];
    fileId = json['fileId'];
    text = json['text'];
    filename = json['filename'];
    comment = json['comment'];
    likes = json['likes'];
    isActive = json['isActive'];
    commenterActive = json['commenterActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['commenterId'] = this.commenterId;
    data['fileId'] = this.fileId;
    data['text'] = this.text;
    data['filename'] = this.filename;
    data['comment'] = this.comment;
    data['likes'] = this.likes;
    data['isActive'] = this.isActive;
    data['commenterActive'] = this.commenterActive;
    return data;
  }
}
