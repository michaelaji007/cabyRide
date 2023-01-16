class RequestModel {
  int? distanceInKm;
  int? durationInMinutes;
  String? estimatedPrice;
  String? id;

  RequestModel(
      {this.distanceInKm,
      this.durationInMinutes,
      this.estimatedPrice,
      this.id});

  RequestModel.fromJson(Map<String, dynamic> json) {
    distanceInKm = json['distanceInKm'];

    durationInMinutes = json['durationInMinutes'];
    estimatedPrice = json['estimatedPrice'].toStringAsFixed(0);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distanceInKm'] = this.distanceInKm;

    data['durationInMinutes'] = this.durationInMinutes;
    data['estimatedPrice'] = this.estimatedPrice;
    data['id'] = this.id;
    return data;
  }
}
