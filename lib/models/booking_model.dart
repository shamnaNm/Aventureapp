import 'package:cloud_firestore/cloud_firestore.dart';
class BookingModel {
  String? id;
  String? activityId;
  String? title;
  String? category;
  DateTime? date;
  String? time;
  int? tickets;
  String?eventer;
  var amountPaid;
  var eventManagerId;
  String?userid;
  int?status;
  BookingModel({
    this.id,
    this.status,
    this.eventer,
    this.eventManagerId,
    this.activityId,
    this.title,
    this.category,
    this.date,
    this.time,
    this.tickets,
    this.amountPaid,
    this.userid,
  });
  factory BookingModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookingModel(
     id: doc.id,
      activityId: data['activityId'],
      title: data['title'],
      category: data['category'],
      date: data['date'] != null ? (data['date'] as Timestamp).toDate() : null,
      time: data['time'],
      tickets: data['tickets'],
      amountPaid: double.parse(data['amountPaid'].toString()),
      userid:data['userid'],
      eventManagerId: data['eventManagerId']??'',
      eventer:data['eventer']??'',
        status: data['status']??0
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'userid':userid,
      'activityId': activityId,
      'title': title,
      'category': category,
      'date': date,
      'time': time,
      'tickets': tickets,
      'amountPaid': amountPaid,
      'status':0
    };
  }
}
