import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class ReservationData {
  Crud crud;

  ReservationData(this.crud);
  getdata(String id) async {
    var response =
        await crud.postData(AppLink.viewreservation, {"user_id": id});
    return response.fold((l) => l, (r) => r);
  }
}
