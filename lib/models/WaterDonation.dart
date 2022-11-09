class WaterDonation {
  String id = '';
  final String name;
  final String address;
  final String mobile;
  final String liter;
  final String phi;

  WaterDonation({
    required this.id,
    required this.name,
    required this.address,
    required this.mobile,
    required this.liter,
    required this.phi,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'mobile': mobile,
    'liter': liter,
    'phi': phi
  };

  static WaterDonation fromJson(Map<String, dynamic> json) => WaterDonation(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      mobile: json['mobile'],
      liter: json['liter'],
      phi: json['phi']
  );
}