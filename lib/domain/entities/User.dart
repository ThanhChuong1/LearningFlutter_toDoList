class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    final fullAddress =
        '${address['suite']}, ${address['street']}, ${address['city']}, ${address['zipcode']}';
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: fullAddress,
    );
  }
}
