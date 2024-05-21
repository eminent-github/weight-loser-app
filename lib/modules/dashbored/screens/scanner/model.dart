class BarcodeSearchedFoodModel {
  String? code;
  Product? product;
  int? status;

  BarcodeSearchedFoodModel({this.code, this.product, this.status});

  BarcodeSearchedFoodModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  Nutriments? nutriments;
  String? brands;
  String? productName;
  String? image;

  Product({this.nutriments, this.brands, this.productName});

  Product.fromJson(Map<String, dynamic> json) {
    nutriments = json['nutriments'] != null
        ? Nutriments.fromJson(json['nutriments'])
        : null;

    brands = json['brands'];
    productName = json['product_name'];
    image = json['image_front_url'];
  }
}

class Nutriments {
  num? carbohydrates;
  num? energyKcal;
  num? fat;
  num? proteins;
  num? sodium;
  num? sugars;

  Nutriments({
    this.carbohydrates,
    this.energyKcal,
    this.fat,
    this.proteins,
    this.sodium,
    this.sugars,
  });

  Nutriments.fromJson(Map<String, dynamic> json) {
    carbohydrates = json['carbohydrates'];
    energyKcal = json['energy-kcal'];
    fat = json['fat'];
    proteins = json['proteins'];
    sodium = json['sodium'];
    sugars = json['sugars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carbohydrates'] = carbohydrates;
    data['energy-kcal'] = energyKcal;
    data['fat'] = fat;
    data['proteins'] = proteins;
    return data;
  }
}
