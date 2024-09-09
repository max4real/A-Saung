class GuestModel {
  String guestId;
  String guestName;
  String guestPhone;
  String guestGender;
  DateTime guestStartDate;
  DateTime guestEndDate;
  GuestModel({
    required this.guestId,
    required this.guestName,
    required this.guestPhone,
    required this.guestGender,
    required this.guestStartDate,
    required this.guestEndDate,
  });
  factory GuestModel.fromAPI({required Map<String, dynamic> data}) {
    return GuestModel(
        guestId: data["id"].toString(),
        guestName: data["name"].toString(),
        guestPhone: data["phone"].toString(),
        guestGender: data["gender"].toString(),
        guestStartDate:
            DateTime.tryParse(data["stratDate"].toString()) ?? DateTime.now(),
        guestEndDate:
            DateTime.tryParse(data["dueDate"].toString()) ?? DateTime.now());
  }
}
// "_data": [
//     {
//       "id": "09338704-5fa6-495e-8f84-9936bb7aac29",
//       "name": "Ko Ko Soe",
//       "phone": "+959789786123",
//       "gender": "M",
//       "stratDate": "2024-09-30T09:00:00.000Z",
//       "dueDate": "2024-12-30T09:00:00.000Z"
//     },