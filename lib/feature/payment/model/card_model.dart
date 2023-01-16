import '../../../shared/utils/asset_images.dart';

enum CardIssuer { visa, master, verve, unknown, cash, addCard }

class CardModel {
  String? authorizationCode;
  String? authorizationEmail;
  String? bankName;
  CardIssuer? cardType;
  bool? isSelected;

  String? dataRegistered;
  String? expiryMonth;
  String? expiryYear;
  String? last4;
  String? riderId;
  String? signature;
  String? uuid;

  bool? get isCard {
    if (uuid != null) {
      return true;
    }
    return false;
  }

  CardModel(
      {this.authorizationCode,
      this.authorizationEmail,
      this.bankName,
      this.cardType,
      this.dataRegistered,
      this.expiryMonth,
      this.expiryYear,
      this.last4,
      this.riderId,
      this.signature,
      this.isSelected = false,
      this.uuid});

  CardModel.fromJson(Map<String, dynamic> json) {
    authorizationCode = json['authorizationCode'];
    authorizationEmail = json['authorizationEmail'];
    bankName = json['bankName'];
    cardType = CardIssuer.values.firstWhere(
        (element) => element.code == json['cardType'].trim(),
        orElse: () => CardIssuer.visa);
    dataRegistered = json['dataRegistered'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    last4 = json['last4'];
    riderId = json['riderId'];
    signature = json['signature'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorizationCode'] = authorizationCode;
    data['authorizationEmail'] = authorizationEmail;
    data['bankName'] = bankName;
    data['cardType'] = cardType;
    data['dataRegistered'] = dataRegistered;
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    data['last4'] = last4;
    data['riderId'] = riderId;
    data['signature'] = signature;
    data['uuid'] = uuid;
    return data;
  }
}

extension CardIssuerExt on CardIssuer {
  String get code {
    switch (this) {
      case CardIssuer.visa:
        return "visa ";
      case CardIssuer.master:
        return "mastercard";
      case CardIssuer.unknown:
        return "unknown";
      case CardIssuer.addCard:
        return "add";
      case CardIssuer.cash:
        return "cash";
      default:
        return "add";
    }
  }

  String get image {
    switch (this) {
      case CardIssuer.visa:
        return AssetResources.VISA;
      case CardIssuer.master:
        return AssetResources.MASTERCARD;
      case CardIssuer.unknown:
        return "";
      case CardIssuer.cash:
        return AssetResources.CARD;
      case CardIssuer.addCard:
        return AssetResources.ADD_CARD;
      default:
        return "";
    }
  }
}
