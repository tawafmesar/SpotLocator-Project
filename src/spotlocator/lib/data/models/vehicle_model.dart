class vehicle_model {
  int? vehicleId;
  String? plateNumber;
  String? vehicleDesc;
  String? vehicleType;
  int? vehicleUserid;
  int? vehicleStatus;

  vehicle_model(
      {this.vehicleId,
        this.plateNumber,
        this.vehicleDesc,
        this.vehicleType,
        this.vehicleUserid,
        this.vehicleStatus});

  vehicle_model.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicle_id'];
    plateNumber = json['plate_number'];
    vehicleDesc = json['vehicle_desc'];
    vehicleType = json['vehicle_type'];
    vehicleUserid = json['vehicle_userid'];
    vehicleStatus = json['vehicle_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_id'] = this.vehicleId;
    data['plate_number'] = this.plateNumber;
    data['vehicle_desc'] = this.vehicleDesc;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_userid'] = this.vehicleUserid;
    data['vehicle_status'] = this.vehicleStatus;
    return data;
  }
}
