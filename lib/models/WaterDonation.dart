class WaterDonation {
  String id = '';
  final String name;
  final int age;
  final String birthday;

  WaterDonation({
    required this.id,
    required this.name,
    required this.age,
    required this.birthday
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'birthday': birthday
  };

  static WaterDonation fromJson(Map<String, dynamic> json) => WaterDonation(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      birthday: json['birthday']
  );
}