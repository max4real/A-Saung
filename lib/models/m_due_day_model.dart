import 'package:a_saung/models/m_guest_model.dart';

class DueDayModel extends GuestModel {
  int dueDays;
  DueDayModel({
    required super.guestId,
    required super.guestName,
    required super.guestPhone,
    required super.guestGender,
    required super.guestStartDate,
    required super.guestEndDate,
    required this.dueDays,
  });
  factory DueDayModel.fromAPI({required Map<String, dynamic> data}) {
    return DueDayModel(
        guestId: data["id"].toString(),
        guestName: data["name"].toString(),
        guestPhone: data["phone"].toString(),
        guestGender: data["gender"].toString(),
        guestStartDate:
            DateTime.tryParse(data["stratDate"].toString()) ?? DateTime.now(),
        guestEndDate:
            DateTime.tryParse(data["dueDate"].toString()) ?? DateTime.now(),
        dueDays: int.tryParse(data["day"].toString()) ?? -1);
  }
}
