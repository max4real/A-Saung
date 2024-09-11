import 'package:a_saung/modules/booking_info/v_booking_info.dart';
import 'package:a_saung/modules/guest_details/c_guest_detail.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GuestDetailPage extends StatelessWidget {
  const GuestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    GuestDetailController controller = Get.put(GuestDetailController());
    ThemeController themeController = Get.find();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: themeController.background,
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: controller.xFetching,
          builder: (context, value, child) {
            if (value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ValueListenableBuilder(
                valueListenable: controller.guestDetail,
                builder: (context, value, child) {
                  if (value == null) {
                    return const Center(child: Text("Couldn't Find Profile"));
                  } else {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).viewPadding.top),
                            left: 15,
                            right: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Guest Profile",
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Get.defaultDialog(
                                                title: "Are you sure?",
                                                middleText:
                                                    "Do you really want to delete this account?\nYou will not be able to undo this action.",
                                                backgroundColor:
                                                    themeController.background,
                                                titleStyle: const TextStyle(
                                                    color: Colors.black),
                                                middleTextStyle:
                                                    const TextStyle(
                                                        color: Colors.black),
                                                cancel: SizedBox(
                                                  height: 40,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        controller
                                                            .deleteGuestProfile();
                                                      },
                                                      child: const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      )),
                                                ),
                                                confirm: SizedBox(
                                                  height: 40,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 245, 116, 116),
                                                  fontSize: 13),
                                            ))
                                      ],
                                    ),
                                  )),
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: const Color.fromARGB(
                                                  255, 85, 94, 228)
                                              .withOpacity(0.5),
                                          child: Text(
                                            value.guestGender == "M"
                                                ? "M"
                                                : "F",
                                            style:
                                                const TextStyle(fontSize: 40),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(value.guestName,
                                            style: const TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            value.guestPhone
                                                .replaceAll("+95", "0"),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            )),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.snackbar("Sorry",
                                                    "This feature is not availabel right now.");
                                              },
                                              child: const Icon(Iconsax.edit,
                                                  size: 20),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                launchUrlString(
                                                    "tel:${value.guestPhone.replaceAll("+95", "0")}");
                                              },
                                              child: const Icon(Iconsax.call,
                                                  size: 20),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.to(() =>
                                                    const BookingInfoPage());
                                              },
                                              child: const Icon(
                                                  Iconsax.information,
                                                  size: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 40,
                                      width: 150,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showSheet();
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("EXTEND"),
                                              SizedBox(width: 5),
                                              Icon(Iconsax.add_circle, size: 15)
                                            ],
                                          ))),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 320,
                                    width: double.infinity,
                                    child: ListView(children: [
                                      Card(
                                          margin: const EdgeInsets.all(3),
                                          elevation: 0.5,
                                          child: ListTile(
                                            leading: const Icon(Iconsax.people),
                                            title: const Text("Gender"),
                                            trailing: Text(
                                                value.guestGender == "M"
                                                    ? "Male"
                                                    : "Female",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          )),
                                      Card(
                                          margin: const EdgeInsets.all(3),
                                          elevation: 0.5,
                                          child: ListTile(
                                            leading:
                                                const Icon(Iconsax.calendar),
                                            title: const Text("Start Date"),
                                            trailing: Text(
                                                "${value.guestStartDate.day}-${value.guestStartDate.month}-${value.guestStartDate.year}",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          )),
                                      Card(
                                          margin: const EdgeInsets.all(3),
                                          elevation: 0.5,
                                          child: ListTile(
                                            leading: const Icon(
                                                Iconsax.calendar,
                                                color: Colors.redAccent),
                                            title: const Text("Due Date"),
                                            trailing: Text(
                                                "${value.guestEndDate.day}-${value.guestEndDate.month}-${value.guestEndDate.year}",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          )),
                                      Card(
                                          margin: const EdgeInsets.all(3),
                                          elevation: 0.5,
                                          child: ListTile(
                                            leading:
                                                const Icon(Iconsax.hashtag_1),
                                            title: const Text("Total Month"),
                                            trailing: Text(
                                                "${value.totalMonth} month(s)",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          )),
                                      Card(
                                          margin: const EdgeInsets.all(3),
                                          elevation: 0.5,
                                          child: ListTile(
                                            leading: const Icon(Iconsax.moneys),
                                            title: const Text("Money Spent"),
                                            trailing: Text(
                                                "${value.spendAmount} Ks",
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                          )),
                                    ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  }
                },
              );
            }
          },
        )));
  }

  void showSheet() {
    GuestDetailController controller = Get.find();
    ThemeController themeController = Get.find();
    Get.bottomSheet(
      isDismissible: false,
      Container(
        height: 350,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Card(
                      elevation: 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('Extend Month'),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              controller.removeMonth();
                            },
                            icon: const Icon(Iconsax.minus),
                          ),
                          ValueListenableBuilder(
                            valueListenable: controller.txtPeriod,
                            builder: (context, value, child) {
                              return Container(
                                width: 40,
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: themeController.secondary,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                controller.addMonth();
                              },
                              icon: const Icon(Iconsax.add)),
                          const SizedBox(width: 15)
                        ],
                      )),
                ),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Card(
                      elevation: 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('Seater'),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              controller.removeSeater();
                            },
                            icon: const Icon(Iconsax.minus),
                          ),
                          ValueListenableBuilder(
                            valueListenable: controller.txtSeater,
                            builder: (context, value, child) {
                              return Container(
                                width: 40,
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: themeController.secondary,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                controller.addSeater();
                              },
                              icon: const Icon(Iconsax.add)),
                          const SizedBox(width: 15)
                        ],
                      )),
                ),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Card(
                      elevation: 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('Amount'),
                          ),
                          const Spacer(),
                          SizedBox(
                              width: 130,
                              height: 45,
                              child: ValueListenableBuilder(
                                valueListenable: controller.xValidAmount,
                                builder: (context, value, child) {
                                  return TextField(
                                    controller: controller.txtAmount,
                                    // onTapOutside: (event) {
                                    //   dismissKeyboard();
                                    // },
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
                                          "Amount",
                                          style: TextStyle(fontSize: 14),
                                        )),
                                  );
                                },
                              )),
                          const SizedBox(width: 15)
                        ],
                      )),
                ),
                const Divider(),
                const SizedBox(height: 15),
                SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.checkAllFeilds();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SAVE"),
                            SizedBox(width: 5),
                            Icon(Iconsax.save_21, size: 15)
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
