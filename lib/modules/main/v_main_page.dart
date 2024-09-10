import 'package:a_saung/modules/due_list/v_due_list.dart';
import 'package:a_saung/modules/guest_list/v_guest_list.dart';
import 'package:a_saung/modules/guest_register/v_guest_register.dart';
import 'package:a_saung/modules/main/c_mian.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    ThemeController themeController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: themeController.background,
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          elevation: 0,
          height: 65,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) {
            controller.selectedIndex.value = value;
          },
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.user_add), label: "ADD"),
            NavigationDestination(
                icon: Icon(Iconsax.search_normal), label: "SEARCH"),
            NavigationDestination(icon: Icon(Iconsax.calendar), label: "DUE"),
          ],
        );
      }),
      body: Obx(() {
        return shownePage();
      }),
    );
  }

  Widget shownePage() {
    MainController controller = Get.find();
    switch (controller.selectedIndex.value) {
      case 0:
        return GuestRegisterPage();
      case 1:
        return const GuestListPage();
      case 2:
        return const DueListPage();
      default:
        return GuestRegisterPage();
    }
  }
}
