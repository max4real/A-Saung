import 'package:a_saung/modules/guest_register/v_guest_register.dart';
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
  ValueNotifier<int?> q1 = ValueNotifier(1); //1= male 2=female

  TextEditingController txtname = TextEditingController(text: "");
  TextEditingController txtphone = TextEditingController(text: "");
  TextEditingController txtPeriod = TextEditingController(text: "1");
  TextEditingController txtseater = TextEditingController(text: "1");
  TextEditingController txtAmount = TextEditingController(text: "60000");
  ValueNotifier<DateTime> startDate = ValueNotifier(DateTime.now());

  String countryCode = "+959";
  String phonePattern =
      r'^\+959[0-9]{7,9}$'; // start with +959 follow by 6 to 9 digits
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenPeriodTextField();
    listenSeaterTextField();
  }

  void listenPeriodTextField() {
    txtPeriod.addListener(() {
      int? period = int.tryParse(txtPeriod.text);
      int? seater = int.tryParse(txtseater.text);
      if (period != null && seater != null) {
        txtAmount.text = (period * seater * 60000).toString();
      } else {
        txtAmount.text = "0";
      }
    });
  }

  void listenSeaterTextField() {
    txtseater.addListener(() {
      int? seater = int.tryParse(txtseater.text);
      int? period = int.tryParse(txtPeriod.text);
      if (seater != null && period != null) {
        txtAmount.text = (seater * period * 60000).toString();
      } else {
        txtAmount.text = "0";
      }
    });
  }

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
    String phoneNumber = countryCode + txtphone.text;

    final response = await client.post(url, {
      "name": txtname.text,
      "phone": phoneNumber,
      "gender": getGender(),
      "booking": {
        "remark": "hi",
        "startDate": sDate,
        "period": int.tryParse(txtPeriod.text) ?? -1,
        "seater": int.tryParse(txtseater.text) ?? -1,
        "price": int.tryParse(txtAmount.text) ?? -1
      }
    });

    xFecthing.value = false;
    Get.back();
    // String statusCode = response.body["_metadata"]["statusCode"].toString();
    if (response.isOk) {
      Get.snackbar("Success", "Guest Created Successfuly");
      txtname.text = "";
      txtphone.text = "";
      txtPeriod.text = "1";
      txtseater.text = "1";
      txtAmount.text = "60000";
      q1.value = 1;
      startDate.value = DateTime.now();
      xValidName.value = false;
      xValidPhone.value = false;
    } else {
      Get.snackbar("Error", "Something Went Wrong");
    }
  }

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
    if (txtname.text.isEmpty) {
      xValidName.value = false;
    } else if (txtname.text.isNotEmpty) {
      xValidName.value = true;
    }
  }

  void checkPhoneField() {
    if (txtphone.text.isEmpty) {
      xValidPhone.value = false;
    } else if (txtphone.text.isNotEmpty) {
      RegExp phoneRegex = RegExp(phonePattern);
      if (phoneRegex.hasMatch(countryCode + txtphone.text)) {
        xValidPhone.value = true;
      } else {
        xValidPhone.value = false;
      }
    }
  }

  void checkPeriodField() {
    if (txtPeriod.text.isEmpty) {
      xValidPeriod.value = false;
    } else if (txtPeriod.text.isNotEmpty) {
      xValidPeriod.value = true;
    }
  }

  void checkSeaterField() {
    if (txtseater.text.isEmpty) {
      xValidSeater.value = false;
    } else if (txtPeriod.text.isNotEmpty) {
      xValidSeater.value = true;
    }
  }

  void checkAmountField() {
    if (txtAmount.text.isEmpty) {
      xValidAmount.value = false;
    } else if (txtPeriod.text.isNotEmpty) {
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
