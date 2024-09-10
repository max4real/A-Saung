import 'package:flutter/material.dart';
import 'package:get/get.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

const int priceRate = 60000;

class DataController extends GetxController {}
