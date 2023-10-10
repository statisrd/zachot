import 'package:flutter/material.dart';

void main() => runApp(OrderManagementApp());

class OrderManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Management',
      theme: ThemeData.dark(),
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход в систему'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
              decoration: InputDecoration(labelText: 'Логин'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(labelText: 'Пароль'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderManagementScreen(
                          username: _username,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white54,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textStyle: TextStyle(fontSize: 20 * 1.7),
                  ),
                  child: Text(
                    'Войти',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationForm(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white54,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textStyle: TextStyle(fontSize: 20 * 1.7),
                  ),
                  child: Text(
                    'Регистрация',
                    style: TextStyle(fontSize: 20),
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

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(labelText: 'Введите email'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(labelText: 'Введите пароль'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(labelText: 'Повторите пароль'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_password == _confirmPassword) {
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Ошибка'),
                        content: Text('Пароли не совпадают.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('ОК'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white54,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                textStyle: TextStyle(fontSize: 20 * 1.7),
              ),
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderManagementScreen extends StatefulWidget {
  final String username;

  OrderManagementScreen({required this.username});

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  List<Customer> _customers = [];
  List<Task> _tasks = [];
  TextEditingController taskController = TextEditingController();
  Customer? _selectedCustomer;
  Task? _selectedTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Менеджер заказов'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomerForm(
                          onSave: (customer) {
                            setState(() {
                              _customers.add(customer);
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white54,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textStyle: TextStyle(fontSize: 20 * 1.7),
                  ),
                  child: Text('Создать заказчика', style: TextStyle(fontSize: 20)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return TaskForm(
                          customers: _customers,
                          onSave: (task) {
                            setState(() {
                              _tasks.add(task);
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white54,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textStyle: TextStyle(fontSize: 20 * 1.7),
                  ),
                  child: Text('Создать задачу', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListScreen(
                      tasks: _tasks,
                      customers: _customers,
                      username: widget.username,
                      onTaskSelected: (task) {
                        setState(() {
                          _selectedTask = task;
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white54,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                textStyle: TextStyle(fontSize: 20 * 1.7),
              ),
              child: Text('Список задач', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerForm extends StatefulWidget {
  final Function(Customer) onSave;

  CustomerForm({required this.onSave});

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  String _name = '';
  String _phoneNumber = '';
  String _email = '';
  String _additionalInfo = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Создать заказчика', style: TextStyle(fontSize: 20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              _name = value;
            },
            decoration: InputDecoration(labelText: 'ФИО'),
          ),
          TextField(
            onChanged: (value) {
              _phoneNumber = value;
            },
            decoration: InputDecoration(labelText: 'Номер телефона'),
          ),
          TextField(
            onChanged: (value) {
              _email = value;
            },
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            onChanged: (value) {
              _additionalInfo = value;
            },
            decoration: InputDecoration(labelText: 'Дополнительные сведения'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(Customer(
              name: _name,
              phoneNumber: _phoneNumber,
              email: _email,
              additionalInfo: _additionalInfo,
            ));
          },
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}

class TaskForm extends StatefulWidget {
  final List<Customer> customers;
  final Function(Task) onSave;
  final Task? initialTask;

  TaskForm({required this.customers, required this.onSave, this.initialTask});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  String _task = '';
  Customer? _selectedCustomer;
  DateTime? _dueDate;
  String _priority = 'Low';

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      _selectedCustomer = widget.initialTask!.customer;
      _task = widget.initialTask!.task;
      _dueDate = widget.initialTask!.dueDate;
      _priority = widget.initialTask!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTask != null ? 'Редактировать задачу' : 'Создать задачу', style: TextStyle(fontSize: 20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<Customer>(
            value: _selectedCustomer,
            onChanged: (value) {
              setState(() {
                _selectedCustomer = value;
              });
            },
            items: widget.customers.map((customer) {
              return DropdownMenuItem<Customer>(
                value: customer,
                child: Text(customer.name),
              );
            }).toList(),
          ),
          TextField(
            onChanged: (value) {
              _task = value;
            },
            decoration: InputDecoration(labelText: 'Задача'),
          ),
          TextField(
            onChanged: (value) {
              _priority = value;
            },
            decoration: InputDecoration(labelText: 'Приоритет'),
          ),
          Row(
            children: [
              Text('Срок выполнения: '),
              IconButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        _dueDate = pickedDate;
                      });
                    }
                  });
                },
                icon: Icon(Icons.date_range),
              ),
              if (_dueDate != null) Text("${_dueDate!.toLocal()}".split(' ')[0]),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(Task(
              customer: _selectedCustomer!,
              task: _task,
              dueDate: _dueDate,
              priority: _priority,
              createdBy: widget.customers[0],
            ));
          },
          child: Text(widget.initialTask != null ? 'Обновить' : 'Сохранить'),
        ),
      ],
    );
  }
}


class TaskListScreen extends StatelessWidget {
  final List<Task> tasks;
  final List<Customer> customers;
  final String username;
  final Function(Task) onTaskSelected;

  TaskListScreen({required this.tasks, required this.customers, required this.username, required this.onTaskSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список задач'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Заказчик: ${tasks[index].customer.name}'),
            subtitle: Text('Задача: ${tasks[index].task}\nСоздал: $username'),
            onTap: () {
              onTaskSelected(tasks[index]);
              Navigator.pop(context);
            },
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Вызов формы редактирования задачи
                showDialog(
                  context: context,
                  builder: (context) {
                    return TaskForm(
                      customers: customers,
                      onSave: (editedTask) {
                        // Обновление задачи в списке
                        tasks[index] = editedTask;
                        Navigator.pop(context);
                      },
                      initialTask: tasks[index], // Передаем выбранную задачу для редактирования
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Customer {
  final String name;
  final String phoneNumber;
  final String email;
  final String additionalInfo;

  Customer({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.additionalInfo,
  });
}

class Task {
  Customer customer;
  String task;
  DateTime? dueDate; // Add dueDate property
  String priority; // Add priority property
  final Customer createdBy;

  Task({
    required this.customer,
    required this.task,
    this.dueDate,
    this.priority = 'Low', // Default value for priority
    required this.createdBy,
  });
}

