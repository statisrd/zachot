import 'package:flutter/material.dart';

void main() => runApp(TaskManagerApp());

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
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
        title: Text('Регистрация'),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskManagerScreen(
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
                // Увеличьте размер кнопки на 70%
                textStyle: TextStyle(fontSize: 20 * 1.7),
              ),
              child: Text(
                'Войти',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskManagerScreen extends StatefulWidget {
  final String username;

  TaskManagerScreen({required this.username});

  @override
  _TaskManagerScreenState createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  List<Customer> _customers = [];
  List<Task> _tasks = [];
  TextEditingController taskController = TextEditingController();
  Customer? _selectedCustomer;
  Task? _selectedTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Менеджер задач'),
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
                    // Увеличьте размер кнопки на 70%
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
                    // Увеличьте размер кнопки на 70%
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
                // Увеличьте размер кнопки на 70%
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

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      _selectedCustomer = widget.initialTask!.customer;
      _task = widget.initialTask!.task;
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
  final Customer createdBy;

  Task({
    required this.customer,
    required this.task,
    required this.createdBy,
  });
}
