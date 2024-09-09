import 'package:a_saung/models/m_guest_model.dart';
import 'package:a_saung/services/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestListController extends GetxController {
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<int> genderRadio = ValueNotifier(0);
  ValueNotifier<List<GuestModel>> guestList = ValueNotifier([]);
  ValueNotifier<List<GuestModel>> guestListFiltered = ValueNotifier([]);
  TextEditingController txtSearch = TextEditingController(text: "");

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
    genderRadio.value = 0;
    txtSearch.clear();
    String url = ApiEndPoint.baseUrl + ApiEndPoint.endpointGuest;

    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    xFetching.value = true;
    final Response response = await client.get(url);
    xFetching.value = false;
    if (response.isOk) {
      Iterable iterable = response.body["_data"] ?? [];
      List<GuestModel> temp = [];
      for (var element in iterable) {
        GuestModel data = GuestModel.fromAPI(data: element);
        temp.add(data);
      }
      guestList.value = temp;
      guestListFiltered.value = guestList.value;
    } else {
      Get.snackbar("Error", "Something Wrong");
    }
  }

  void checkMaleRadio() {
    if (genderRadio.value == 1) {
      genderRadio.value = 0;
      searchGuest();
    } else {
      genderRadio.value = 1;
      filterByGender("M");
    }
  }

  void checkFemaleRadio() {
    if (genderRadio.value == 2) {
      genderRadio.value = 0;
      searchGuest();
    } else {
      genderRadio.value = 2;
      filterByGender("F");
    }
  }

  void searchGuest() {
    if (genderRadio.value != 0) {
      genderRadio.value = 0;
    }
    if (txtSearch.text.isNotEmpty) {
      filterByName();
    } else {
      guestListFiltered.value = guestList.value;
    }
  }

  void clearSearchBar() {
    txtSearch.clear();
    // checkFemaleRadio();
    // checkMaleRadio();
    switch (genderRadio.value) {
      case 0:
        filterByName();
      case 1:
        filterByGender("M");
      case 2:
        filterByGender("F");
    }
  }

  void filterByGender(String g) {
    List<GuestModel> temp = [];
    temp = guestList.value.where((test) {
      return test.guestGender.contains(g) &&
          test.guestName.isCaseInsensitiveContains(txtSearch.text);
    }).toList();
    guestListFiltered.value = temp;
  }

  void filterByName() {
    List<GuestModel> temp = [];
    temp = guestList.value.where((test) {
      return test.guestName.isCaseInsensitiveContains(txtSearch.text);
    }).toList();
    guestListFiltered.value = temp;
  }

  // bool isAcenSort = true;
  // void sortName() {
  //   List<GuestModel> temp = [];
  //   if (isAcenSort) {
  //     guestListFiltered.value.sort((a, b) {
  //       return a.guestName.compareTo(b.guestName);
  //     });
  //   } else {
  //     guestListFiltered.value.sort((a, b) {
  //       return b.guestName.compareTo(a.guestName);
  //     });
  //   }
  //   isAcenSort = !isAcenSort;
  // }
}
