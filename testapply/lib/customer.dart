class Customer {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String additionalInfo;

  Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.additionalInfo,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'email': email,
    'additionalInfo': additionalInfo,
  };

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json['id'],
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    email: json['email'],
    additionalInfo: json['additionalInfo'],
  );
}
