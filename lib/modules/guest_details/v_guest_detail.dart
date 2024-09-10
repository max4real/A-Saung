import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/modules/guest_details/c_guest_detail.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GuestDetailPage extends StatelessWidget {
  const GuestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    GuestDetailController controller = Get.put(GuestDetailController());
    ThemeController themeController = Get.find();
    return Scaffold(
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
                    return const Center(child: Text("No Data Yet!"));
                  } else {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).viewPadding.top),
                            left: 15,
                            right: 15),
                        child: Column(
                          children: [
                            SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
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
                                            Get.snackbar("Sorry",
                                                "This feature is not availabel right now.");
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
                            Expanded(
                              child: Column(
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
                                                Get.snackbar("Sorry",
                                                    "This feature is not availabel right now.");
                                                Get.close(1);
                                              },
                                              child: const Icon(Iconsax.call,
                                                  size: 20),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.snackbar("Sorry",
                                                    "This feature is not availabel right now.");
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
                                          onPressed: () {},
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
                              ),
                            )
                          ],
                        ));
                  }
                },
              );
            }
          },
        )));
  }
}
