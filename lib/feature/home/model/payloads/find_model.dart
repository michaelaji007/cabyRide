class FindPayload {
  int? cityCode;
  double? latitude;
  double? longitude;
  int? stateCode;

  FindPayload({this.cityCode, this.latitude, this.longitude, this.stateCode});

  FindPayload.fromJson(Map<String, dynamic> json) {
    cityCode = json['cityCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    stateCode = json['stateCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityCode'] = this.cityCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['stateCode'] = this.stateCode;
    return data;
  }
}
