import 'package:a_saung/models/m_due_day_model.dart';

class DetailModel extends DueDayModel {
  int spendAmount;
  int totalMonth;
  DetailModel(
      {required super.guestId,
      required super.guestName,
      required super.guestPhone,
      required super.guestGender,
      required super.guestStartDate,
      required super.guestEndDate,
      required super.dueDays,
      required this.spendAmount,
      required this.totalMonth});
  factory DetailModel.fromAPI({required Map<String, dynamic> data}) {
    return DetailModel(
        guestId: data["id"].toString(),
        guestName: data["name"].toString(),
        guestPhone: data["phone"].toString(),
        guestGender: data["gender"].toString(),
        guestStartDate:
            DateTime.tryParse(data["stratDate"].toString()) ?? DateTime.now(),
        guestEndDate:
            DateTime.tryParse(data["dueDate"].toString()) ?? DateTime.now(),
        dueDays: int.tryParse(data["day"].toString()) ?? -1,
        spendAmount: int.tryParse(data["spendAmount"].toString()) ?? -1,
        totalMonth: int.tryParse(data["totalMonth"].toString()) ?? -1);
  }
}
// {
//   "_data": {
//     "id": "0da8b217-8721-4af9-a3fd-ee3e76fc606f",
//     "name": "test 2",
//     "phone": "+959989989989",
//     "gender": "F",
//     "stratDate": "2024-08-10T09:00:00.000Z",
//     "dueDate": "2024-11-10T09:08:36.647Z",
//     "day": 0,
//     "spendAmount": 180000,
//     "totalMonth": 3
//   },
//   "_metadata": {
//     "message": "Guest's profile successfully fetched.",
//     "statusCode": 200
//   }
// }