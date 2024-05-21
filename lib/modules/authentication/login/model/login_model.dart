class LoginModel {
  ResponseDto? responseDto;
  UserTokens? userTokens;
  bool? isAccountActive;
  UserDto? userDto;

  LoginModel(
      {this.responseDto, this.userTokens, this.isAccountActive, this.userDto});

  LoginModel.fromJson(Map<String, dynamic> json) {
    responseDto = json['responseDto'] != null
        ? ResponseDto.fromJson(json['responseDto'])
        : null;
    userTokens = json['userTokens'] != null
        ? UserTokens.fromJson(json['userTokens'])
        : null;
    isAccountActive = json['isAccountActive'];
    userDto =
        json['userDto'] != null ? UserDto.fromJson(json['userDto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (responseDto != null) {
      data['responseDto'] = responseDto!.toJson();
    }
    if (userTokens != null) {
      data['userTokens'] = userTokens!.toJson();
    }
    data['isAccountActive'] = isAccountActive;
    if (userDto != null) {
      data['userDto'] = userDto!.toJson();
    }
    return data;
  }
}

class ResponseDto {
  bool? status;
  String? message;
  int? id;
  String? userId;
  String? token;

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

  String? id;

  String? guidId;
  String? expiredTime;

  UserTokens(
      {this.token,
      this.userName,
      this.validaty,
      this.id,
      this.guidId,
      this.expiredTime});

  UserTokens.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userName = json['userName'];
    validaty = json['validaty'];

    id = json['id'];

    guidId = json['guidId'];
    expiredTime = json['expiredTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userName'] = userName;
    data['validaty'] = validaty;
    data['id'] = id;

    data['guidId'] = guidId;
    data['expiredTime'] = expiredTime;
    return data;
  }
}

class UserDto {
  String? name;
  String? email;
  String? gender;
  double? weight;
  double? targetWeight;
  double? height;
  String? targetDate;
  String? weightUnit;

  UserDto({
    this.name,
    this.email,
    this.gender,
    this.weight,
    this.targetWeight,
    this.height,
    this.targetDate,
    this.weightUnit,
  });

  UserDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    weight = json['weight'];
    targetWeight = json['targetWeight'];
    height = json['height'];
    targetDate = json['targetDate'];
    weightUnit = json['weightUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['weight'] = weight;
    data['targetWeight'] = targetWeight;
    data['height'] = height;
    data['targetDate'] = targetDate;
    data['weightUnit'] = weightUnit;
    return data;
  }
}
