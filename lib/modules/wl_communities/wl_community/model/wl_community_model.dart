// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommunityAllPostsModel {
  List<ListCommentors>? listCommentors;
  ChatPoster? chatPoster;
  int? totalLikes;
  int? totlalComments;
  bool? isLikedByUser;
  bool? isSavedByUser;

  CommunityAllPostsModel({
    this.listCommentors,
    this.chatPoster,
    this.totalLikes,
    this.totlalComments,
    this.isLikedByUser,
    this.isSavedByUser,
  });

  CommunityAllPostsModel.fromJson(Map<String, dynamic> json) {
    if (json['listCommentors'] != null) {
      listCommentors = <ListCommentors>[];
      json['listCommentors'].forEach((v) {
        listCommentors!.add(ListCommentors.fromJson(v));
      });
    }
    chatPoster = json['chatPoster'] != null
        ? ChatPoster.fromJson(json['chatPoster'])
        : null;
    totalLikes = json['totalLikes'];
    totlalComments = json['totlalComments'];
    isLikedByUser = json['isLikedByUser'];
    isSavedByUser = json['isSavedByUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listCommentors != null) {
      data['listCommentors'] = listCommentors!.map((v) => v.toJson()).toList();
    }
    if (chatPoster != null) {
      data['chatPoster'] = chatPoster!.toJson();
    }
    data['totalLikes'] = totalLikes;
    data['totlalComments'] = totlalComments;
    return data;
  }

  @override
  String toString() {
    return 'CommunityAllPostsModel(listCommentors: $listCommentors, chatPoster: $chatPoster, totalLikes: $totalLikes, totlalComments: $totlalComments, isLikedByUser: $isLikedByUser, isSavedByUser: $isSavedByUser)';
  }
}

class ListCommentors {
  bool? likes;
  String? comment;
  String? name;
  String? imgPath;
  bool? isActive;
  int? chatDetailId;

  ListCommentors(
      {this.likes, this.comment, this.name, this.imgPath, this.isActive});

  ListCommentors.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    comment = json['comment'];
    name = json['name'];
    imgPath = json['imgPath'];
    isActive = json['isActive'];
    chatDetailId = json['chatDetailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likes'] = likes;
    data['comment'] = comment;
    data['name'] = name;
    data['imgPath'] = imgPath;
    data['isActive'] = isActive;
    data['chatDetailId'] = chatDetailId;
    return data;
  }

  @override
  String toString() {
    return 'ListCommentors(likes: $likes, comment: $comment, name: $name, imgPath: $imgPath, isActive: $isActive, chatDetailId: $chatDetailId)';
  }
}

class ChatPoster {
  int? chatId;
  int? fileId;
  String? name;
  String? imgPath;
  bool? isActive;
  List<String>? filename;
  String? text;
  int? savedId;

  ChatPoster({
    this.chatId,
    this.name,
    this.imgPath,
    this.isActive,
    this.filename,
    this.text,
    this.savedId,
    this.fileId,
  });

  ChatPoster.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    fileId = json['fileId'];
    name = json['name'];
    imgPath = json['imgPath'];
    isActive = json['isActive'];
    filename = json['filename'] != null
        ? jsonDecode(json['filename']).whereType<String>().toList()
        : [];
    text = json['text'];
    savedId = json['savedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['name'] = name;
    data['imgPath'] = imgPath;
    data['isActive'] = isActive;
    data['filename'] = filename;
    data['text'] = text;
    return data;
  }

  @override
  String toString() {
    return 'ChatPoster(chatId: $chatId, fileId: $fileId, name: $name, imgPath: $imgPath, isActive: $isActive, filename: $filename, text: $text, savedId: $savedId)';
  }
}
