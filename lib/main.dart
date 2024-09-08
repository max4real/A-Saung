import 'package:a_saung/modules/main/v_main_page.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: false,
    ),
    home:const MainPage(),
  ));
  Get.put(ThemeController());
}
