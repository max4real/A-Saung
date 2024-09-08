import 'package:flutter/material.dart';
import 'package:get/get.dart';
void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
class DataController extends GetxController {
  static const double priceRate = 60000;
}
