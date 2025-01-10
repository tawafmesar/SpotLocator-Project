class reservation_model {
  int? reservationId;
  String? reservationDate;
  int? reservationStatus;
  String? parkingSpotName;
  String? latitude;
  String? longitude;
  String? departmentName;
  String? departmentShort;
  String? departmentImage;
  String? vehiclePlate;
  String? vehicleDesc;
  String? vehicleType;
  int? vehicleStatus;
  int? usersId;
  String? usersName;
  String? usersEmail;
  String? usersPhone;

  reservation_model(
      {this.reservationId,
      this.reservationDate,
      this.reservationStatus,
      this.parkingSpotName,
      this.latitude,
      this.longitude,
      this.departmentName,
      this.departmentShort,
      this.departmentImage,
      this.vehiclePlate,
      this.vehicleDesc,
      this.vehicleType,
      this.vehicleStatus,
      this.usersId,
      this.usersName,
      this.usersEmail,
      this.usersPhone});

  reservation_model.fromJson(Map<String, dynamic> json) {
    reservationId = json['reservation_id'];
    reservationDate = json['reservation_date'];
    reservationStatus = json['reservation_status'];
    parkingSpotName = json['parking_spot_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    departmentName = json['department_name'];
    departmentShort = json['department_short'];
    departmentImage = json['department_image'];
    vehiclePlate = json['vehicle_plate'];
    vehicleDesc = json['vehicle_desc'];
    vehicleType = json['vehicle_type'];
    vehicleStatus = json['vehicle_status'];
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservation_id'] = this.reservationId;
    data['reservation_date'] = this.reservationDate;
    data['reservation_status'] = this.reservationStatus;
    data['parking_spot_name'] = this.parkingSpotName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['department_name'] = this.departmentName;
    data['department_short'] = this.departmentShort;
    data['department_image'] = this.departmentImage;
    data['vehicle_plate'] = this.vehiclePlate;
    data['vehicle_desc'] = this.vehicleDesc;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_status'] = this.vehicleStatus;
    data['users_id'] = this.usersId;
    data['users_name'] = this.usersName;
    data['users_email'] = this.usersEmail;
    data['users_phone'] = this.usersPhone;
    return data;
  }
}
