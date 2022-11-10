class Orders {
  String id = '';
  // String uid = '';
  final String name;
  final String address;
  final String mobile;
  final String productName;
  final String qty;
  final String totalPrice;
  final String state;

  Orders({
    required this.name,
    required this.address,
    required this.mobile,
    required this.productName,
    required this.qty,
    required this.totalPrice,
    required this.state,
    required this.id,
    // required this.uid
  });

  Map<String, dynamic> toJson() => {
    'id':id,
    // 'uid': uid,
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
      // uid: json['uid'],
      name: json['name'],
      address: json['address'],
      mobile: json['mobile'],
      productName: json['productName'],
      qty: json['qty'],
      totalPrice: json['totalPrice'],
      state: json['state']
  );
}