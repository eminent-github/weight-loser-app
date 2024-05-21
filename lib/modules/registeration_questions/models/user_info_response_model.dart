class UserInfoResponseModel {
  dynamic userDto;
  dynamic userDtoList;
  ResponseDto? responseDto;
  dynamic userTokens;

  UserInfoResponseModel(
      {this.userDto, this.userDtoList, this.responseDto, this.userTokens});

  UserInfoResponseModel.fromJson(Map<String, dynamic> json) {
    userDto = json['userDto'];
    userDtoList = json['userDtoList'];
    responseDto = json['responseDto'] != null
        ? ResponseDto.fromJson(json['responseDto'])
        : null;
    userTokens = json['userTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userDto'] = userDto;
    data['userDtoList'] = userDtoList;
    if (responseDto != null) {
      data['responseDto'] = responseDto!.toJson();
    }
    data['userTokens'] = userTokens;
    return data;
  }
}

class ResponseDto {
  bool? status;
  String? message;
  int? id;
  String? userId;
  dynamic token;

  ResponseDto({this.status, this.message, this.id, this.userId, this.token});

  ResponseDto.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    userId = json['userId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['id'] = id;
    data['userId'] = userId;
    data['token'] = token;
    return data;
  }
}
