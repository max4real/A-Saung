class BookingInfoModel {
  String bokRemark;
  DateTime bokStartDate;
  DateTime bokDueDate;
  int bokPeriod;
  int bokSeater;
  int bokAmount;
  BookingInfoModel({
    required this.bokRemark,
    required this.bokStartDate,
    required this.bokDueDate,
    required this.bokPeriod,
    required this.bokSeater,
    required this.bokAmount,
  });

  factory BookingInfoModel.fromAPI({required Map<String, dynamic> data}) {
    return BookingInfoModel(
      bokRemark: data["remark"].toString(),
      bokStartDate:
          DateTime.tryParse(data["startDate"].toString()) ?? DateTime.now(),
      bokDueDate:
          DateTime.tryParse(data["dueDate"].toString()) ?? DateTime.now(),
      bokPeriod: int.tryParse(data["period"].toString()) ?? -1,
      bokSeater: int.tryParse(data["seater"].toString()) ?? -1,
      bokAmount: int.tryParse(data["price"].toString()) ?? -1,
    );
  }
}
//  {
//       "remark": "hi",
//       "startDate": "2024-09-12T09:00:00.000Z",
//       "dueDate": "2024-11-12T09:00:00.000Z",
//       "period": 2,
//       "seater": 2,
//       "price": 240000,
//       "status": "PAID"
//     },