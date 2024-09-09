import 'package:a_saung/modules/due_list/v_due_list.dart';
import 'package:a_saung/modules/guest_list/v_guest_list.dart';
import 'package:a_saung/modules/guest_register/v_guest_register.dart';
import 'package:a_saung/modules/main/c_mian.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    ThemeController themeController = Get.find();
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 223, 172, 53),
      backgroundColor: const Color(0XFFF7F7F7),
      resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          Expanded(
            child: Container(
              child: shownePage(),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).viewPadding.bottom),
            ),
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        index = 0;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.person_add_alt_1,
                        size: 25,
                        color: (index == 0)
                            ? themeController.secondary
                            : Colors.white,
                      )),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        index = 1;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.person_search_rounded,
                        size: 25,
                        color: (index == 1)
                            ? themeController.secondary
                            : Colors.white,
                      )),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        index = 2;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.view_list_rounded,
                        size: 25,
                        color: (index == 2)
                            ? themeController.secondary
                            : Colors.white,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget shownePage() {
    switch (index) {
      case 0:
        return GuestRegisterPage();
      case 1:
        return const GuestListPage();
      case 2:
        // return const DueListPage();
        return const MyApp();
        
      default:
        return GuestRegisterPage();
    }
  }
}
