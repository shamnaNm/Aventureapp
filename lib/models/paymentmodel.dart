import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String activityId;
  final String eventManagerId;
  final String userId;
  final double amountPaid;
  final DateTime dateTime;

  PaymentModel({
    required this.activityId,
    required this.eventManagerId,
    required this.userId,
    required this.amountPaid,
    required this.dateTime,
  });

  factory PaymentModel.fromDocument(DocumentSnapshot doc) {
    return PaymentModel(
      activityId: doc['activityId'],
      eventManagerId: doc['eventManagerId'],
      userId: doc['userId'],
      amountPaid: doc['amountPaid'],
      dateTime: (doc['dateTime'] as Timestamp).toDate(),
    );
  }
}
