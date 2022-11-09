class SingleUser {
  String uid = '';
  final String firstName;
  final String lastName;
  final String age;
  final String phoneNo;
  final String address;
  final String email;

  SingleUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNo,
    required this.address,
    required this.email
  });

  Map<String, dynamic> toJson() =>
      {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'phoneNo': phoneNo,
        'address':address,
        'email': email
      };

  static SingleUser fromJson(Map<String, dynamic> json) =>
      SingleUser(
        uid: json['uid'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        age: json['age'],
        phoneNo: json['phoneNo'],
        address: json['address'],
        email: json['email'],
      );
}
