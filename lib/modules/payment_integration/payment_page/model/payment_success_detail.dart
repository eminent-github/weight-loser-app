class PaymentSuccessDetail {
  int? apiVersion;
  int? apiVersionMinor;
  PaymentMethodData? paymentMethodData;

  PaymentSuccessDetail(
      {this.apiVersion, this.apiVersionMinor, this.paymentMethodData});

  PaymentSuccessDetail.fromJson(Map<String, dynamic> json) {
    apiVersion = json['apiVersion'];
    apiVersionMinor = json['apiVersionMinor'];
    paymentMethodData = json['paymentMethodData'] != null
        ? PaymentMethodData.fromJson(json['paymentMethodData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apiVersion'] = apiVersion;
    data['apiVersionMinor'] = apiVersionMinor;
    if (paymentMethodData != null) {
      data['paymentMethodData'] = paymentMethodData!.toJson();
    }
    return data;
  }
}

class PaymentMethodData {
  String? description;
  Info? info;
  TokenizationData? tokenizationData;
  String? type;

  PaymentMethodData(
      {this.description, this.info, this.tokenizationData, this.type});

  PaymentMethodData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    tokenizationData = json['tokenizationData'] != null
        ? TokenizationData.fromJson(json['tokenizationData'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (tokenizationData != null) {
      data['tokenizationData'] = tokenizationData!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class Info {
  BillingAddress? billingAddress;
  String? cardDetails;
  String? cardNetwork;

  Info({this.billingAddress, this.cardDetails, this.cardNetwork});

  Info.fromJson(Map<String, dynamic> json) {
    billingAddress = json['billingAddress'] != null
        ? BillingAddress.fromJson(json['billingAddress'])
        : null;
    cardDetails = json['cardDetails'];
    cardNetwork = json['cardNetwork'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billingAddress != null) {
      data['billingAddress'] = billingAddress!.toJson();
    }
    data['cardDetails'] = cardDetails;
    data['cardNetwork'] = cardNetwork;
    return data;
  }
}

class BillingAddress {
  String? address1;
  String? address2;
  String? address3;
  String? administrativeArea;
  String? countryCode;
  String? locality;
  String? name;
  String? phoneNumber;
  String? postalCode;
  String? sortingCode;

  BillingAddress(
      {this.address1,
      this.address2,
      this.address3,
      this.administrativeArea,
      this.countryCode,
      this.locality,
      this.name,
      this.phoneNumber,
      this.postalCode,
      this.sortingCode});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    administrativeArea = json['administrativeArea'];
    countryCode = json['countryCode'];
    locality = json['locality'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    postalCode = json['postalCode'];
    sortingCode = json['sortingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    data['address3'] = address3;
    data['administrativeArea'] = administrativeArea;
    data['countryCode'] = countryCode;
    data['locality'] = locality;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['postalCode'] = postalCode;
    data['sortingCode'] = sortingCode;
    return data;
  }
}

class TokenizationData {
  String? token;
  String? type;

  TokenizationData({this.token, this.type});

  TokenizationData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['type'] = type;
    return data;
  }
}

class PostPaymentModel {
  int packageId;
  double amount;
  double discount;
  double discountPrice;
  double totalAmount;
  String status;
  int duration;

  PostPaymentModel(
      {required this.packageId,
      required this.amount,
      required this.discount,
      required this.discountPrice,
      required this.totalAmount,
      required this.status,
      required this.duration});

  @override
  String toString() {
    return 'packageId: $packageId, '
        'amount: $amount, '
        'discount: $discount, '
        'discountPrice: $discountPrice, '
        'totalAmount: $totalAmount, '
        'status: $status, '
        'duration: $duration';
  }
}
