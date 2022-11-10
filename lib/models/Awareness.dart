class AwarenessModel {
  String id = '';
  final String name;
  final String description;
  final String date;
  final String time;
  final String type;
  final String venue;

  AwarenessModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.type,
    required this.venue
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'date': date,
    'time': time,
    'type': type,
    'venue': venue
  };

  static AwarenessModel fromJson(Map<String, dynamic> json) => AwarenessModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      type: json['type'],
      venue: json['venue']
  );
}