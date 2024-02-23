import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: RegisterFormPage(),
  ));
}

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _lifeStoryController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Форма Регистрации'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'ФИО',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ваше полное имя';
                  }
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Номер телефона',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ваш номер телефона';
                  }
                  // Здесь можно добавить более сложную логику проверки
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Адрес электронной почты',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ваш адрес электронной почты';
                  }
                  // Здесь можно добавить логику проверки адреса электронной почты
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Страна',
                ),
                value: _selectedCountry,
                items: ['Казахстан', 'Россия', 'Америка'].map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, выберите вашу страну';
                  }
                  return null;
                },
              ),
              SizedBox(height: 28),
              TextFormField(
                controller: _lifeStoryController,
                decoration: InputDecoration(
                  labelText: 'Биография',
                ),
                validator: (value) {
                  // Здесь можно добавить логику проверки
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите пароль';
                  }
                  // Здесь можно добавить логику проверки сложности пароля
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Подтвердите пароль',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, подтвердите ваш пароль';
                  }
                  // Здесь можно добавить логику проверки совпадения паролей
                  if (value != _passwordController.text) {
                    return 'Пароли не совпадают';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Показать диалог успешной регистрации
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Регистрация успешна'),
                        content: Text(
                            '${_fullNameController.text} теперь зарегистрирован'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NextPage(
                                    fullName: _fullNameController.text,
                                    phoneNumber: _phoneNumberController.text,
                                    emailAddress: _emailController.text,
                                    country: _selectedCountry!,
                                  ),
                                ),
                              );
                            },
                            child: Text('Подтвердить'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
                child: Text(
                  'Отправить форму',
                  style: TextStyle(color: Color.fromARGB(255, 232, 213, 128)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final String emailAddress;
  final String country;

  NextPage({
    required this.fullName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Информация о пользователе'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'ФИО: $fullName',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                'Номер телефона: $phoneNumber',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Адрес электронной почты: $emailAddress',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                'Страна: $country',
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Здесь можно отобразить другую информацию о пользователе аналогичным образом
          ],
        ),
      ),
    );
  }
}
