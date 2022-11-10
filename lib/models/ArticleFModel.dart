class ArticleFModel {
  String id = '';
  final String name;
  final String feedback;
  final String date;

  ArticleFModel({
    required this.id,
    required this.name,
    required this.feedback,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'feedback': feedback,
    'date': date
  };

  static ArticleFModel fromJson(Map<String, dynamic> json) => ArticleFModel(
      id: json['id'],
      name: json['name'],
      feedback: json['feedback'],
      date: json['date']
  );
}