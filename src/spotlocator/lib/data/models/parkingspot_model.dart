class parkingspot_model {
  int? parkingspotId;
  String? spotName;
  int? deptId;
  int? spotStatus;
  String? latitude;
  String? longitude;
  String? deptName;
  String? deptShort;
  String? deptImage;

  parkingspot_model(
      {this.parkingspotId,
        this.spotName,
        this.deptId,
        this.spotStatus,
        this.latitude,
        this.longitude,
        this.deptName,
        this.deptShort,
        this.deptImage});

  parkingspot_model.fromJson(Map<String, dynamic> json) {
    parkingspotId = json['parkingspot_id'];
    spotName = json['spot_name'];
    deptId = json['dept_id'];
    spotStatus = json['spot_status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deptName = json['dept_name'];
    deptShort = json['dept_short'];
    deptImage = json['dept_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parkingspot_id'] = this.parkingspotId;
    data['spot_name'] = this.spotName;
    data['dept_id'] = this.deptId;
    data['spot_status'] = this.spotStatus;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['dept_name'] = this.deptName;
    data['dept_short'] = this.deptShort;
    data['dept_image'] = this.deptImage;
    return data;
  }
}