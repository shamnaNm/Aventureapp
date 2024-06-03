class GenReview {
  final String userName;
  final double rating;
  final String reviewText;
  final DateTime date;
  final String activityTitle; // Add this field
  final String uid;
  GenReview({
    required this.userName,
    required this.rating,
    required this.reviewText,
    required this.date,
    required this.activityTitle,required this.uid, // Add this field
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'rating': rating,
      'reviewText': reviewText,
      'date': date.toIso8601String(),
      'activityTitle': activityTitle,'uid': uid,
      // Add this field
    };
  }

  static GenReview fromMap(Map<String, dynamic> map) {
    return GenReview(
      userName: map['userName'],
      rating: map['rating'],
      reviewText: map['reviewText'],
      date: DateTime.parse(map['date']),
      activityTitle: map['activityTitle'],
      uid: map['uid'],  // Add this field
    );
  }
}
