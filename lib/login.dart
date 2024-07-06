import 'package:flutter/material.dart';
import 'package:pink_coffee/dashboard.dart';
import 'package:pink_coffee/database/table_user.dart';
import 'package:pink_coffee/model/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Tuser db = Tuser();

  @override
  void initState() {
    // addUser();
    super.initState();
  }

  void validate() async {
    List? data = await db.findUser(email.text);

    if (data!.isNotEmpty) {
      if (data[0]['password'] == password.text) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        _showAlertDialog(
            context, 'Wrong Password', 'Password yang anda masukan salah');
      }
    } else {
      if (email.text == '' || password.text == '') {
        _showAlertDialog(context, 'Empty Form', 'Form tidak boleh kosong');
      } else {
        _showAlertDialog(context, 'Not Found', 'Email tidak ditemukan');
      }
    }
    // print(password.text);
  }

  void _showAlertDialog(BuildContext context, title, msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addUser() async {
    await db.saveUser(User(email: 'admin@gmail.com', password: "12345"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 64, 125, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 200,
                color: Colors.white,
              ),
              Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.red),
                        prefixIcon: const Icon(Icons.mail),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 64, 125, 1), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 64, 125, 1), width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: Color.fromRGBO(255, 64, 125, 1)),
                        prefixIcon: const Icon(Icons.key),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 64, 125, 1), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 64, 125, 1), width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        validate();
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(255, 64, 125, 1)),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.fromLTRB(120, 15, 120, 15))),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 64, 125, 1),
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
