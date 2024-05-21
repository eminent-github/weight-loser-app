class RecentPaymentModel {
  int? id;
  int? packageId;
  String? userId;
  String? name;
  double? amount;
  double? discount;
  double? discountPrice;
  double? totalAmount;
  String? startDate;
  String? endDate;
  String? type;
  String? status;
  int? duration;

  RecentPaymentModel(
      {this.id,
      this.packageId,
      this.userId,
      this.name,
      this.amount,
      this.discount,
      this.discountPrice,
      this.totalAmount,
      this.startDate,
      this.endDate,
      this.type,
      this.status,
      this.duration});

  RecentPaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'];
    userId = json['userId'];
    name = json['name'];
    amount = json['amount'];
    discount = json['discount'];
    discountPrice = json['discountPrice'];
    totalAmount = json['totalAmount'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    type = json['type'];
    status = json['status'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['packageId'] = packageId;
    data['userId'] = userId;
    data['name'] = name;
    data['amount'] = amount;
    data['discount'] = discount;
    data['discountPrice'] = discountPrice;
    data['totalAmount'] = totalAmount;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['type'] = type;
    data['status'] = status;
    data['duration'] = duration;
    return data;
  }
}
