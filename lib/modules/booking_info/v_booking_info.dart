import 'package:a_saung/modules/booking_info/c_booking_info.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingInfoPage extends StatelessWidget {
  const BookingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    BookingInfoController controller = Get.put(BookingInfoController());
    ThemeController themeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('သက်တမ်းတိုးစာရင်း',
            style: TextStyle(fontSize: 16, color: Colors.white)),
        backgroundColor: themeController.secondary,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: controller.xFetching,
          builder: (context, value, child) {
            if (value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return RefreshIndicator(
                onRefresh: () {
                  return controller.fetchBookingInfo();
                },
                child: ValueListenableBuilder(
                  valueListenable: controller.bookingInfoList,
                  builder: (context, value, child) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 10 / 7),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final each = value[index];
                        return Card(
                          color: const Color.fromARGB(255, 223, 225, 230)
                              .withOpacity(1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 30,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "စတင်သည့်နေ့",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        // "${each.bokStartDate.day}-${each.bokStartDate.month}-${each.bokStartDate.year}",
                                        DateFormat.yMMMd().format(
                                                    each.bokStartDate),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "ရက်ချိန်းနေ့",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        // "${each.bokDueDate.day}-${each.bokDueDate.month}-${each.bokDueDate.year}",
                                        DateFormat.yMMMd().format(
                                                    each.bokDueDate),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "စုစုပေါင်းလ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        "${each.bokPeriod} လ",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "ဦးရေ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        each.bokSeater.toString(),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "စုစုပေါင်းငွေ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        "${each.bokAmount} ကျပ်",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
