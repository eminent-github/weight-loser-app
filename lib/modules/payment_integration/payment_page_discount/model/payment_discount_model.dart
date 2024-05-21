class PaymentDiscountModel {
  double? discount;
  User? user;
  Packages? packages;

  PaymentDiscountModel({this.discount, this.user, this.packages});

  PaymentDiscountModel.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    packages =
        json['packages'] != null ? Packages.fromJson(json['packages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount'] = discount;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (packages != null) {
      data['packages'] = packages!.toJson();
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

class Packages {
  int? id;
  String? title;
  String? description;
  double? price;
  int? duration;
  double? discountPrice;
  double? discountPercent;
  String? createdAt;

  Packages(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.duration,
      this.discountPrice,
      this.discountPercent,
      this.createdAt});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
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
    data['createdAt'] = createdAt;
    data['discountPrice'] = discountPrice;
    data['discountPercent'] = discountPercent;
    return data;
  }
}
