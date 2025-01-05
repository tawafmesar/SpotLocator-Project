

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






}