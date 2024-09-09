import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/models/m_guest_model.dart';
import 'package:a_saung/modules/guest_list/c_guest_list.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestListPage extends StatelessWidget {
  const GuestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    GuestListController controller = Get.put(GuestListController());
    ThemeController themeController = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Guest Data'),
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
                                decoration: const InputDecoration(
                                    hintText: "Search",
                                    suffixIcon: Icon(Icons.search)),
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
                                            Icons.male,
                                            size: 30,
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
                                            Icons.female,
                                            size: 30,
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
            dataRowHeight: 65,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Gender',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Date',
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
    List<DataRow> tempDataRow = [];
    List<GuestModel> data = controller.guestListFiltered.value;

    for (var element in data) {
      DataRow dataRow = DataRow(cells: [
        DataCell(Text(element.guestName)),
        DataCell(Text((element.guestGender == "M") ? "Male" : "Female")),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
                "${element.guestStartDate.day}-${element.guestStartDate.month}-${element.guestStartDate.year}"),
            const Divider(),
            Text(
              "${element.guestEndDate.day}-${element.guestEndDate.month}-${element.guestEndDate.year}",
              style: const TextStyle(color: Colors.redAccent),
            ),
          ],
        )),
      ]);
      tempDataRow.add(dataRow);
    }
    return tempDataRow;
  }
}
