import 'package:a_saung/models/m_guest_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // ValueNotifier<bool> xFetching = ValueNotifier(false);
  // ValueNotifier<List<GuestModel>> guestList = ValueNotifier([]);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> initLoad() async {

  }

  // Future<void> fetchGuest() async {
  //   String url = ApiEndPoint.baseUrl + ApiEndPoint.endpointGuest;

  //   GetConnect client = GetConnect(timeout: Duration(seconds: 20));
  //   xFetching.value = true;
  //   final Response response = await client.get(url);
  //   xFetching.value = false;
  //   if (response.statusCode == 200) {
  //     Iterable iterable = response.body["_data"] ?? [];
  //     List<GuestModel> temp = [];
  //     for (var element in iterable) {
  //       GuestModel data = GuestModel.fromAPI(data: element);
  //       temp.add(data);
  //     }
  //     guestList.value = temp;

  //     for (var element in guestList.value) {
  //       print(element.guestName);
  //       print(element.guestPhone);
  //       print(element.guestGender);
  //       print("Booking Period__________");
  //       List<BookingPeriod> temp = element.bookingPeriod;
  //       for (var e in temp) {
  //         print(e.startDate);
  //         print(e.dueDate);
  //         print(e.period);
  //         print(e.remark);
  //         print(e.price);
  //       }
  //       print("----------------------------------");
  //     }
  //   } else {
  //     print("Wrong Status");
  //   }
  // }
}
