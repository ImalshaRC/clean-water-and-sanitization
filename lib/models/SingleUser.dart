class SingleUser {
  String uid = '';
  final String firstName;
  final String lastName;
  final String age;
  final String email;

  SingleUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email
  });

  Map<String, dynamic> toJson() =>
      {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'email': email
      };

  static SingleUser fromJson(Map<String, dynamic> json) =>
      SingleUser(
        uid: json['uid'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        age: json['age'],
        email: json['email'],
      );
}
