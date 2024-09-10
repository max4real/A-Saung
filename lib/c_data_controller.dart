import 'package:a_saung/models/m_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

const int priceRate = 60000;

class DataController extends GetxController {
  String guestID = "";
  late DetailModel guestDetailModel;
}
