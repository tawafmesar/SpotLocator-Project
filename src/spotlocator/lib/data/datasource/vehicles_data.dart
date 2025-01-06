

import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class VehiclesData {
  Crud crud;

  VehiclesData(this.crud);
  getdata(String id) async {
    var response = await crud.postData(AppLink.vehicleview, {
      "id" : id });
    return response.fold((l) => l, (r) => r);
  }



  removedata(String id) async {
    var response = await crud.postData(AppLink.vehicleremove, {
      "id" : id });
    return response.fold((l) => l, (r) => r);
  }

  activedata(String id, String user_id ) async {
    var response = await crud.postData(AppLink.vehicleactive, {
      "id" : id,
      "user_id" : user_id,
    });
    return response.fold((l) => l, (r) => r);
  }




  postdata(String plate_number ,String vehicle_desc ,String vehicle_type ,String vehicle_userid ) async {
    var response = await crud.postData(AppLink.vehicleAdd, {
      "plate_number" : plate_number ,
      "vehicle_desc" : vehicle_desc  ,
      "vehicle_type" : vehicle_type ,
      "vehicle_userid" : vehicle_userid  ,
    });
    return response.fold((l) => l, (r) => r);
  }


}