import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/models/m_guest_model.dart';
import 'package:a_saung/modules/guest_details/v_guest_detail.dart';
import 'package:a_saung/modules/guest_list/c_guest_list.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class GuestListPage extends StatelessWidget {
  const GuestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    GuestListController controller = Get.put(GuestListController());
    ThemeController themeController = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: const Text('အဆောင်သူ/သား စာရင်း',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          backgroundColor: themeController.secondary,
        ),
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: controller.xFetching,
          builder: (context, value, child) {
            if (value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () {
                  return controller.fetchGuest();
                },
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 18,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextField(
                                controller: controller.txtSearch,
                                onTapOutside: (event) {
                                  dismissKeyboard();
                                },
                                onChanged: (value) {
                                  controller.searchGuest();
                                },
                                decoration: InputDecoration(
                                    hintText: "ရှာဖွေမည်",
                                    hintStyle: const TextStyle(fontSize: 14),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.clearSearchBar();
                                        },
                                        icon: const Icon(Icons.clear))),
                              ),
                            ),
                            const Spacer(),
                            ValueListenableBuilder(
                              valueListenable: controller.genderRadio,
                              builder: (context, value, child) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: IconButton(
                                          onPressed: () {
                                            controller.checkMaleRadio();
                                          },
                                          icon: Icon(
                                            Iconsax.man,
                                            size: 23,
                                            color: (value == 1)
                                                ? Colors.green
                                                : Colors.grey,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: IconButton(
                                          onPressed: () {
                                            controller.checkFemaleRadio();
                                          },
                                          icon: Icon(
                                            Iconsax.woman,
                                            size: 23,
                                            color: (value == 2)
                                                ? Colors.green
                                                : Colors.grey,
                                          )),
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        )),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: makeTable(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        )));
  }

  Widget makeTable() {
    GuestListController controller = Get.find();

    return ValueListenableBuilder(
      valueListenable: controller.guestListFiltered,
      builder: (context, value, child) {
        return DataTable(
            showBottomBorder: true,
            showCheckboxColumn: false,
            dataRowHeight: 65,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'နာမည်',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ကျား/မ',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ရက်',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: getData());
      },
    );
  }

  List<DataRow> getData() {
    GuestListController controller = Get.find();
    DataController dataController = Get.find();
    List<DataRow> tempDataRow = [];
    List<GuestModel> data = controller.guestListFiltered.value;

    for (var element in data) {
      DataRow dataRow = DataRow(
        cells: [
          DataCell(SizedBox(
              child: Text(
            element.guestName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ))),
          DataCell(SizedBox(
              width: 45,
              child: Center(
                  child: Text(
                (element.guestGender == "M") ? "ကျား" : "မ",
                style: const TextStyle(fontSize: 12),
              )))),
          DataCell(SizedBox(
            width: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text(
                //     "${element.guestStartDate.day}-${element.guestStartDate.month}-${element.guestStartDate.year}"),
                Text(
                  DateFormat.yMMMd().format(element.guestStartDate),
                  style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                ),
                const Divider(),
                // Text(
                //   "${element.guestEndDate.day}-${element.guestEndDate.month}-${element.guestEndDate.year}",
                //   style: const TextStyle(color: Colors.redAccent),
                // ),
                Text(
                  DateFormat.yMMMd().format(element.guestEndDate),
                  style:  TextStyle(color: Colors.redAccent, fontSize: 13,fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
        onSelectChanged: (newValue) {
          dataController.guestID = element.guestId;
          Get.to(() => const GuestDetailPage());
        },
      );
      tempDataRow.add(dataRow);
    }
    return tempDataRow;
  }
}
