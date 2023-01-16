class RatingPayload {
  String? ratedBy;
  String? ratedFor;
  String? reason;
  String? tripId;
  double? value;

  RatingPayload(
      {this.ratedBy, this.ratedFor, this.reason, this.tripId, this.value});

  RatingPayload.fromJson(Map<String, dynamic> json) {
    ratedBy = json['ratedBy'];
    ratedFor = json['ratedFor'];
    reason = json['reason'];
    tripId = json['tripId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ratedBy'] = ratedBy;
    data['ratedFor'] = ratedFor;
    data['reason'] = reason;
    data['tripId'] = tripId;
    data['value'] = value;
    return data;
  }
}
