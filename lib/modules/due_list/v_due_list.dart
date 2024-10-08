import 'package:a_saung/c_data_controller.dart';
import 'package:a_saung/models/m_due_day_model.dart';
import 'package:a_saung/modules/due_list/c_due_list.dart';
import 'package:a_saung/modules/guest_details/v_guest_detail.dart';
import 'package:a_saung/services/c_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DueListPage extends StatelessWidget {
  const DueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    DueListController controller = Get.put(DueListController());
    ThemeController themeController = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: const Text('တစ်ပတ်အတွင်းရက်ချိန်းများ',
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
                  return controller.fetchDueGuest();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: makeTable(),
                ),
              );
            }
          },
        )));
  }

  Widget makeTable() {
    DueListController controller = Get.find();

    return ValueListenableBuilder(
      valueListenable: controller.dueDayList,
      builder: (context, value, child) {
        return DataTable(
            showBottomBorder: true,
            dataRowHeight: 65,
            showCheckboxColumn: false,
            columns: const <DataColumn>[
              DataColumn(
                label:  Expanded(
                  child: Text(
                    'နာမည်',
                    style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ဖုန်း',
                    style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ရက်ချိန်း',
                    style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
            rows: getData());
      },
    );
  }

  List<DataRow> getData() {
    DueListController controller = Get.find();
    DataController dataController = Get.find();
    List<DataRow> tempDataRow = [];
    List<DueDayModel> data = controller.dueDayList.value;

    for (var element in data) {
      DataRow dataRow = DataRow(
        cells: [
          DataCell(Text(element.guestName)),
          DataCell(Text(element.guestPhone.replaceAll("+95", "0"))),
          DataCell(SizedBox(
            width: 100,
            child: Text(
              controller.checkDay(element.dueDays),
              style: const TextStyle(color: Colors.redAccent),
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
