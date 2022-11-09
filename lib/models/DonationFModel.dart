class DonationFModel {
  String id = '';
  final double rate;
  final String feedback;
  final String date;

  DonationFModel({
    required this.id,
    required this.rate,
    required this.feedback,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'rate': rate,
    'feedback': feedback,
    'date': date
  };

  static DonationFModel fromJson(Map<String, dynamic> json) => DonationFModel(
      id: json['id'],
      rate: json['rate'],
      feedback: json['feedback'],
      date: json['date']
  );
}