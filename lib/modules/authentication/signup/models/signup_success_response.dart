class SinUpSuccessResponse {
  dynamic userDto;
  dynamic userDtoList;
  ResponseDto? responseDto;
  UserTokens? userTokens;
  bool? isAccountActive;

  SinUpSuccessResponse({
    this.userDto,
    this.userDtoList,
    this.responseDto,
    this.userTokens,
    this.isAccountActive,
  });

  SinUpSuccessResponse.fromJson(Map<String, dynamic> json) {
    userDto = json['userDto'];
    userDtoList = json['userDtoList'];
    isAccountActive = json['isAccountActive'];
    responseDto = json['responseDto'] != null
        ? ResponseDto.fromJson(json['responseDto'])
        : null;
    userTokens = json['userTokens'] != null
        ? UserTokens.fromJson(json['userTokens'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userDto'] = userDto;
    data['userDtoList'] = userDtoList;
    data['isAccountActive'] = isAccountActive;
    if (responseDto != null) {
      data['responseDto'] = responseDto!.toJson();
    }
    if (userTokens != null) {
      data['userTokens'] = userTokens!.toJson();
    }
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

class UserTokens {
  String? token;
  String? userName;
  String? validaty;
  dynamic refreshToken;
  String? id;
  dynamic emailId;
  String? guidId;
  String? expiredTime;

  UserTokens(
      {this.token,
      this.userName,
      this.validaty,
      this.refreshToken,
      this.id,
      this.emailId,
      this.guidId,
      this.expiredTime});

  UserTokens.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userName = json['userName'];
    validaty = json['validaty'];
    refreshToken = json['refreshToken'];
    id = json['id'];
    emailId = json['emailId'];
    guidId = json['guidId'];
    expiredTime = json['expiredTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userName'] = userName;
    data['validaty'] = validaty;
    data['refreshToken'] = refreshToken;
    data['id'] = id;
    data['emailId'] = emailId;
    data['guidId'] = guidId;
    data['expiredTime'] = expiredTime;
    return data;
  }
}
