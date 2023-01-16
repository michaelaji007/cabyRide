class TripHistoryModel {
  String? fromLocName;
  String? toLocName;
  String? driverName;
  String? totalTimeTaken;
  num? amountPaid;

  TripHistoryModel(
      {this.fromLocName,
      this.toLocName,
      this.driverName,
      this.totalTimeTaken,
      this.amountPaid});

  TripHistoryModel.fromJson(Map<String, dynamic> json) {
    fromLocName = json['fromLocName'];
    toLocName = json['toLocName'];
    driverName = json['driverName'];
    totalTimeTaken = json['totalTimeTaken'];
    amountPaid = json['amountPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromLocName'] = fromLocName;
    data['toLocName'] = toLocName;
    data['driverName'] = driverName;
    data['totalTimeTaken'] = totalTimeTaken;
    data['amountPaid'] = amountPaid;
    return data;
  }
}
