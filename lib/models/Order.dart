class Orders {
  String id = '';
  final String name;
  final String address;
  final String mobile;
  final String productName;
  final String qty;
  final String totalPrice;
  final String state;

  Orders({
    required this.id,
    required this.name,
    required this.address,
    required this.mobile,
    required this.productName,
    required this.qty,
    required this.totalPrice,
    required this.state
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'mobile': mobile,
    'productName': productName,
    'qty': qty,
    'totalPrice' : totalPrice,
    'state' : state
  };

  static Orders fromJson(Map<String, dynamic> json) => Orders(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      mobile: json['mobile'],
      productName: json['productName'],
      qty: json['qty'],
      totalPrice: json['totalPrice'],
      state: json['state']
  );
}