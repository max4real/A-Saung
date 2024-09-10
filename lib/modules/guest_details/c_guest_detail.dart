import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/models/m_detail_model.dart';
import 'package:a_saung/services/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestDetailController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<DetailModel?> guestDetail = ValueNotifier(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async {
    fetchGuest();
  }

  Future<void> fetchGuest() async {
    String url =
        "${ApiEndPoint.baseUrl}${ApiEndPoint.endpointGuest}/${dataController.guestID}";
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    xFetching.value = true;
    Response response = await client.get(url);
    xFetching.value = false;
    if (response.isOk) {
      Map<String, dynamic> rawData = response.body["_data"] ?? {};
      DetailModel guestModel = DetailModel.fromAPI(data: rawData);
      guestDetail.value = guestModel;
    } else {
      Get.snackbar("Error", "Can't get profile data right now.");
    }
  }
}
