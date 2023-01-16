class DeviceFCMModel {
  String? deviceModel;
  String? deviceToken;
  String? userId;

  DeviceFCMModel({this.deviceModel, this.deviceToken, this.userId});

  DeviceFCMModel.fromJson(Map<String, dynamic> json) {
    deviceModel = json['deviceModel'];
    deviceToken = json['deviceToken'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceModel'] = deviceModel;
    data['deviceToken'] = deviceToken;
    data['userId'] = userId;
    return data;
  }
}
