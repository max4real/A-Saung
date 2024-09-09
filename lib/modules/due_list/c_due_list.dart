import 'package:a_saung/models/m_due_day_model.dart';
import 'package:a_saung/services/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DueListController extends GetxController {
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<List<DueDayModel>> dueDayList = ValueNotifier([]);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async {
    fetchDueGuest();
  }

  Future<void> fetchDueGuest() async {
    String url = ApiEndPoint.baseUrl + ApiEndPoint.endpointWithinAWeek;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));

    xFetching.value = true;
    final response = await client.get(url);
    xFetching.value = false;
    if (response.isOk) {
      Iterable iterable = response.body["_data"] ?? [];
      List<DueDayModel> temp = [];
      for (var element in iterable) {
        DueDayModel rawData = DueDayModel.fromAPI(data: element);
        temp.add(rawData);
      }
      dueDayList.value = temp;
    } else {
      Get.snackbar("Error", "Something Wrong");
    }
  }
}
