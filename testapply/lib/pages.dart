import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'order.dart';
import 'customer.dart';

class LoginPage extends StatelessWidget {
  final List<Customer> customers;
  final List<Order> orders;

  LoginPage({required this.customers, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход или Регистрация'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Text(
                    'Регистрация',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(customers: customers, orders: orders)),
                    );
                  },
                  child: Text(
                    'Войти',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minimumSize: Size(200.0, 80.0),
              ),
              onPressed: () {
                saveUserData(emailController.text, passwordController.text);
                Navigator.pop(context);
              },
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveUserData(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }
}

class LoginScreen extends StatelessWidget {
  final List<Customer> customers;
  final List<Order> orders;

  LoginScreen({required this.customers, required this.orders});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minimumSize: Size(100.0, 80.0),
              ),
              onPressed: () {
                getUserData().then((userData) {
                  if (userData['email'] == emailController.text &&
                      userData['password'] == passwordController.text) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDashboardPage(customers: customers, orders: orders)),
                    );
                  }
                });
              },
              child: Text(
                'Войти',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    return {'email': email, 'password': password};
  }
}

class UserDashboardPage extends StatelessWidget {
  final List<Customer> customers;
  final List<Order> orders;

  UserDashboardPage({required this.customers, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Панель пользователя'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerCreationPage(customers: customers)),
                    );
                  },
                  child: Text(
                    'Создать заказчика',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateOrderPage(customers: customers, orders: orders),
                      ),
                    );
                  },
                  child: Text(
                    'Создание заказа на производстве',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderListPage(orders: orders)),
                );
              },
              child: Text(
                'Список заказов',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerCreationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController additionalInfoController = TextEditingController();
  final List<Customer> customers;

  CustomerCreationPage({required this.customers});

  void createCustomer(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;
    String additionalInfo = additionalInfoController.text;

    Customer newCustomer = Customer(
      id: UniqueKey().toString(),
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      additionalInfo: additionalInfo,
    );

    customers.add(newCustomer);

    List<String> customersJson = customers.map((customer) {
      return json.encode(customer.toJson());
    }).toList();

    await prefs.setStringList('customers', customersJson);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать заказчика'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'ФИО заказчика'),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Номер телефона'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email заказчика'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: additionalInfoController,
                decoration: InputDecoration(labelText: 'Дополнительные сведения'),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: Size(200.0, 80.0),
                ),
                onPressed: () {
                  createCustomer(context);
                },
                child: Text(
                  'Создать заказчика',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateOrderPage extends StatefulWidget {
  final List<Customer> customers;
  final List<Order> orders;

  CreateOrderPage({required this.customers, required this.orders});

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final TextEditingController timeController = TextEditingController();
  Customer? selectedCustomer;
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание заказа на производстве'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<Customer>(
                value: selectedCustomer,
                items: widget.customers.map((customer) {
                  return DropdownMenuItem<Customer>(
                    value: customer,
                    child: Text(customer.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCustomer = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Выберите заказчика'),
              ),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Дата производства'),
              ),
              DropdownButtonFormField<String>(
                value: selectedServices.isNotEmpty ? selectedServices[0] : null,
                items: ['Упаковка продукции', 'Сборка изделий', 'Транспортировка']
                    .map((service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedServices = [value!];
                  });
                },
                decoration: InputDecoration(labelText: 'Выберите услугу на производстве'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: Size(200.0, 80.0),
                ),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  if (selectedCustomer != null && selectedServices.isNotEmpty) {
                    String time = timeController.text;
                    Customer customer = selectedCustomer!;

                    Order newOrder = Order(
                      id: UniqueKey().toString(),
                      customer: customer,
                      cleaningTime: time,
                      services: selectedServices,
                    );

                    widget.orders.add(newOrder);

                    List<String> ordersJson = widget.orders.map((order) {
                      return json.encode(order.toJson());
                    }).toList();

                    await prefs.setStringList('orders', ordersJson);

                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Создать заказ на производстве',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderListPage extends StatelessWidget {
  final List<Order> orders;

  OrderListPage({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список заказов'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Заказчик: ${order.customer.name}'),
            subtitle: Text('Дата производства: ${order.cleaningTime}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Услуги: ${order.services.join(", ")}'),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditOrderPage(order: order, orders: orders),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditOrderPage extends StatefulWidget {
  final Order order;
  final List<Order> orders;

  EditOrderPage({required this.order, required this.orders});

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  final TextEditingController timeController = TextEditingController();
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();
    timeController.text = widget.order.cleaningTime;
    selectedServices = List.from(widget.order.services);
  }

  void saveChanges(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final updatedOrder = Order(
      id: widget.order.id,
      customer: widget.order.customer,
      cleaningTime: timeController.text,
      services: selectedServices,
    );

    final index = widget.orders.indexWhere((order) => order.id == widget.order.id);

    if (index != -1) {
      widget.orders[index] = updatedOrder;

      List<String> ordersJson = widget.orders.map((order) {
        return json.encode(order.toJson());
      }).toList();

      await prefs.setStringList('orders', ordersJson);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать заказ'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Дата производства'),
              ),
              DropdownButtonFormField<String>(
                value: selectedServices.isNotEmpty ? selectedServices[0] : null,
                items: ['Упаковка продукции', 'Сборка изделий', 'Транспортировка']
                    .map((service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedServices = [value!];
                  });
                },
                decoration: InputDecoration(labelText: 'Выберите услугу на производстве'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: Size(200.0, 80.0),
                ),
                onPressed: () async {
                  saveChanges(context);
                },
                child: Text(
                  'Сохранить изменения',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
