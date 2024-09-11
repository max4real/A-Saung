import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/modules/guest_register/c_guest_register.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class GuestRegisterPage extends StatelessWidget {
  GuestRegisterPage({super.key});
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    GuestRegisterController controller = Get.put(GuestRegisterController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "အသစ်ထည့်",
          style: TextStyle(fontSize: 15,color: Colors.white),
        ),
        backgroundColor: themeController.secondary,
      ),
      backgroundColor: themeController.background,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: (MediaQuery.of(context).viewPadding.top),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ValueListenableBuilder(
                        valueListenable: controller.xValidName,
                        builder: (context, xValidName, child) {
                          return TextField(
                            controller: controller.txtname,
                            keyboardType: TextInputType.name,
                            onTapOutside: (event) {
                              dismissKeyboard();
                            },
                            onChanged: (value) {
                              controller.checkNameField();
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide()),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: xValidName
                                            ? Colors.grey
                                            : const Color.fromARGB(
                                                255, 255, 132, 123))),
                                prefixIcon: Icon(Iconsax.user,
                                    color: themeController.secondary),
                                label: const Text(
                                  "နာမည်",
                                  style: TextStyle(fontSize: 14),
                                ),
                                hintStyle: const TextStyle(fontSize: 14)),
                          );
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ValueListenableBuilder(
                        valueListenable: controller.xValidPhone,
                        builder: (context, value, child) {
                          return TextField(
                            controller: controller.txtphone,
                            keyboardType: TextInputType.phone,
                            onTapOutside: (event) {
                              dismissKeyboard();
                            },
                            onChanged: (value) {
                              controller.checkPhoneField();
                            },
                            maxLength: 9,
                            inputFormatters: <TextInputFormatter>[
                              ///here
                              // FilteringTextInputFormatter.allow(
                              //     RegExp(r'^\d{0,9}$'))
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(0|[1-9][0-9]*)$'))
                            ],
                            decoration: InputDecoration(
                                prefixText: "+959",
                                border: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: value
                                            ? Colors.grey
                                            : const Color.fromARGB(
                                                255, 255, 132, 123))),
                                prefixIcon: Icon(Iconsax.call,
                                    color: themeController.secondary),
                                label: const Text(
                                  "ဖုန်းနံပါတ်",
                                  style: TextStyle(fontSize: 14),
                                )),
                          );
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  makeRadio(),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.startDate,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "စတင်နေသည့်ရက်:",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 89, 87, 87)),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.selectDate(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: themeController.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat.yMMMd().format(value),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Iconsax.calendar,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 130,
                          height: 50,
                          child: ValueListenableBuilder(
                            valueListenable: controller.xValidPeriod,
                            builder: (context, value, child) {
                              return TextField(
                                keyboardType: TextInputType.number,
                                controller: controller.txtPeriod,
                                onTapOutside: (e) {
                                  dismissKeyboard();
                                },
                                onChanged: (value) {
                                  controller.checkPeriodField();
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.add_circle,
                                    color: themeController.secondary,
                                    size: 20,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: value
                                              ? Colors.grey
                                              : const Color.fromARGB(
                                                  255, 255, 132, 123))),
                                  label: const Text("နေမည့်လ"),
                                ),
                              );
                            },
                          )),
                      SizedBox(
                          width: 130,
                          height: 50,
                          child: ValueListenableBuilder(
                            valueListenable: controller.xValidSeater,
                            builder: (context, value, child) {
                              return TextField(
                                keyboardType: TextInputType.number,
                                controller: controller.txtseater,
                                onTapOutside: (event) {
                                  dismissKeyboard();
                                },
                                onChanged: (value) {
                                  controller.checkSeaterField();
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.add_circle,
                                    color: themeController.secondary,
                                    size: 20,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: value
                                              ? Colors.grey
                                              : const Color.fromARGB(
                                                  255, 255, 132, 123))),
                                  label: const Text("ဦးရေ"),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ValueListenableBuilder(
                        valueListenable: controller.xValidAmount,
                        builder: (context, value, child) {
                          return TextField(
                            controller: controller.txtAmount,
                            onTapOutside: (event) {
                              dismissKeyboard();
                            },
                            onChanged: (value) {
                              controller.checkAmountField();
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: value
                                            ? Colors.grey
                                            : const Color.fromARGB(
                                                255, 255, 132, 123))),
                                prefixIcon: Icon(Iconsax.moneys,
                                    color: themeController.secondary),
                                label: const Text(
                                  "စုစုပေါင်းငွေ",
                                  style: TextStyle(fontSize: 14),
                                )),
                          );
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.checkAllFeld()) {
                        controller.postGuest();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeController.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 70),
                      child: const Text(
                        "ထည့်မည်",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makeRadio() {
    GuestRegisterController controller = Get.find();
    return ValueListenableBuilder(
      valueListenable: controller.q1,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: value,
                  activeColor: themeController.primary,
                  onChanged: (value) {
                    controller.q1.value = value;
                  },
                ),
                const Text("ကျား")
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: value,
                  activeColor: themeController.primary,
                  onChanged: (value) {
                    controller.q1.value = value;
                  },
                ),
                const Text("မ")
              ],
            ),
          ],
        );
      },
    );
  }
}