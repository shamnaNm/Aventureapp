class Ticket {
  final String ticketNumber;
  final String eventer;
  final String activity;
  final String category;
  final double amountPaid;
  final int numberOfTickets;
  final DateTime? date;
 final String? time;
  Ticket({
       this.date,
       this.time,
    required this.ticketNumber,
    required this.eventer,
    required this.activity,
    required this.category,
    required this.amountPaid,
    required this.numberOfTickets,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketNumber: json['ticketNumber'] ?? '',
      eventer: json['eventer'] ?? '',
      activity: json['activity'] ?? '',
      category: json['category'] ?? '',
      amountPaid: json['amountPaid'] ?? 0.0,
      numberOfTickets: json['numberOfTickets'] ?? 0,
      date: json['date']?.toDate()?? 0, // Assuming `date` is stored as a Firestore timestamp
      time: json['time']?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketNumber': ticketNumber,
      'eventer': eventer,
      'activity': activity,
      'category': category,
      'amountPaid': amountPaid,
      'numberOfTickets': numberOfTickets,
      'date':date,
      'time':time,
    };
  }
}
