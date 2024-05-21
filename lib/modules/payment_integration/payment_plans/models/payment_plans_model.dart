class PaymentPlansModel {
  int? discount;
  User? user;
  List<PackagesList>? packagesList;
  ResponseDto? responseDto;

  PaymentPlansModel(
      {this.discount, this.user, this.packagesList, this.responseDto});

  PaymentPlansModel.fromJson(Map<String, dynamic> json) {
    discount = json['discount'].toInt();
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['packagesList'] != null) {
      packagesList = <PackagesList>[];
      json['packagesList'].forEach((v) {
        packagesList!.add(PackagesList.fromJson(v));
      });
    }
    responseDto = json['responseDto'] != null
        ? ResponseDto.fromJson(json['responseDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount'] = discount;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (packagesList != null) {
      data['packagesList'] = packagesList!.map((v) => v.toJson()).toList();
    }
    if (responseDto != null) {
      data['responseDto'] = responseDto!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class PackagesList {
  int? id;
  String? title;
  String? description;
  double? price;
  int? duration;
  double? discountPrice;
  double? discountPercent;
  String? createdAt;

  PackagesList(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.duration,
      this.discountPrice,
      this.discountPercent,
      // this.customerPackages,
      this.createdAt});

  PackagesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    // if (json['customerPackages'] != null) {
    //   customerPackages = <Null>[];
    //   json['customerPackages'].forEach((v) {
    //     customerPackages!.add(Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    discountPrice = json['discountPrice'];
    discountPercent = json['discountPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['duration'] = duration;
    // if (customerPackages != null) {
    //   data['customerPackages'] =
    //       customerPackages!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = createdAt;
    return data;
  }
}

class ResponseDto {
  bool? status;
  String? message;
  int? id;
  String? userId;
  Null token;

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
