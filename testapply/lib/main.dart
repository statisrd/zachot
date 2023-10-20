import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'order.dart';
import 'customer.dart';
import 'pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? customersJson = prefs.getStringList('customers');
  List<String>? ordersJson = prefs.getStringList('orders');

  List<Customer> customers = customersJson != null
      ? customersJson.map((customerJson) {
    return Customer.fromJson(json.decode(customerJson));
  }).toList()
      : [];

  List<Order> orders = ordersJson != null
      ? ordersJson.map((orderJson) {
    return Order.fromJson(json.decode(orderJson));
  }).toList()
      : [];

  runApp(MaterialApp(
    home: LoginPage(customers: customers, orders: orders),
    theme: ThemeData.dark(),
  ));
}
