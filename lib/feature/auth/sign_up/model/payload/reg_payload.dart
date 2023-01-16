class RegistrationPayload {
  String? accountType;
  String? address;
  String? email;
  String? fullName;
  String? password;
  String? phoneNumber;

  RegistrationPayload(
      {this.accountType,
      this.address,
      this.email,
      this.fullName,
      this.password,
      this.phoneNumber});

  RegistrationPayload.fromJson(Map<String, dynamic> json) {
    accountType = json['accountType'];
    address = json['address'];
    email = json['email'];
    fullName = json['fullName'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['accountType'] = accountType;
    data['address'] = address;
    data['email'] = email;
    data['fullName'] = fullName;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
