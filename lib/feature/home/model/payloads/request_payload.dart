class RequestPayload {
  From? from;
  String? fromName;
  From? to;
  String? toName;

  RequestPayload({this.from, this.fromName, this.to, this.toName});

  RequestPayload.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    fromName = json['fromName'];
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    toName = json['toName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    data['fromName'] = this.fromName;
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['toName'] = this.toName;
    return data;
  }
}

class From {
  double? latitude;
  double? longitude;

  From({this.latitude, this.longitude});

  From.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
