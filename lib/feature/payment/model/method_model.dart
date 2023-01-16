import 'card_model.dart';

class PaymentMethod {
  String? id;
  String? paymentMethodType;
  Payload? payload;
  bool? preferredPaymentMethod;

  PaymentMethod(
      {this.id,
      this.paymentMethodType,
      this.payload,
      this.preferredPaymentMethod});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethodType = json['paymentMethodType'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    preferredPaymentMethod = json['preferredPaymentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paymentMethodType'] = paymentMethodType;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['preferredPaymentMethod'] = preferredPaymentMethod;
    return data;
  }
}

class Payload {
  String? uuid;
  CardIssuer? cardType;
  String? last4;
  String? expiryMonth;
  String? expiryYear;
  String? bankName;
  String? dataRegistered;

  Payload(
      {this.uuid,
      this.cardType,
      this.last4,
      this.expiryMonth,
      this.expiryYear,
      this.bankName,
      this.dataRegistered});

  Payload.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    cardType = CardIssuer.values.firstWhere(
        (element) => element.code == json['cardType'].trim(),
        orElse: () => CardIssuer.visa);
    last4 = json['last4'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    bankName = json['bankName'];
    dataRegistered = json['dataRegistered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['cardType'] = cardType;
    data['last4'] = last4;
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    data['bankName'] = bankName;
    data['dataRegistered'] = dataRegistered;
    return data;
  }
}
