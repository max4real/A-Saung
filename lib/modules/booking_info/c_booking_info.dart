import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/models/m_booking_info.dart';
import 'package:a_saung/services/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingInfoController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<List<BookingInfoModel>> bookingInfoList = ValueNotifier([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onInitLoad();
  }

  Future<void> onInitLoad() async {
    fetchBookingInfo();
  }

  Future<void> fetchBookingInfo() async {
    String url =
        "${ApiEndPoint.baseUrl}${ApiEndPoint.endpointGuest}/${dataController.guestID}/booking";

    xFetching.value = true;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    final response = await client.get(url);
    xFetching.value = false;
    if (response.isOk) {
      Iterable iterable = response.body["_data"] ?? [];
      List<BookingInfoModel> temp = [];
      for (var element in iterable) {
        BookingInfoModel rawData = BookingInfoModel.fromAPI(data: element);
        temp.add(rawData);
      }
      bookingInfoList.value = temp;
    } else {
      Get.snackbar("Error", "Something Went Wrong");
    }
  }
}
