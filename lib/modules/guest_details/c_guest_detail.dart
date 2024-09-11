import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/models/m_detail_model.dart';
import 'package:a_saung/services/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestDetailController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<bool> xBooking = ValueNotifier(false);
  ValueNotifier<DetailModel?> guestDetail = ValueNotifier(null);

  ValueNotifier<int> txtPeriod = ValueNotifier(1);
  ValueNotifier<int> txtSeater = ValueNotifier(1);
  ValueNotifier<bool> xValidAmount = ValueNotifier(true);
  TextEditingController txtAmount =
      TextEditingController(text: priceRate.toString());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
    listenPeriodText();
    listenSeaterText();
    listenAmountTextField();
  }

  Future<void> initLoad() async {
    fetchGuest();
  }

  void listenPeriodText() {
    txtPeriod.addListener(() {
      int period = txtPeriod.value;
      int seater = txtSeater.value;
      txtAmount.text = (period * seater * priceRate).toString();
    });
  }

  void listenSeaterText() {
    txtSeater.addListener(() {
      int period = txtPeriod.value;
      int seater = txtSeater.value;
      txtAmount.text = (seater * period * priceRate).toString();
    });
  }

  void listenAmountTextField() {
    txtAmount.addListener(() {
      if (txtAmount.text.isEmpty) {
        xValidAmount.value = false;
      } else if (txtAmount.text.isNotEmpty) {
        xValidAmount.value = true;
      }
    });
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

  Future<void> fetchBookingExtend() async {
    String url =
        "${ApiEndPoint.baseUrl}${ApiEndPoint.endpointGuest}/${dataController.guestID}/extend-booking-period";
    xBooking.value = true;
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    Response response = await client.post(url, {
      "remark": "",
      "period": txtPeriod.value,
      "seater": txtSeater.value,
      "price": int.tryParse(txtAmount.text) ?? -1
    });
    xBooking.value = false;
    Get.back();
    if (response.isOk) {
      Get.back();
      Get.snackbar("Success", "Booking Extended Successfuly");
      fetchGuest();
      txtPeriod.value = 1;
      txtSeater.value = 1;
      txtAmount.text = priceRate.toString();
    } else {
      Get.snackbar("Error", "Something Went Wrong");
    }
  }

  Future<void> deleteGuestProfile() async {
    String url =
        "${ApiEndPoint.baseUrl}${ApiEndPoint.endpointGuest}/${dataController.guestID}";
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    final response = await client.delete(url);
    Get.back();
    if (response.isOk) {
      Get.back();
      Get.back();
      Get.snackbar("Message", "Profile Deleted Successfuly");
    } else {
      Get.snackbar("Error", "Something Went Wrong");
    }
  }

  void addMonth() {
    txtPeriod.value++;
  }

  void removeMonth() {
    if (txtPeriod.value > 1) {
      txtPeriod.value--;
    }
  }

  void addSeater() {
    txtSeater.value++;
  }

  void removeSeater() {
    if (txtSeater.value > 1) {
      txtSeater.value--;
    }
  }

  void checkAmountField() {
    if (txtAmount.text.isEmpty) {
      xValidAmount.value = false;
    } else if (txtAmount.text.isNotEmpty) {
      xValidAmount.value = true;
    }
  }

  void checkAllFeilds() {
    if (xValidAmount.value) {
      fetchBookingExtend();
    } else {
      Get.snackbar("Error", "Enter Amount");
    }
  }
}
