class XGuestModel {
  String guestId;
  String guestName;
  String guestPhone;
  String guestGender;
  bool guestIsDeleted;
  List<BookingPeriod> bookingPeriod;
  XGuestModel({
    required this.guestId,
    required this.guestName,
    required this.guestPhone,
    required this.guestGender,
    required this.guestIsDeleted,
    required this.bookingPeriod,
  });

  factory XGuestModel.fromAPI({required Map<String, dynamic> data}) {
    List<BookingPeriod> temp = [];
    Iterable iterable = data["bookingPeriod"] ?? [];

    for (var element in iterable) {
      BookingPeriod eachPeriod = BookingPeriod(
          remark: element["remark"].toString(),
          startDate: DateTime.tryParse(element["startDate"].toString()) ??
              DateTime(2024, 9, 10),
          dueDate: DateTime.tryParse(element["dueDate"].toString()) ??
              DateTime(2014, 9, 10),
          period: int.tryParse(element["period"].toString()) ?? -1,
          seater: int.tryParse(element["seater"].toString()) ?? -1,
          price: double.tryParse(element["price"].toString()) ?? -1,
          status: element["status"].toString());
      temp.add(eachPeriod);
    }
    return XGuestModel(
      guestId: data["id"].toString(),
      guestName: data["name"].toString(),
      guestPhone: data["phone"].toString(),
      guestGender: data["gender"].toString(),
      guestIsDeleted: bool.tryParse(data["isDeleted"].toString()) ?? false,
      bookingPeriod: temp,
    );
  }
}

class BookingPeriod {
  String remark;
  DateTime startDate;
  DateTime dueDate;
  int period;
  int seater;
  double price;
  String status;
  BookingPeriod(
      {required this.remark,
      required this.startDate,
      required this.dueDate,
      required this.period,
      required this.seater,
      required this.price,
      required this.status});
}