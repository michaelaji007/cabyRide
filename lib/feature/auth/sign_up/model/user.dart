import '../../../../shared/models/base.dart';

class User extends BaseModel {
  String? accountType;
  String? address;
  String? dataRegistered;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? userId;

  User(
      {this.accountType,
      this.address,
      this.dataRegistered,
      this.email,
      this.fullName,
      this.phoneNumber,
      this.userId});

  User.fromJson(Map<String, dynamic> json) {
    accountType = json['accountType'];
    address = json['address'];
    dataRegistered = json['dataRegistered'];
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountType'] = accountType;
    data['address'] = address;
    data['dataRegistered'] = dataRegistered;
    data['email'] = email;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['userId'] = userId;
    return data;
  }
}
