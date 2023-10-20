import 'customer.dart';

class Order {
  final String id;
  final Customer customer;
  String cleaningTime;
  List<String> services;

  Order({
    required this.id,
    required this.customer,
    required this.cleaningTime,
    required this.services,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'customer': customer.toJson(),
    'cleaningTime': cleaningTime,
    'services': services,
  };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['id'],
    customer: Customer.fromJson(json['customer']),
    cleaningTime: json['cleaningTime'],
    services: List<String>.from(json['services']),
  );
}
