import 'package:a_saung/services/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestRegisterController extends GetxController {
  ValueNotifier<bool> xFecthing = ValueNotifier(false);
  ValueNotifier<bool> xValidName = ValueNotifier(false);
  ValueNotifier<bool> xValidPhone = ValueNotifier(false);
  ValueNotifier<bool> xValidPeriod = ValueNotifier(true);
  ValueNotifier<bool> xValidSeater = ValueNotifier(true);
  ValueNotifier<bool> xValidAmount = ValueNotifier(true);

  TextEditingController name = TextEditingController(text: "");
  TextEditingController phone = TextEditingController(text: "");
  TextEditingController period = TextEditingController(text: "1");
  TextEditingController seater = TextEditingController(text: "1");
  TextEditingController amount = TextEditingController(text: "60000");
  ValueNotifier<DateTime> startDate = ValueNotifier(DateTime.now());

  String countryCode = "+959";
  String phonePattern =
      r'^\+959[0-9]{7,9}$'; // start with +959 follow by 6 to 9 digits

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
    }
  }

  Future<void> postGuest() async {
    xFecthing.value = true;
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    String url = ApiEndPoint.baseUrl + ApiEndPoint.endpointGuest;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    String sDate =
        "${startDate.value.year}-${startDate.value.month}-${startDate.value.day}";
    String phoneNumber = countryCode + phone.text;

    final response = await client.post(url, {
      "name": name.text,
      "phone": phoneNumber,
      "gender": getGender(),
      "booking": {
        "remark": "hi",
        "startDate": sDate,
        "period": int.tryParse(period.text) ?? -1,
        "seater": int.tryParse(seater.text) ?? -1,
        "price": int.tryParse(amount.text) ?? -1
      }
    });

    xFecthing.value = false;
    Get.back();
    // String statusCode = response.body["_metadata"]["statusCode"].toString();
    if (response.isOk) {
      Get.snackbar("Success", "Guest Created Successfuly");
    } else {
      Get.snackbar("Error", "Something Went Wrong");
    }
  }

  ValueNotifier<int?> q1 = ValueNotifier(1); //1= male 2=female
  String getGender() {
    switch (q1.value) {
      case 1:
        return "M";
      case 2:
        return "F";
      default:
        return "M";
    }
  }

  void checkNameField() {
    if (name.text.isEmpty) {
      xValidName.value = false;
    } else if (name.text.isNotEmpty) {
      xValidName.value = true;
    }
  }

  void checkPhoneField() {
    if (phone.text.isEmpty) {
      xValidPhone.value = false;
    } else if (phone.text.isNotEmpty) {
      RegExp phoneRegex = RegExp(phonePattern);
      if (phoneRegex.hasMatch(countryCode + phone.text)) {
        xValidPhone.value = true;
      } else {
        xValidPhone.value = false;
      }
    }
  }

  void checkPeriodField() {
    if (period.text.isEmpty) {
      xValidPeriod.value = false;
    } else if (period.text.isNotEmpty) {
      xValidPeriod.value = true;
    }
  }

  void checkSeaterField() {
    if (seater.text.isEmpty) {
      xValidSeater.value = false;
    } else if (period.text.isNotEmpty) {
      xValidSeater.value = true;
    }
  }

  void checkAmountField() {
    if (amount.text.isEmpty) {
      xValidAmount.value = false;
    } else if (period.text.isNotEmpty) {
      xValidAmount.value = true;
    }
  }

  bool checkAllFeld() {
    if (xValidName.value &&
        xValidPhone.value &&
        xValidPeriod.value &&
        xValidSeater.value &&
        xValidAmount.value) {
      return true;
    } else {
      Get.snackbar("Error", "Please Insert All The Feield");
      return false;
    }
  }
}
